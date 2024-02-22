import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../api/feed.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  List<XFile> _selectedImages = [];
  bool isLoading = false;

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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.sp),
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
                    contentPadding: EdgeInsets.all(2.w),
                  ),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _takePicture,
                      child: Text('Take Picture'),
                    ),
                    const SizedBox(
                      height: 20,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pick Image'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                      itemCount: (_selectedImages.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              for (var i = index * 2; i < (index + 1) * 2; i++)
                                if (i < _selectedImages.length)
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(_selectedImages[i].path),
                                          fit: BoxFit
                                              .cover, // You can adjust the BoxFit based on your needs
                                        ),
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        );
                      }),
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (_selectedImages.isNotEmpty) {
                      List<File> files = _selectedImages
                          .map((xFile) => File(xFile.path))
                          .toList();
                      await postApiWithImages(
                        imageFiles: files,
                        content: _titleController.text,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Create Post'),
                ),
              ],
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
