import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/pages/chat/screens/SelectContact.dart';
import 'package:whoru/src/pages/chat/widget/CustomCard.dart';
import 'package:whoru/src/socket/chatSocket.dart';
import 'package:whoru/src/utils/url.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.chatmodels, required this.currentId});

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
    // channel = IOWebSocketChannel.connect(socketUrl);
    // connected();
  }

  void connected() {

    channel.stream.listen(
      (message) {
        print(message);
        Map<String, dynamic> jsonData = jsonDecode(message);

        String target = jsonData['target'];
        List<dynamic> arguments = jsonData['arguments'];
      },
      onDone: () {
        debugPrint('ws channel closed');
      },
      onError: (error) {
        debugPrint('ws error $error');
      },
    );
    onConnected(channel,{"protocol": "json", "version": 1});
    Online(channel,{
      "arguments": [widget.currentId],
      "target": "Online",
      "type": 1
    });
  }

  @override
  void dispose() {
    // print("channel.sink.close();");
    super.dispose();
    // channel.sink.close();
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
