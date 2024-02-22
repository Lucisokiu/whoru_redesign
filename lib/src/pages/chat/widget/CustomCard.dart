import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/model/UserChat.dart';
import 'package:whoru/src/pages/chat/screens/IndividualPage.dart';
import 'package:whoru/src/socket/WebSocketService.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,required this.webSocketService, required this.chatModel, required this.currentId});
  final WebSocketService webSocketService;
  final ChatModel chatModel;
  final int currentId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPage(
                  webSocketService: webSocketService,
                      user: UserChat.fromChatModel(chatModel),
                      currentId: currentId,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: ClipOval(
              child: Image.network(
                chatModel.avatar,
                // color : Colors.white,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              chatModel.fullName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.type),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
