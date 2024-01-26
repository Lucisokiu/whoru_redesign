import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  List<XFile> _selectedImages = [];

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _selectedImages.add(image);
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
                hintText: "Type your feel",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(5),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _takePicture,
                  child: Text('Take Picture'),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: _selectedImages.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Container(
            //             height: 30.h,
            //             width: 30.w,
            //             child: Image.file(File(_selectedImages[index].path))),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 0.1,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Divider(height: 10.h,),
                        Container(child: Image.file(File(_selectedImages[index].path))),
                      ],
                    ),
                  );
                },
                itemCount: _selectedImages.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: CreatePost(),
    ),
  );
}
