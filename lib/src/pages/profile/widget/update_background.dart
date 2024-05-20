import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whoru/src/api/user_info.dart';

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
            "Update Background",
            style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
          ),
          ElevatedButton(
            onPressed: () async {
              await _pickImage();
              _updateUI();
            },
            child: const Text('Pick Image'),
          ),
          pickedImage != null
              ? Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.file(
                        File(pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                if (pickedImage != null) {
                  updateBackground(imageFile: File(pickedImage!.path))
                      .then((value) => Navigator.pop(context));
                }
              },
              child: const Text('Update'),
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
