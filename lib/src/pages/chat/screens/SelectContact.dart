import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:whoru/src/pages/chat/widget/SearchUser.dart';
import 'package:whoru/src/pages/chat/screens/CreateGroup.dart';
import 'package:whoru/src/pages/chat/widget/ButtonCard.dart';
import 'package:whoru/src/pages/chat/widget/ContactCard.dart';
import 'package:whoru/src/pages/search/controller/search_bar.dart';
import 'package:whoru/src/socket/WebSocketService.dart';

import '../../../model/ChatModel.dart';

class SelectContact extends StatefulWidget {
  WebSocketService webSocketService;

  SelectContact({super.key, required this.webSocketService});

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      // ChatModel(
      //   name: "Dev Stack",
      //   isGroup: false,
      //   currentMessage: "Hi Everyone",
      //   time: "4:00",
      //   icon: "person.svg",
      //   id: 1,
      //   status: "A full stack developer",
      // ),
      // ChatModel(
      //   name: "Kishor",
      //   isGroup: false,
      //   currentMessage: "Hi Kishor",
      //   time: "13:00",
      //   icon: "person.svg",
      //   id: 2,
      //   status: "A full stack developer",
      // ),
      //
      // ChatModel(
      //   name: "Collins",
      //   isGroup: false,
      //   currentMessage: "Hi Dev Stack",
      //   time: "8:00",
      //   icon: "person.svg",
      //   id: 3,
      //   status: "A full stack developer",
      // ),
      //
      // ChatModel(
      //   name: "Balram Rathore",
      //   isGroup: false,
      //   currentMessage: "Hi Dev Stack",
      //   time: "2:00",
      //   icon: "person.svg",
      //   id: 4,
      //   status: "A full stack developer",
      // ),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Contact",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(
              //   "256 contacts",
              //   style: TextStyle(
              //     fontSize: 13,
              //   ),
              // )
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  size: 26,
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchUserChat(webSocketService: widget.webSocketService),
                  );
                }),
            PopupMenuButton<String>(
              padding: EdgeInsets.all(0),
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => CreateGroup()));
                  },
                  child: ButtonCard(
                    icon: Icons.group,
                    name: "New group",
                  ),
                );
              } else if (index == 1) {
                return ButtonCard(
                  icon: Icons.person_add,
                  name: "New contact",
                );
              }
              return ContactCard(
                contact: contacts[index - 2],
              );
            }));
  }
}
