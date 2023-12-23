import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/utils/url.dart';

void sendMessage(Map<String, dynamic> messageData) {
  final channel = IOWebSocketChannel.connect(socketUrl);
  final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
  channel.sink.add(message);
}