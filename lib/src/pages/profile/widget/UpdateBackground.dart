import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whoru/src/api/userInfo.dart';

class UpdateBackground extends StatefulWidget {
  const UpdateBackground({super.key});

  @override
  State<UpdateBackground> createState() => _UpdateBackgroundState();
}

class _UpdateBackgroundState extends State<UpdateBackground> {

  XFile? pickedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Create Post",
            style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
          ),
          ElevatedButton(
            onPressed: () async {
              await _pickImage();
              _updateUI();
            },
            child: Text('Pick Image'),
          ),
          pickedImage != null
              ? Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(
                  File(pickedImage!.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
              : Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                if (pickedImage != null) {
                  await updateBackground(imageFile: File(pickedImage!.path));
                  Navigator.pop(context);
                }
              },
              child: Text('Create Post'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateUI() {
    if (mounted) {
      setState(() {});
    }
  }
}
