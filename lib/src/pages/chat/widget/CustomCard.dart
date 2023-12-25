import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/model/UserChat.dart';
import 'package:whoru/src/pages/chat/screens/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,required this.channel, required this.chatModel, required this.currentId});
  final IOWebSocketChannel channel;
  final ChatModel chatModel;
  final int currentId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPage(
                      channel: channel,
                      user: UserChat.fromChatModel(chatModel),
                      currentId: currentId,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.network(
                chatModel.avatar,
                // color : Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.fullName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
