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
  List<File> imageFiles = []; // Khởi tạo danh sách trống

  Future<void> _pickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFiles.add(File(pickedImage!.path)); // Thêm ảnh vào danh sách
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
          ElevatedButton(
            onPressed: () async {
              await _pickImage();
              _updateUI();
            },
            child: Text('Pick Image'),
          ),
          Spacer(),
          pickedImage != null
              ? Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var imageFile in imageFiles)
                          Image.file(
                            imageFile,
                            height: 300,
                          ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          Spacer(), // Sử dụng Spacer để đẩy widget về dưới cùng

          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                if (imageFiles.isNotEmpty) {
                  await postApiWithImages(
                    imageFiles: imageFiles,
                    content: contentController.text,
                  );
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
