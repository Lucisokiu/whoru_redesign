import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whoru/src/utils/token.dart';

import '../socket/web_socket_service.dart';
import 'call/videocall/screen/incoming_call.dart';
import 'navigation/navigation.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  WebSocketService webSocketService = WebSocketService();
  late StreamSubscription<dynamic> messageSubscription;
  int? _id;
  @override
  void initState() {
    super.initState();
    connected();
    getUser();
  }

  getUser() async {
    _id = await getIdUser();
  }

  void connected() {
    webSocketService.connect();
    messageSubscription = webSocketService.onMessage.listen((message) {
      if (message['type'] == 1 && message['target'] == 'ReceiveSignal') {
        List<dynamic> arguments = message['arguments'];
        if (arguments[0] is int) {
          int idCaller = arguments[0];
          String name = arguments[1];
          String avt = arguments[2];
          int idReceiver = arguments[3];

          if (idReceiver == _id) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CallScreen(
                          avatarUrl: avt,
                          fullName: name,
                          idCaller: idCaller,
                          idReceiver: idReceiver,
                        )));
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    webSocketService.close();
  }

  @override
  Widget build(BuildContext context) {
    return const Navigation();
  }
}
