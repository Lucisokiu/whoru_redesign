import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/socket/web_socket_service.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen(
      {super.key,
      bool? isJoinRoom,
      required this.idUser,
      required this.currentId})
      : isJoinRoom = isJoinRoom ?? false;

  final bool isJoinRoom;
  final int idUser;
  final int currentId;

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  // Thêm hai đối tượng RTCVideoRenderer cho luồng cục bộ và từ xa
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  // Thêm các biến trạng thái cho các nút //**
  bool _isMicOn = true;
  bool _isAudioOn = true;
  bool _isVideoOn = true;
  bool isShowButton = true;
  late StreamSubscription<dynamic> messageSubscription;
  WebSocketService webSocketService = WebSocketService();

  @override
  void initState() {
    super.initState();
    initWebRTC();
  }

  @override
  void dispose() {
    _hangUp();
    super.dispose();
  }

  Future<void> initWebRTC() async {
    // Khởi tạo các đối tượng RTCVideoRenderer
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    await _listenServer();
    await _createPeerConnection();
    await registerListeners();

    await _getUserMedia();
    if (widget.isJoinRoom) {
      makeCall();
    } else {
      sendNotif();
    }
  }

  Future<void> _listenServer() async {
    messageSubscription = webSocketService.onMessage.listen((event) async {
      Map<dynamic, dynamic> jsonData = event;

      int type = jsonData['type'];

      if (type == 1) {
        String target = jsonData["target"];
        print("target---------------------------: $target");

        if (target == 'DisconnectCalling') {
          webSocketService.endCall(widget.currentId, widget.idUser);
          Navigator.pop(context);
        }
        if (target == 'isCalling') {
          webSocketService.endCall(widget.currentId, widget.idUser);
          Navigator.pop(context);
        }
        if (target == "ReceiveOffer") {
          List<dynamic> arguments = jsonData["arguments"];
          dynamic offerData = arguments[2];

          Map<dynamic, dynamic> receiveData = jsonDecode(offerData);
          String eventData = receiveData["event"];
          if (eventData == "offer") {
            _peerConnection!.setRemoteDescription(
              RTCSessionDescription(
                receiveData["data"]["sdp"],
                receiveData["data"]["type"],
              ),
            );

            // Create an answer
            RTCSessionDescription answer =
                await _peerConnection!.createAnswer();
            await _peerConnection!.setLocalDescription(answer);

            webSocketService.sendMessageSocket("SendOffer", [
              widget.currentId,
              widget.idUser,
              jsonEncode({"event": "answer", "data": answer.toMap()})
            ]);
            _peerConnection!.onAddStream = (MediaStream stream) {
              _remoteRenderer.srcObject = stream;
              setState(() {});
            };
          }
          if (eventData == "answer") {
            _peerConnection!.setRemoteDescription(
              RTCSessionDescription(
                receiveData["data"]["sdp"],
                receiveData["data"]["type"],
              ),
            );
          }
          if (eventData == "ice") {
            _peerConnection!.addCandidate(RTCIceCandidate(
                receiveData["data"]["candidate"],
                receiveData["data"]["sdpMid"],
                receiveData["data"]["sdpMLineIndex"]));
          }
        }
      }
    });
  }

  Future<void> _createPeerConnection() async {
    Map<String, dynamic> configuration = {
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    };
    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };
    _peerConnection =
        await createPeerConnection(configuration, offerSdpConstraints);

    setState(() {});
  }

  Future<void> _getUserMedia() async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      "audio": true,
      "video": true,
    });

    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });
    _localRenderer.srcObject = _localStream;

    setState(() {});
  }

  Future<void> registerListeners() async {
    _peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {};

    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      webSocketService.sendMessageSocket("SendOffer", [
        widget.currentId,
        widget.idUser,
        jsonEncode({"event": "ice", "data": candidate.toMap()})
      ]);
    };
    _peerConnection?.onConnectionState = (RTCPeerConnectionState state) {};

    _peerConnection?.onSignalingState = (RTCSignalingState state) {};

    _peerConnection?.onTrack = ((tracks) {
      tracks.streams[0].getTracks().forEach((track) {
        _remoteStream?.addTrack(track);
        setState(() {});
      });
    });
    _peerConnection?.onAddStream = (MediaStream stream) {
      print('onAddStream');
      _remoteRenderer.srcObject = stream;
      setState(() {});
    };
  }

  void makeCall() async {
    // Creating a offer for remote peer
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    await _peerConnection!.setLocalDescription(offer);
    // Sending the offer
    webSocketService.sendMessageSocket("SendOffer", [
      widget.currentId,
      widget.idUser,
      jsonEncode({"event": "offer", "data": offer.toMap()})
    ]);
  }

  void sendNotif() {
    webSocketService.sendMessageSocket(
        "SendSignal", [widget.currentId, widget.idUser, "Video"]);
  }

  void _hangUp() {
    _peerConnection?.close();
    _localStream?.getTracks().forEach((track) => track.stop());
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    messageSubscription.cancel();
    webSocketService.endCall(widget.currentId, widget.idUser);
  }

  // Thêm các hàm để bật tắt mic, audio và video //**
  void _toggleMic() {
    setState(() {
      _isMicOn = !_isMicOn;
      _localStream?.getAudioTracks()[0].enabled = _isMicOn;
    });
  }

  void _toggleAudio() {
    setState(() {
      _isAudioOn = !_isAudioOn;
      _remoteStream?.getAudioTracks()[0].enabled = _isAudioOn;
    });
  }

  void _toggleVideo() {
    setState(() {
      _isVideoOn = !_isVideoOn;
      _localStream?.getVideoTracks()[0].enabled = _isVideoOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isShowButton = !isShowButton;
              print(isShowButton);
            });
          },
          child: Stack(
            children: [
              Container(
                  color: Colors.grey,
                  child: RTCVideoView(
                    _remoteRenderer,
                    mirror: true,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: SizedBox(
                      height: 25.h,
                      width: 35.w,
                      child: Container(
                        color: Colors.grey,
                        child: RTCVideoView(
                          _localRenderer,
                          mirror: true,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isShowButton)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularButton(
                            icon: Icons.mic,
                            onPressed: _toggleMic,
                            isToggled: _isMicOn,
                          ),
                          CircularButton(
                            icon: Icons.volume_up,
                            onPressed: _toggleAudio,
                            isToggled: _isAudioOn,
                          ),
                          CircularButton(
                            icon: Icons.videocam,
                            onPressed: _toggleVideo,
                            isToggled: _isVideoOn,
                          ),
                        ],
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        backgroundColor: Colors.red,
                        elevation: 0,
                        child: const Icon(Icons.call_end),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isToggled;

  const CircularButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Ink(
          padding:
              const EdgeInsets.all(8.0), // Adjust the padding to increase size

          decoration: ShapeDecoration(
            color: isToggled ? Colors.green : Colors.red,
            shape: const CircleBorder(),
          ),
          child: IconButton(
            iconSize: 30.0, // Adjust the icon size as needed

            icon: Icon(icon, color: Colors.white),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
