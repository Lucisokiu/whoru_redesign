import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/pages/chat/controller/chatSocket.dart';
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
  void sendMessageSocket(Map<String, dynamic> messageData) {
    final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
    _channel.sink.add(message);
  }

  void close() {
    _channel.sink.close();
    print("channel.sink.close();");

  }

  Stream<dynamic> get onMessage => _controller.stream;
}
