import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  final String _url;
  late WebSocketChannel _channel;
  final StreamController<dynamic> _controller = StreamController.broadcast();

  WebSocketService(this._url);

  Future<void> connect() async {
    _channel = IOWebSocketChannel.connect(_url);
    _channel.stream.listen((dynamic message) {
      _controller.add(message);
    });
  }


  Stream<dynamic> get onMessage => _controller.stream;

}