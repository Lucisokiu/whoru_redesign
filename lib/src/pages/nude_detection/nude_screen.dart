import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:whoru/src/pages/nude_detection/test.dart';
import 'dart:convert';

import 'package:whoru/src/utils/url.dart';

import '../../utils/shared_pref/token.dart';

class NudeDetectScreen extends StatefulWidget {
  const NudeDetectScreen({super.key});

  @override
  State<NudeDetectScreen> createState() => _NudeDetectScreenState();
}

class _NudeDetectScreenState extends State<NudeDetectScreen> {
  File? _image;
  String isNude = false.toString();

  Future<void> _isNude() async {
    final picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
          source: ImageSource
              .gallery); // You can also use ImageSource.camera for the camera
      if (image != null) {
        _image = File(image.path);
        final hasNudity =
            await FlutterNudeDetectorTest.detect(path: image.path);
        print(hasNudity);
        setState(() {
          isNude = hasNudity.toString();
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Image from Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? const Text('No image selected.') : Image.file(_image!),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isNude,
              child: const Text('Upload Image'),
            ),
            Text("isNude: $isNude"),
          ],
        ),
      ),
    );
  }
}
