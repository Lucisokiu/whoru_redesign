import 'package:flutter/material.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          MyAppBar(),
          Text(
            "Game Page",
          )
        ],
      ),
    );
  }
}
