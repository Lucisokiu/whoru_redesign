import 'package:flutter/material.dart';
import 'package:whoru/src/page/appbar/appbar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(),
            Text(
              "Chat Page",
            )
          ],
        ),
      ),
    );
  }
}
