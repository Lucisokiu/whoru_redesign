// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:whoru/src/pages/nude_detection/test.dart';
// import 'dart:convert';

// import 'package:whoru/src/utils/url.dart';

// import '../../utils/shared_pref/token.dart';

// class NudeDetectScreen extends StatefulWidget {
//   const NudeDetectScreen({super.key});

//   @override
//   State<NudeDetectScreen> createState() => _NudeDetectScreenState();
// }

// class _NudeDetectScreenState extends State<NudeDetectScreen> {
//   File? _image;

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _isNude() async {
//     final picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(
//           source: ImageSource
//               .gallery); // You can also use ImageSource.camera for the camera
//       if (image != null) {
//         _image = File(image.path);
//         final hasNudity = await FlutterNudeDetectorTest.detect(path: image.path);
//         print(hasNudity);
//         setState(() {});
//       } else {
//         print("No image selected.");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pick Image from Gallery'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _image == null ? Text('No image selected.') : Image.file(_image!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isNude,
//               child: Text('Upload Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
