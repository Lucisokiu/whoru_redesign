import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/call/widget/rounded_button.dart';

import '../../../socket/web_socket_service.dart';

class AudioCallScreen extends StatefulWidget {
  final String avatar;
  final String fullName;
  final bool isJoinRoom;
  final int idUser;
  final int currentId;
  const AudioCallScreen(
      {super.key,
      required this.avatar,
      required this.fullName,
      bool? isJoinRoom,
      required this.idUser, // idCaller
      required this.currentId})
      : isJoinRoom = isJoinRoom ?? false;

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
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
      "video": false,
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
        "SendSignal", [widget.currentId, widget.idUser, "VoiceCall"]);
  }

  void _hangUp() {
    _peerConnection?.close();
    _localStream?.getTracks().forEach((track) => track.stop());
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    messageSubscription.cancel();
    webSocketService.endCall(widget.idUser, widget.currentId);
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



  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image or Color
        // ...

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                // Centered CircleAvatar
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.35,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 84,
                        backgroundColor: Colors.blueGrey[200],
                        child: ClipOval(
                          child: Image.network(
                            widget.avatar,
                            height:
                                168, // Kích thước ảnh đã nhân đôi bán kính của CircleAvatar
                            width:
                                168, // Kích thước ảnh đã nhân đôi bán kính của CircleAvatar
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        widget.fullName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 3.h, // Thay đổi kích thước font ở đây
                            ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Row of RoundedButtons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Mic.svg",
                    ),
                    RoundedButton(
                      press: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Volume.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
