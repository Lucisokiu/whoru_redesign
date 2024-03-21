import 'package:flutter/material.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextButton(onPressed: () {}, child: Text("Register")),
          TextButton(onPressed: () {}, child: Text("Login")),
        ],
      )),
    );
  }
}
