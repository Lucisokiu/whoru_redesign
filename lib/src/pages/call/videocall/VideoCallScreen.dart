import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/User.dart';
import 'package:whoru/src/model/UserChat.dart';
import 'package:whoru/src/service/WebSocketService.dart';

class VideoCallScreen extends StatefulWidget {
  final WebSocketService webSocketService;
  bool isJoinRoom = false;
  final int idUser;
  final int currentId;

  VideoCallScreen(
      {super.key,
      required this.webSocketService,
      bool? isJoinRoom,
      required this.idUser,
      required this.currentId})
      : isJoinRoom = isJoinRoom ?? false;

  @override
  _VideoCallScreenState createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;

  // Thêm hai đối tượng RTCVideoRenderer cho luồng cục bộ và từ xa
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  // Thêm các biến trạng thái cho các nút //**
  bool _isMicOn = true;
  bool _isAudioOn = true;
  bool _isVideoOn = true;
  bool isShowButton = true;

  @override
  void initState() {
    super.initState();
    initWebRTC();
  }

  Future<void> initWebRTC() async {
    // Khởi tạo các đối tượng RTCVideoRenderer
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    await _listenServer();
    await _createPeerConnection();
    await _getUserMedia();

    if (widget.isJoinRoom) {
      makeCall();
    }else{
      print(widget.isJoinRoom);
      sendNotif();
    }
  }

  Future<void> _listenServer() async {
    widget.webSocketService.onMessage.listen((event) async {
      var receivedMessage = event.replaceAll(String.fromCharCode(0x1E), '');
      Map<dynamic, dynamic> jsonData = jsonDecode(receivedMessage);
      int type = jsonData['type'];
      if (type == 1) {
        String target = jsonData["target"];
        if (target == "ReceiveOffer") {

          List<dynamic> arguments = jsonData["arguments"];
          String offer = arguments[3];
          print("Offer $offer");
          Map<dynamic, dynamic> receiveData = jsonDecode(offer);
          String event = receiveData["event"];
          if (event == "offer") {
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

            widget.webSocketService.sendMessageSocket("SendOffer", [
              widget.currentId,
              widget.idUser,
              jsonEncode({"event": "answer", "data": answer.toMap()})
            ]);
          }
          if (event == "answer") {
            _peerConnection!.setRemoteDescription(
              RTCSessionDescription(
                receiveData["data"]["sdp"],
                receiveData["data"]["type"],
              ),
            );
          }
          if (event == "ice") {
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

    // listen for remotePeer mediaTrack event
    _peerConnection!.onTrack = (event) {
      _remoteRenderer.srcObject = event.streams[0];
      setState(() {});
    };

    // _peerConnection!.onIceCandidate = (candidate) {
    //   if (candidate.candidate != null) {
    //     print(jsonEncode({
    //       'candidate': candidate.candidate.toString(),
    //       'sdpMid': candidate.sdpMid.toString(),
    //       'sdpMLineIndex': candidate.sdpMLineIndex,
    //     }));
    //   }
    //   String messageData = jsonEncode({"event": "ice", "data": candidate.toMap()});
    //     widget.webSocketService.sendMessageSocket(
    //       "SendOffer",messageData
    //     );
    //
    // };
  }

  Future<void> _getUserMedia() async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      "audio": true,
      "video": {"facingMode": "user"},
    });

    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });
    _localRenderer.srcObject = _localStream;

    setState(() {});
  }

  void makeCall() async {
    // Creating a offer for remote peer
    RTCSessionDescription offer = await _peerConnection!.createOffer();
    print("offer $offer");
    // Setting own SDP as local description
    await _peerConnection?.setLocalDescription(offer);

    // Sending the offer
    widget.webSocketService.sendMessageSocket("SendOffer", [
      widget.idUser,
      widget.currentId,
      jsonEncode({"event": "offer", "data": offer.toMap()})
    ]);
  }

  void sendNotif(){
    widget.webSocketService.sendMessageSocket("SendSignal", [widget.currentId,widget.idUser,"Video"]);
  }

  void _hangUp() {
    _peerConnection?.close();
    _localStream?.getTracks().forEach((track) => track.stop());

    // Giải phóng các đối tượng RTCVideoRenderer
    _localRenderer.dispose();
    _remoteRenderer.dispose();
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
      // _remoteStream?.getVideoTracks()[0].enabled = _isVideoOn;
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
              (_remoteStream != null)
                  ? Container(child: RTCVideoView(_remoteRenderer))
                  : Container(
                      color: Colors.transparent,
                    ),
              if (_localStream != null)
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
                            objectFit: RTCVideoViewObjectFit
                                .RTCVideoViewObjectFitCover,
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
                          _hangUp;
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.call_end),
                        backgroundColor: Colors.red,
                        elevation: 0,
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
          padding: EdgeInsets.all(8.0), // Adjust the padding to increase size

          decoration: ShapeDecoration(
            color: isToggled ? Colors.green : Colors.red,
            shape: CircleBorder(),
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
