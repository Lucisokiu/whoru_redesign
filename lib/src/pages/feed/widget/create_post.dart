import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/camera/camera.dart';

import '../../../api/feed.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  final List<XFile> _selectedImages = [];
  bool isLoading = false;
  final RegExp _sensitiveWordPattern =
      RegExp(r'\b(đụ má|đm|con cặc|cc|lồn|cl|cái lồn)\b', caseSensitive: false);
  int? selectedValue;

  @override
  void initState() {
    _titleController.addListener(() {
      _checkSensitiveWords();
      checkMaxTitle();
    });
    super.initState();
  }

  void checkMaxTitle() {
    int maxWords = 2000;
    print(_titleController.text);
    if (_titleController.text.length > maxWords) {
      setState(() {
        int caretPosition = _titleController.selection.end;
        _titleController.text = _titleController.text.substring(0, maxWords);
        _titleController.selection = TextSelection.fromPosition(TextPosition(
            offset: min(caretPosition, _titleController.text.length)));
      });
    }
  }

  void _checkSensitiveWords() {
    final text = _titleController.text;
    final sanitizedText = text.replaceAllMapped(_sensitiveWordPattern, (match) {
      return '*' * match.group(0)!.length;
    });

    if (text != sanitizedText) {
      _titleController.value = _titleController.value.copyWith(
        text: sanitizedText,
        selection: TextSelection.fromPosition(
          TextPosition(offset: sanitizedText.length),
        ),
      );
    }
  }

  void _takePicture(XFile? image) {
    if (image != null) {
      setState(() {
        _selectedImages.add(image);
      });
    }
    print("_takePicture");
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    setState(() {
      _selectedImages.addAll(images);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
                      border: const OutlineInputBorder(),
                      labelText: 'Title',
                      hintText: "Type your feel (< 2000 words)",
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(2.w),
                    ),
                    onChanged: (value) {
                      checkMaxTitle();
                    },
                  ),
                  DropdownButton<int>(
                    value: selectedValue,
                    hint: Text('Select an item'),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? newValue) {
                      // Đảm bảo rằng onChanged nhận giá trị int?
                      setState(() {
                        selectedValue = newValue;
                      });
                    },
                    items: <int>[1, 2, 3, 4]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.blue), // Icon đi kèm
                            SizedBox(width: 10),
                            Text('Item $value'),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          XFile? file = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const CameraScreen()));
                          _takePicture(file);
                        },
                        child: const Text('Take Picture'),
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
                        child: const Text('Pick Image'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                        itemCount: (_selectedImages.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                for (var i = index * 2;
                                    i < (index + 1) * 2;
                                    i++)
                                  if (i < _selectedImages.length)
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                      if (_selectedImages.isNotEmpty && selectedValue != null) {
                        List<File> files = _selectedImages
                            .map((xFile) => File(xFile.path))
                            .toList();
                        postApiWithImages(
                          imageFiles: files,
                          content: _titleController.text,
                          status: selectedValue!,
                        ).then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Text('Create Post'),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
  }
}
