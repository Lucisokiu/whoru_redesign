import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/pages/call/videocall/video_call_creen.dart';
import 'package:whoru/src/utils/token.dart';

class WebSocketService {
  final String _url;
  late IOWebSocketChannel _channel;
  final StreamController<dynamic> _controller = StreamController.broadcast();

  WebSocketService(this._url);

  Future<void> connect() async {
    int? id = await getIdUser();
    _channel = IOWebSocketChannel.connect(_url);
    _channel.stream.listen(
      (dynamic message) {
        print("WebSocketService $message");
        _controller.add(message);
      },
      onError: (error) {
        print("WebSocketService Error: $error");
      },
      onDone: () {
        print("WebSocketService Connection Closed");
      },
    );
    onConnected(_channel, {"protocol": "json", "version": 1});
    Online(_channel, {
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

  void Online(IOWebSocketChannel channel, Map<String, dynamic> messageData) {
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
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Incoming Call',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.topCenter,
                child: Text('Call from $caller'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => VideoCallScreen(
                                    idUser: caller,
                                    currentId: receiver,
                                    webSocketService: webSocketService,
                                    isJoinRoom: true,
                                  )));
                    },
                    icon: Icon(Icons.call),
                    color: Colors.green, // Màu nền của nút xanh lá
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Đóng hộp thoại khi kết thúc cuộc gọi
                    },
                    icon: Icon(Icons.call_end),
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
