import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/models/chat_model.dart';
import 'package:whoru/src/pages/chat/screens/select_contact.dart';
import 'package:whoru/src/pages/chat/screens/wait_list_message_screen.dart';
import 'package:whoru/src/pages/chat/widget/custom_card.dart';
import 'package:whoru/src/pages/chat/widget/search_user.dart';
import 'package:whoru/src/pages/feed/widget/skeleton_loading.dart';

import '../../socket/web_socket_service.dart';
import '../user/controller/language/app_localization.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.currentId});

  final int currentId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chatmodels = [];
  // final NotificationController _notificationController =
  //     NotificationController();
  int page = 0;
  WebSocketService webSocketService = WebSocketService();
  late StreamSubscription<dynamic> messageSubscription;
  Future<void> getUserChat() async {
    final result = await getAllUserChat(++page);
    if (mounted) {
      setState(() {
        chatmodels.addAll(result);
      });
    }
  }

  @override
  void initState() {
    getUserChat();
    super.initState();
    listenSocket();
  }

  void listenSocket() {
    messageSubscription = webSocketService.onMessage.listen((event) {
      Map<dynamic, dynamic> jsonData = event;
      print(event);
      if (jsonData['type'] == 1) {
        String? target = jsonData['target'];
        if (target == "ReceiveMessage" || target == 'SendMessage') {
          getUserChat();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    messageSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).getTranslatedValues('message')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      endDrawer: Drawer(
          child:
              ListView(padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0), children: [
        ListTile(
          leading: Icon(PhosphorIcons.chatTeardropText(PhosphorIconsStyle.thin),
              color: Theme.of(context).iconTheme.color),
          title: Text(AppLocalization.of(context).getTranslatedValues('waitinglistmessage'),
              style: Theme.of(context).textTheme.bodyMedium),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    WaitListChatPage(currentId: widget.currentId),
              ),
            );
          },
        ),
          
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: SearchUserChat(),
          );
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (builder) => const SelectContact()));
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: chatmodels.isEmpty
          ? const MySkeletonLoadingWidget()
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
