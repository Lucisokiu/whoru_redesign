import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/pages/chat/screens/IndividualPage.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key, required this.chatModel, required this.sourchat});
  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contex) => IndividualPage(
                      chatModel: chatModel,
                      sourchat: sourchat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.network(
                chatModel.isGroup
                    ? "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Group_font_awesome.svg/768px-Group_font_awesome.svg.png"
                    : "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Group_font_awesome.svg/768px-Group_font_awesome.svg.png",
                color : Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
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
            trailing: Text(chatModel.time),
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
