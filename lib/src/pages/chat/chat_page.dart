import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/models/chat_model.dart';
import 'package:whoru/src/pages/chat/screens/select_contact.dart';
import 'package:whoru/src/pages/chat/screens/wait_list_message_screen.dart';
import 'package:whoru/src/pages/chat/widget/custom_card.dart';
import 'package:whoru/src/socket/WebSocketService.dart';
import 'package:whoru/src/utils/url.dart';

import 'controller/chat_notifications_controllers.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.currentId});

  final int currentId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chatmodels = [];
  WebSocketService webSocketService = WebSocketService(socketUrl);
  late StreamSubscription<dynamic> messageSubscription;
  // final NotificationController _notificationController =
  //     NotificationController();

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
    connected();
  }

  void connected() {
    webSocketService.connect();

    messageSubscription = webSocketService.onMessage.listen((event) {
      getUser();
      var receivedMessage = event.replaceAll(String.fromCharCode(0x1E), '');

      print("ChatPage $event");
      Map<String, dynamic> message = jsonDecode(receivedMessage);

      if (message['type'] == 1 && message['target'] == 'ReceiveSignal') {
        List<dynamic> arguments = message['arguments'];
        int idCaller = arguments[0];
        String name = arguments[1];
        String avt = arguments[2];
        int idReceiver = arguments[3];
        webSocketService.showCallDialog(
            idCaller, name, avt, idReceiver, context, webSocketService);
      }
    });
  }

  void disconnected() {
    messageSubscription.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    webSocketService.close();
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
      endDrawer: Drawer(
          child:
              ListView(padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0), children: [
        ListTile(
          leading: Icon(PhosphorIcons.chatTeardropText(PhosphorIconsStyle.thin),
              color: Theme.of(context).iconTheme.color),
          title: Text("Waiting list message",
              style: Theme.of(context).textTheme.bodyMedium),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WaitListChatPage(currentId: widget.currentId),
              ),
            );
          },
        ),
        ListTile(
          title: Text("Turn off notifications (Updating)",
              style: Theme.of(context).textTheme.bodyMedium),
          // leading: IconButton(
          //   icon: Icon(
          //     _notificationController.isEnabled
          //         ? Icons.toggle_on
          //         : Icons.toggle_off,
          //     color: _notificationController.isEnabled
          //         ? Colors.green
          //         : Colors.red,
          //   ),
          //   onPressed: () {
          //     _notificationController.toggleNotifications(context, getUser);
          //   },
          // ),
        ),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      SelectContact(webSocketService: webSocketService)));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
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
