import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/camera/camera.dart';
import 'package:http/http.dart' as http;

import '../../../api/feed.dart';
import '../../../models/feed_model.dart';
import '../../../utils/sensitive_words.dart';
import '../../nude_detection/test.dart';
import 'package:image/image.dart' as img;

class UpdatePost extends StatefulWidget {
  final FeedModel feedModel;
  const UpdatePost({super.key, required this.feedModel});

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  final TextEditingController _titleController = TextEditingController();
  final List<XFile> _selectedImages = [];
  final List<String> _imageUrl = [];

  bool isLoading = false;
  bool isLoadImage = false;

  final RegExp _sensitiveWordPattern = RegExp(
    '\\b(${sensitiveWords.join('|')})\\b',
    caseSensitive: false,
  );
  int selectedValue = 1;
  bool changeImage = false;
  bool changeText = false;
  bool changeState = false;

  @override
  void initState() {
    _imageUrl.addAll(widget.feedModel.imageUrls);
    _addText();
    _titleController.addListener(() {
      _checkSensitiveWords();
      checkMaxTitle();
    });
    super.initState();
  }

  _addText() {
    _titleController.text = widget.feedModel.content;
  }

  Future<void> _downloadAndConvertImages() async {
    List<XFile> imageFiles = [];
    for (var imageUrl in _imageUrl) {
      XFile imageFile = await _downloadAndSaveImage(imageUrl);
      imageFiles.add(imageFile);
    }
    print("download OK : ${imageFiles.length}");

    _selectedImages.insertAll(0, imageFiles);
    print("_selectedImages ${_selectedImages.length}");
  }

  Future<XFile> _downloadAndSaveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final appDir = await getTemporaryDirectory();
    final fileName = imageUrl.split('/').last;
    final file = File('${appDir.path}/$fileName');

    await file.writeAsBytes(bytes);
    return XFile(file.path);
  }

  Future<void> updateFeed() async {
    setState(() {
      isLoading = true;
    });

    List<File> files =
        _selectedImages.map((xFile) => File(xFile.path)).toList();
    bool hasAnyUnSafeImage = false;
    for (File image in files) {
      final hasNudity = await FlutterNudeDetector.detect(path: image.path);
      print("checkhasNudity $hasNudity");
      if (hasNudity) {
        hasAnyUnSafeImage = true;
        break;
      }
    }
    if (hasAnyUnSafeImage) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Selected images can be nudity. Please select different images.'),
          ),
        );
      }
    } else {
      await _downloadAndConvertImages();
      List<File> imageToUpdate =
          _selectedImages.map((xFile) => File(xFile.path)).toList();
      updateApiWithImages(
        id: widget.feedModel.idFeed,
        imageFiles: imageToUpdate,
        content: _titleController.text,
        status: selectedValue,
      ).then(
        (value) {
          Navigator.pop(context);
        },
      );
    }
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
        changeImage = true;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    setState(() {
      _selectedImages.addAll(images);
      changeImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text('Update Post'),
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
                          setState(() {
                            changeText = true;
                          });
                        },
                      ),
                      DropdownButton<int>(
                        value: selectedValue,
                        hint: const Text('Select an item'),
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (int? newValue) {
                          // Đảm bảo rằng onChanged nhận giá trị int?
                          setState(() {
                            selectedValue = newValue!;
                            changeState = true;
                            print(selectedValue);
                          });
                        },
                        items: <int>[1, 2, 3, 4]
                            .map<DropdownMenuItem<int>>((int value) {
                          Map<int, String> valueToString = {
                            1: 'Public',
                            2: 'Only Follower',
                            3: 'Only Friend',
                            4: 'Private',
                          };
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Text(
                                  valueToString[value]!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )
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
                                      builder: (builder) =>
                                          const CameraScreen()));
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
                      const SizedBox(
                        height: 16.0,
                      ),
                      isLoadImage
                          ? const Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount:
                                            ((_imageUrl.length) / 2).ceil() +
                                                ((_selectedImages.length) / 2)
                                                    .ceil(),
                                        itemBuilder: (context, index) {
                                          if (index <
                                              ((_imageUrl.length) / 2).ceil()) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  for (var i = index * 2;
                                                      i < (index + 1) * 2;
                                                      i++)
                                                    if (i < _imageUrl.length)
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Stack(
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                      _imageUrl[
                                                                          i],
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    height:
                                                                        30.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .fill, // You can adjust the BoxFit based on your needs
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 8.0,
                                                                  right: 8.0,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _imageUrl
                                                                            .removeAt(i);
                                                                        changeImage =
                                                                            true;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .black54,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            int selectImageIndex = index -
                                                ((_imageUrl.length) / 2).ceil();
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                children: [
                                                  for (var i =
                                                          selectImageIndex * 2;
                                                      i <
                                                          (selectImageIndex +
                                                                  1) *
                                                              2;
                                                      i++)
                                                    if (i <
                                                        _selectedImages.length)
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Stack(
                                                              children: [
                                                                Container(
                                                                  height: 30.h,
                                                                  width: double
                                                                      .infinity, // Ensure the container has a definite width

                                                                  child: Image
                                                                      .file(
                                                                    File(_selectedImages[
                                                                            i]
                                                                        .path),
                                                                    fit: BoxFit
                                                                        .cover, // You can adjust the BoxFit based on your needs
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 8.0,
                                                                  right: 8.0,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        _selectedImages
                                                                            .removeAt(i);
                                                                        changeImage =
                                                                            true;
                                                                      });
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: Colors
                                                                            .black54,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                ],
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                      Visibility(
                        visible: checkValue(),
                        child: ElevatedButton(
                          onPressed: () {
                            updateFeed();
                          },
                          child: const Text('Update Post'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
    );
  }

  bool checkValue() {
    if (_titleController.text.isNotEmpty &&
        (changeImage || changeState || changeText) &&
        (_imageUrl.length + _selectedImages.length) > 0) {
      return true;
    } else {
      return false;
    }
  }
}
