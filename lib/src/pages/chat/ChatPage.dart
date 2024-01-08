import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/api/chat.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/pages/chat/screens/SelectContact.dart';
import 'package:whoru/src/pages/chat/widget/CustomCard.dart';
import 'package:whoru/src/service/WebSocketService.dart';
import 'package:whoru/src/pages/chat/controller/chatSocket.dart';
import 'package:whoru/src/utils/url.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.currentId});

  final int currentId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chatmodels = [];
  WebSocketService webSocketService = WebSocketService(socketUrl);
  late StreamSubscription<dynamic> messageSubscription;
  Future<void> getUser () async {
    chatmodels = await getAllUserChat();
    if(mounted){
    setState(() {
    });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    connected();

  }
  void connected() {
    // channel = IOWebSocketChannel.connect(socketUrl);
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
        String type = arguments[4];
        webSocketService.showCallDialog(idCaller,name,avt,idReceiver, context, webSocketService);
      }
    });

  }
  void disconnected(){
    messageSubscription.cancel();
  }
  @override
  void dispose() {
    super.dispose();
    webSocketService.close();
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => SelectContact(webSocketService: webSocketService)));
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (contex, index) =>
            CustomCard(
              webSocketService: webSocketService,
          chatModel: chatmodels[index],
          currentId: widget.currentId,
        ),
      ),
    );
  }
}
