import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/pages/call/audiocall/audio_call_screen.dart';
import 'package:whoru/src/socket/web_socket_service.dart';

import '../video_call_creen.dart';

class CallScreen extends StatefulWidget {
  final String fullName;
  final String avatarUrl;
  final int idCaller;
  final int idReceiver;

  const CallScreen(
      {super.key,
      required this.fullName,
      required this.avatarUrl,
      required this.idCaller,
      required this.idReceiver});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final WebSocketService _webSocketService = WebSocketService();
  late StreamSubscription<dynamic> messageSubscription;
  bool isVideoCall = false;

  @override
  void initState() {
    _listenCall();
    super.initState();
  }

  _listenCall() {
    messageSubscription = _webSocketService.onMessage.listen((event) async {
      Map<dynamic, dynamic> jsonData = event;

      int type = jsonData['type'];

      if (type == 1) {
        String target = jsonData["target"];
        print("target---------------------------: $target");
        if (target == 'ReceiveSignal') {
          List<dynamic> arguments = jsonData["arguments"];
          print("Type ReceiveSignal: $arguments");

          String type = arguments[4];
          print("Type ReceiveSignal: $type");
          if (type == "VoiceCall") {
            setState(() {
              isVideoCall = false;
            });
            print("Type ReceiveSignal: $isVideoCall");
          } else {
            print("Type ReceiveSignal: $isVideoCall");
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuộc gọi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              widget.fullName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => isVideoCall
                                ? VideoCallScreen(
                                    idUser: widget.idCaller,
                                    currentId: widget.idReceiver,
                                    isJoinRoom: true,
                                  )
                                : AudioCallScreen(
                                    avatar: widget.avatarUrl,
                                    fullName: widget.fullName,
                                    idUser: widget.idCaller,
                                    currentId: widget.idReceiver,
                                    isJoinRoom: true,
                                  )),
                      );
                    },
                    icon: PhosphorIcon(PhosphorIcons.phoneIncoming())),
                IconButton(
                    onPressed: () {
                      _webSocketService.endCall(
                          widget.idCaller, widget.idReceiver);
                      Navigator.pop(context);
                    },
                    icon: PhosphorIcon(PhosphorIcons.phoneSlash())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
