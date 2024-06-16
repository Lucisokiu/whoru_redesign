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
                Icon(chatModel.isSeen ? Icons.done_all : Icons.done),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel.type == "Room" || chatModel.type == "Message" ? chatModel.currentMessage : "${chatModel.fullName} send a picture",
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: chatModel.type == "Room" || chatModel.type == "Message"
                ? Text(chatModel.type)
                : const Text("Image"),
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
