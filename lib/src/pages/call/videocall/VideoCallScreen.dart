import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sizer/sizer.dart';

class VideoCallScreen extends StatefulWidget {
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

    await _createPeerConnection();
    await _getUserMedia();
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

    _peerConnection = await createPeerConnection(configuration);

    _peerConnection!.onIceCandidate = (candidate) {
      // Xử lý sự kiện ICE candidate
    };
    // listen for remotePeer mediaTrack event
    _peerConnection!.onTrack = (event) {
      _remoteRenderer.srcObject = event.streams[0];
      setState(() {});
    };
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
                  : Container(color: Colors.transparent,),
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
