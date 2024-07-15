import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/camera/camera.dart';

import '../../../api/face_recog.dart';
import '../../../api/feed.dart';
import '../../../utils/sensitive_words.dart';
import '../../face_detection/DB/face_registration_info.dart';
import '../../nude_detection/test.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _titleController = TextEditingController();
  final List<XFile> _selectedImages = [];
  bool isLoading = false;
  final RegExp _sensitiveWordPattern = RegExp(
    '\\b(${sensitiveWords.join('|')})\\b',
    caseSensitive: false,
  );
  int selectedValue = 1;
  List<FaceRegistrationInfo> faceRegisters = [];

  @override
  void initState() {
    _titleController.addListener(() {
      _checkSensitiveWords();
      checkMaxTitle();
    });
    super.initState();
  }
  Future<void> fetchData() async {
    faceRegisters = await getAllEmbedding();

    for (FaceRegistrationInfo faceRegister in faceRegisters) {
      print('Length Embedding: ${faceRegister.embedding.length}');
    }
  }
  Future<void> postFeed() async {
    setState(() {
      isLoading = true;
    });
    List<File> files =
        _selectedImages.map((xFile) => File(xFile.path)).toList();
    bool hasAnyUnSafeImage = false;

    for (File image in files) {
      final hasNudity = await FlutterNudeDetector.detect(path: image.path);
      if (hasNudity) {
        hasAnyUnSafeImage = true;
        break; // Exit the loop as we found a safe image
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
    // await loadModel();

      
      postApiWithImages(
        imageFiles: files,
        content: _titleController.text,
        status: selectedValue,
      ).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pop(context);
      });
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

  // Future<File> blurImage(File imageFile) async {
  //   // Read the image from the file
  //   final Uint8List bytes = await imageFile.readAsBytes();
  //   img.Image image = img.decodeImage(bytes)!;

  //   // Apply the blur effect
  //   img.Image blurredImage = img.gaussianBlur(image, radius: 10);

  //   // Get the temporary directory to save the blurred image
  //   final Directory tempDir = await getTemporaryDirectory();
  //   final String tempPath = tempDir.path;
  //   final File blurredImageFile =
  //       File('$tempPath/blurred_${imageFile.path.split('/').last}');

  //   // Save the blurred image
  //   blurredImageFile.writeAsBytesSync(img.encodePng(blurredImage));

  //   return blurredImageFile;
  // }

  //  Future<File> _blurSensitiveAreas(File imageFile) async {
  //   // Read the image from file
  //   final Uint8List bytes = await imageFile.readAsBytes();
  //   final tempDir = await getTemporaryDirectory();
  //   final tempPath = tempDir.path;
  //   final String tempImagePath = '$tempPath/blurred_${imageFile.path.split('/').last}';
  //   File tempImageFile = File(tempImagePath);

  //   try {
  //     // Apply face detection and blur sensitive areas
  //     await FlutterImageProcessing.detectAndBlurFaces(
  //       inputImagePath: imageFile.path,
  //       outputImagePath: tempImagePath,
  //       blurRadius: 10, // Adjust blur radius as needed
  //     );
  //     return tempImageFile;
  //   } catch (e) {
  //     print('Error blurring image: $e');
  //     return imageFile; // Return original image if an error occurs
  //   }
  // }

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
    return Stack(
      children: [
        Scaffold(
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
                                  style:
                                      // style:TextStyle(color: Colors.red)
                                      Theme.of(context).textTheme.bodyLarge,
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
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Stack(
                                                children: [
                                                  Image.file(
                                                    File(_selectedImages[i]
                                                        .path),
                                                    fit: BoxFit
                                                        .cover, // You can adjust the BoxFit based on your needs
                                                  ),
                                                  Positioned(
                                                    top: 8.0,
                                                    right: 8.0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _selectedImages
                                                              .removeAt(i);
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black54,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.white,
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
                            }),
                      ),
                      Visibility(
                        visible: checkValue(),
                        child: ElevatedButton(
                          onPressed: () {
                            postFeed();
                          },
                          child: const Text('Create Post'),
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
    if (_titleController.text.isNotEmpty && _selectedImages.length != 0) {
      return true;
    } else {
      return false;
    }
  }
}
