import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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

   WebSocketService _webSocketService = WebSocketService();


  @override
  void dispose() {
    _webSocketService.endCall(widget.idCaller, widget.idReceiver);
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
                          builder: (builder) => VideoCallScreen(
                            idUser: widget.idCaller,
                            currentId: widget.idReceiver,
                            isJoinRoom: true,
                          ),
                        ),
                      );
                    },
                    icon: PhosphorIcon(PhosphorIcons.phoneIncoming())),
                IconButton(
                    onPressed: () {

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
