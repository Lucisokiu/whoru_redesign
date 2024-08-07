import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/models/chat_model.dart';
import 'package:whoru/src/pages/feed/widget/skeleton_loading.dart';

import '../../user/controller/language/app_localization.dart';
import '../widget/custom_card.dart';

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
    final result = await getAllWaitingUser(++page);
    if (mounted) {
      setState(() {
        chatmodels.addAll(result);
      });
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
        title:  Text(AppLocalization.of(context).getTranslatedValues('waitinglistmessage')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: chatmodels.isEmpty
          ? MySkeletonLoadingWidget()
          : ListView.builder(
              itemCount: chatmodels.length,
              itemBuilder: (contex, index) => CustomCard(
                chatModel: chatmodels[index],
                currentId: widget.currentId,
              ),
            ),
    );
  }
}
