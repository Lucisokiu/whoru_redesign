import 'package:flutter/material.dart';
import 'package:whoru/src/models/chat_model.dart';
import 'package:whoru/src/models/user_chat.dart';
import 'package:whoru/src/pages/chat/screens/individual_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, required this.chatModel, required this.currentId});
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
                const Icon(Icons.done_all),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.currentMessage,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel.type),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
