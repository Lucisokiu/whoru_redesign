import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/face_detection/DB/face_registration_info.dart';

import '../../api/face_recog.dart';
import '../face_detection/ML/view/face_match_view.dart';
import '../face_detection/ML/viewmodel/face_match.dart';
import '../face_detection/ML/viewmodel/face_register.dart';
import '../face_detection/constants/painter.dart';

class CameraScreenFaceRegis extends StatefulWidget {
  const CameraScreenFaceRegis({super.key});

  @override
  State<CameraScreenFaceRegis> createState() => _CameraScreenFaceRegisState();
}

class _CameraScreenFaceRegisState extends State<CameraScreenFaceRegis> {
  late ImagePicker imagePicker;
  File? _image;

  late FaceDetector faceDetector;
  late Recognizer recognizer;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();

    final options =
        FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);
    recognizer = Recognizer();
    _imgFromCamera(context);
  }

  _imgFromCamera(BuildContext context) async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await doFaceDetection();
      if (mounted) {
        setState(() {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (builder) => const App(),
              ),
              (route) => false);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          Navigator.pop(context);
        });
      }
    }
  }

  List<Face> faces = [];

  doFaceDetection() async {
    InputImage inputImage = InputImage.fromFile(_image!);
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(_image!.readAsBytesSync());

    faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;

      num left = boundingBox.left < 0 ? 0 : boundingBox.left;
      num top = boundingBox.top < 0 ? 0 : boundingBox.top;
      num right =
          boundingBox.right > image.width ? image.width - 1 : boundingBox.right;
      num bottom = boundingBox.bottom > image.height
          ? image.height - 1
          : boundingBox.bottom;
      num width = right - left;
      num height = bottom - top;

      final bytes = _image?.readAsBytesSync();
      img.Image? faceImg = img.decodeImage(bytes!);
      img.Image croppedFace = img.copyCrop(faceImg!,
          x: left.toInt(),
          y: top.toInt(),
          width: width.toInt(),
          height: height.toInt());
      Recognition recognition = recognizer.recognize(croppedFace, boundingBox);
      postEmbedding(recognition.embedding);
    }
  }

  dynamic image;

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
