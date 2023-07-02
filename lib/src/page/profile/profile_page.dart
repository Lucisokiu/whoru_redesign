import 'package:flutter/material.dart';
import 'package:whoru/src/page/appbar/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const MyAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const MyAppBar(),
            Text(
              "Profile Page",
            )
          ],
        ),
      ),
    );
  }
}
