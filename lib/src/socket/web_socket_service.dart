import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/call/videocall/video_call_creen.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/utils/url.dart';

import '../models/location_models.dart';
import '../pages/call/videocall/screen/incoming_call.dart';
import '../pages/notification/controller/notifications_controller.dart';
import '../utils/shared_pref/iduser.dart';

class WebSocketService {
  final String _url;
  late IOWebSocketChannel _channel;
  final StreamController<dynamic> _controller = StreamController.broadcast();
  static WebSocketService? _instance;
  late StreamSubscription<dynamic> messageSubscription;

  // Singleton pattern
  // Constructor private
  WebSocketService._internal(this._url);

  // Factory constructor
  factory WebSocketService() {
    _instance ??= WebSocketService._internal(chatHubUrl);
    return _instance!;
  }

  Future<void> connect() async {
    int? id = await getIdUser();
    
    _channel = IOWebSocketChannel.connect(_url);
    _channel.stream.listen(
      (dynamic message) {
        var receivedMessages = message.split(String.fromCharCode(0x1E));
        receivedMessages.removeLast();

        for (final receivedMessage in receivedMessages) {
          Map<dynamic, dynamic> jsonData = jsonDecode(receivedMessage);
          print("Socket Data: $jsonData");
          _controller.add(jsonData);
        }
      },
      onError: (error) {
        print("WebSocketService Error: $error");
      },
      onDone: () {
        print("WebSocketService Connection Closed");
      },
    );
    onConnected(_channel, {"protocol": "json", "version": 1});
    sendMessageSocket("Online", [id]);
  }

  void onConnected(
      IOWebSocketChannel channel, Map<String, dynamic> messageData) {
    final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
    channel.sink.add(message);
    print(message);
  }

  void sendMessageSocket(String target, List arguments) {
    final messageData = {
      "type": 1,
      "target": target,
      "arguments": arguments,
    };
    print("sendMessageSocket: $messageData");
    final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
    _channel.sink.add(message);
    // _controller.add({'type': 1, 'target': 'UpdateMessage'});
  }

  void close() {
    _channel.sink.close();
    print("channel.sink.close();");
  }

  void listenCall(BuildContext context, List<dynamic> arguments) async {
    if (arguments[0] is int) {
      int idCaller = arguments[0];
      String name = arguments[1];
      String avt = arguments[2];
      int idReceiver = arguments[3];

      if (idReceiver == localIdUser) {
        print(localIdUser);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(
              avatarUrl: avt,
              fullName: name,
              idCaller: idCaller,
              idReceiver: idReceiver,
            ),
          ),
        );
      }
    }
  }

  void listenNotif(List<dynamic> arguments) {
    bool? isNotifi = NotificationsController.noti;
    if (isNotifi == true) {
      int index = arguments[0];
      String name = arguments[2];
      String avt = arguments[3];
      String title = arguments[4];
      NotificationsController.showSimpleNotification(
        index: index,
        title: name,
        body: title,
        payload: avt,
      );
    }
  }

  List<UserLocation> listenLocation() {
    List<UserLocation> locationDataList = [];

    messageSubscription = onMessage.listen((message) {
      if (message['type'] == 1 && message['target'] == 'Return_List_User') {
        List<dynamic> arguments = message['arguments'];

        if (arguments[0] == null) {
          return;
        } else {
          for (var argument in arguments) {
            for (var arg in argument) {
              print(arg);
              UserLocation location = UserLocation.fromJson(arg);
              locationDataList.add(location);
            }
          }
        }
      }

    });

    return locationDataList;
  }

  void listenSocket(BuildContext context) {
    messageSubscription = onMessage.listen((message) {
      if (message['type'] == 1 && message['target'] == 'ReceiveNotification') {
        List<dynamic> arguments = message['arguments'];
        listenNotif(arguments);
      }

      if (message['type'] == 1 && message['target'] == 'ReceiveSignal') {
        List<dynamic> arguments = message['arguments'];
        listenCall(context, arguments);
      }
    });
  }

  void endCall(idSender, idReceiver) {
    sendMessageSocket("OnDisconnectCalling", [idSender, idReceiver]);
  }

  Stream<dynamic> get onMessage => _controller.stream;
}
