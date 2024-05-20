import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/pages/call/videocall/video_call_creen.dart';
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

class WebSocketService {
  final String _url;
  late IOWebSocketChannel _channel;
  final StreamController<dynamic> _controller = StreamController.broadcast();
  static WebSocketService? _instance;

  // WebSocketService(this._url);

  // Singleton pattern
  // Constructor private
  WebSocketService._internal(this._url);

  // Factory constructor
  factory WebSocketService() {
    _instance ??= WebSocketService._internal(socketUrl);
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
    online(_channel, {
      "arguments": [id],
      "target": "Online",
      "type": 1
    });
  }

  void onConnected(
      IOWebSocketChannel channel, Map<String, dynamic> messageData) {
    final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
    channel.sink.add(message);
    print(message);
  }

  void online(IOWebSocketChannel channel, Map<String, dynamic> messageData) {
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
    print(messageData);
    final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
    _channel.sink.add(message);
  }

  void close() {
    _channel.sink.close();
    print("channel.sink.close();");
  }

  void showCallDialog(int caller, String name, String avt, int receiver,
      BuildContext context, WebSocketService webSocketService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Incoming Call',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topCenter,
                child: Text('Call from $caller'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VideoCallScreen(
                                    idUser: caller,
                                    currentId: receiver,
                                    isJoinRoom: true,
                                  )));
                    },
                    icon: const Icon(Icons.call),
                    color: Colors.green,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.call_end),
                    color: Colors.red, // Màu nền của nút đỏ
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Stream<dynamic> get onMessage => _controller.stream;
}
