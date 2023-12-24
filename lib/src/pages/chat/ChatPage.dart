import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/pages/chat/screens/SelectContact.dart';
import 'package:whoru/src/pages/chat/widget/CustomCard.dart';
import 'package:whoru/src/socket/chatSocket.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatmodels, required this.currentId});

  final List<ChatModel> chatmodels;
  final int currentId;

  @override
  _ChatPageState createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {
  late IOWebSocketChannel channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
void connected(){
  onConnected({"protocol": "json", "version": 1});
  Online({"arguments":[widget.currentId],"target":"Online","type":1});
  channel.stream.listen((message) {
    // Phân tích chuỗi JSON thành một đối tượng Dart
    Map<String, dynamic> jsonData = jsonDecode(message);

    // Truy cập giá trị của các trường
    String target = jsonData['target'];
    List<dynamic> arguments = jsonData['arguments'];

    // In ra giá trị
    print('Target: $target');
    print('Arguments: $arguments');
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContact()));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (contex, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          currentId: widget.currentId,
        ),
      ),
    );
  }
}
