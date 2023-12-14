import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whoru/src/api/feed.dart';

class CreatePostForm extends StatefulWidget {
  @override
  _CreatePostFormState createState() => _CreatePostFormState();
}

class _CreatePostFormState extends State<CreatePostForm> {
  TextEditingController contentController = TextEditingController();
  XFile? pickedImage;
  final picker = ImagePicker();
  List<File> imageFiles = [];

  Future<void> _pickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFiles.add(File(pickedImage!.path));
    }
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: contentController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Enter your post content...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var imageFile in imageFiles)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              : Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                if (imageFiles.isNotEmpty) {
                  await postApiWithImages(
                    imageFiles: imageFiles,
                    content: contentController.text,
                  );
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
