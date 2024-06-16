import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/models/chat_model.dart';

class WaitListChatPage extends StatefulWidget {
  const WaitListChatPage({super.key, required this.currentId});

  final int currentId;

  @override
  State<WaitListChatPage> createState() => _WaitListChatPageState();
}

class _WaitListChatPageState extends State<WaitListChatPage> {
  List<ChatModel> chatmodels = [];
  int page = 0;
  Future<void> getUser() async {
    chatmodels = await getAllUserChat(++page);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // appBar: AppBar(
        //   title: const Text("Message"),
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios_sharp),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        // body: ListView.builder(
        //   itemCount: chatmodels.length,
        //   itemBuilder: (contex, index) => CustomCard(
        //     chatModel: chatmodels[index],
        //     currentId: widget.currentId,
        //   ),
        // ),
        );
  }
}
