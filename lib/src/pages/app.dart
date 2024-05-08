import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whoru/src/utils/token.dart';

import '../socket/WebSocketService.dart';
import '../utils/url.dart';
import 'navigation/navigation.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  WebSocketService webSocketService = WebSocketService(socketUrl);
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

    messageSubscription = webSocketService.onMessage.listen((event) {
      var receivedMessage = event.replaceAll(String.fromCharCode(0x1E), '');
      // String receivedMessage = event;
      // if (receivedMessage.isNotEmpty) {
      //   receivedMessage = receivedMessage.substring(0, receivedMessage.length - 1);
      // }
      print("ChatPage $receivedMessage");
      Map<String, dynamic> message = jsonDecode(receivedMessage);

      if (message['type'] == 1 && message['target'] == 'ReceiveSignal') {
        List<dynamic> arguments = message['arguments'];
        if (arguments[0] is int) {
          int idCaller = arguments[0];
          String name = arguments[1];
          String avt = arguments[2];
          int idReceiver = arguments[3];

          if (idReceiver == _id) {
            webSocketService.showCallDialog(
                idCaller, name, avt, idReceiver, context, webSocketService);
          }
        }
      }
    });
  }

  void disconnected() {
    messageSubscription.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    // webSocketService.close();
  }

  @override
  Widget build(BuildContext context) {
    return const Navigation();
  }
}
