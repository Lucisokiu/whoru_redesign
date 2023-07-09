import 'package:flutter/material.dart';
import 'package:whoru/main.dart';
import 'package:whoru/src/page/appbar/appbar.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(),
            Text(
              "Camera Page",
            )
          ],
        ),
      ),
    );
  }
}