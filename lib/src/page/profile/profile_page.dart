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
    return const Scaffold(

      // appBar: MyAppBar(),
        body: Center(
        child: Text(
          'This is the Profile page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }

}