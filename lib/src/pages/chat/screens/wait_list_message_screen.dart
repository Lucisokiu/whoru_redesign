import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/models/chat_model.dart';
import 'package:whoru/src/pages/chat/screens/select_contact.dart';
import 'package:whoru/src/pages/chat/widget/custom_card.dart';
import 'package:whoru/src/socket/WebSocketService.dart';
import 'package:whoru/src/utils/url.dart';


class WaitListChatPage extends StatefulWidget {
  const WaitListChatPage({super.key, required this.currentId});

  final int currentId;

  @override
  _WaitListChatPageState createState() => _WaitListChatPageState();
}

class _WaitListChatPageState extends State<WaitListChatPage> {
  List<ChatModel> chatmodels = [];
  WebSocketService webSocketService = WebSocketService(socketUrl);
  late StreamSubscription<dynamic> messageSubscription;

  Future<void> getUser() async {
    chatmodels = await getAllUserChat();
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
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (contex, index) => CustomCard(
          webSocketService: webSocketService,
          chatModel: chatmodels[index],
          currentId: widget.currentId,
        ),
      ),
    );
  }
}
