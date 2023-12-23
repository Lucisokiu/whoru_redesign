import 'package:flutter/material.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/pages/chat/screens/SelectContact.dart';
import 'package:whoru/src/pages/chat/widget/CustomCard.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.chatmodels, required this.currentId});

  final List<ChatModel> chatmodels;
  final int currentId;

  @override
  _ChatPageState createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
