import 'dart:convert';
import 'package:web_socket_channel/io.dart';

void onConnected(IOWebSocketChannel channel, Map<String, dynamic> messageData) {
  final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
  channel.sink.add(message);
  print(message);
}
void Online(IOWebSocketChannel channel, Map<String, dynamic> messageData) {
  final message = jsonEncode(messageData) + String.fromCharCode(0x1E);
  channel.sink.add(message);
  print(message);

}


void handleServerEvent(String message) {
  // Xử lý tin nhắn từ server
  Map<String, dynamic> data = json.decode(message);

  if (data.containsKey("H") && data["H"] == "exampleHub") {
    if (data.containsKey("M") && data["M"] == "exampleEvent") {
      // Xử lý sự kiện từ Hub
      var eventData = data["A"];
      print("Received event from exampleEvent: $eventData");
    }
  }
}