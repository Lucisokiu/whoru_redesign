import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/story.dart';
import 'package:whoru/src/pages/navigation/navigation.dart';

import '../../nude_detection/test.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  ImageUploadScreenState createState() => ImageUploadScreenState();
}

class ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  bool isPosting = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Chụp ảnh'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Chọn từ thư viện'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _uploadImage() async {
    if (_image != null) {
      final hasNudity = await FlutterNudeDetector.detect(path: _image!.path);
      if (!hasNudity) {
        setState(() {
          isPosting = true;
        });
        postStory(imageFile: _image!).then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (builder) => Navigation(),
            ),
          ),
        );
      } else {
        setState(() {
          isPosting = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(
            content: Text(
                'Selected images can be nudity. Please select different images.'),
          ),
        );
      }
    } else {
      print('No image to upload.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
        actions: [
          Visibility(
            visible: _image != null,
            child: IconButton(
              icon: const Icon(Icons.cloud_upload),
              onPressed: () {
                _uploadImage();
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image == null
                    ? IconButton(
                        onPressed: () => _showImageSourceActionSheet(context),
                        icon: Icon(
                          PhosphorIconsThin.image,
                          size: 30.h,
                        ))
                    : SizedBox(
                        height: 50.h,
                        width: 100.w,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.fill,
                        )),
              ],
            ),
          ),
          if (isPosting)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
