import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whoru/src/api/feed.dart';

class CreatePostForm extends StatefulWidget {
  const CreatePostForm({super.key});

  @override
  State<CreatePostForm> createState() => _CreatePostFormState();
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
              decoration: const InputDecoration(
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
            child: const Text('Pick Image'),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Theme.of(context).dividerColor, // Màu viền
                          width: 2.0, // Độ rộng của viền
                        ),
                      ),
                    ),
                  ),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                if (imageFiles.isNotEmpty) {
                  postApiWithImages(
                    imageFiles: imageFiles,
                    content: contentController.text,
                  ).then((value) => Navigator.pop(context));
                }
              },
              child: const Text('Create Post'),
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
