import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../video_call_creen.dart';

class CallScreen extends StatelessWidget {
  final String fullName;
  final String avatarUrl;
  final int idCaller;
  final int idReceiver;

  CallScreen(
      {required this.fullName,
      required this.avatarUrl,
      required this.idCaller,
      required this.idReceiver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuộc gọi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            SizedBox(height: 20),
            Text(
              fullName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VideoCallScreen(
                                    idUser: idCaller,
                                    currentId: idReceiver,
                                    isJoinRoom: true,
                                  )));
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
