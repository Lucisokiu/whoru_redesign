import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../api/face_recog.dart';
import '../../../api/suggestion_user.dart';
import '../../face_detection/DB/face_registration_info.dart';
import '../../face_detection/ML/viewmodel/face_register.dart';

class RecognizerFaceMatch {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;
  late FaceDetector faceDetector;

  Map<int, Recognition> registered = {};

  List<FaceRegistrationInfo> faceRegisters = [];

  @override
  RecognizerFaceMatch({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    init();
  }

  init() async {
    listUser.clear();
    final options =
        FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    faceDetector = FaceDetector(options: options);
    await loadModel();
    await loadRegisteredFaces();
  }

  Future<void> fetchData() async {
    faceRegisters = await getAllEmbedding();
  }

  Future<void> loadRegisteredFaces() async {
    await fetchData();
    registered.clear();
    if (faceRegisters.isEmpty) {
      print("Empty faceRegisters");
    } else {
      print("faceRegisters not Empty");
    }
    for (final row in faceRegisters) {
      int id = row.id;
      List<double> embedding = row.embedding;

      Recognition recognition = Recognition(id, Rect.zero, embedding, 0);

      registered.putIfAbsent(id, () => recognition);
    }
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(
          'assets/facerecognition/facenet.tflite',
          options: _interpreterOptions);
      print("Load Model Success");
    } catch (e) {
      print('Unable to create interpreter, Caught Exception: ${e.toString()}');
    }
  }

  List<dynamic> imageToArray(img.Image inputImage) {
    img.Image resizedImage =
        img.copyResize(inputImage, width: 160, height: 160);
    List<double> flattenedList = resizedImage.data!
        .expand((channel) => [channel.r, channel.g, channel.b])
        .map((value) => value.toDouble())
        .toList();
    Float32List float32Array = Float32List.fromList(flattenedList);
    int channels = 3;
    int height = 160;
    int width = 160;
    Float32List reshapedArray = Float32List(1 * height * width * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          int index = c * height * width + h * width + w;
          reshapedArray[index] =
              (float32Array[c * height * width + h * width + w] - 127.5) /
                  127.5;
        }
      }
    }
    return reshapedArray.reshape([1, 160, 160, 3]);
  }

  Pair recognize(img.Image image, Rect location) {
    var input = imageToArray(image);
    // print(input.shape.toString());

    List output = List.filled(1 * 512, 0).reshape([1, 512]);

    // final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(input, output);
    // final run = DateTime.now().millisecondsSinceEpoch - runs;
    // print('Time to run inference: $run ms$output');
    String stringOutput = output.first.toString();
    String cleanOutput = stringOutput.substring(1, stringOutput.length - 1);

    List<double> doubleListOutput = cleanOutput
        .split(',')
        .map((e) => double.parse(e))
        .toList()
        .cast<double>();
    Pair pair = findNearest(doubleListOutput);
    return pair;
    // return Recognition(pair.number, location, doubleListOutput, pair.distance);
  }

  findNearest(List<double> embedding) {
    Pair pair = Pair(
        -1,
        double
            .infinity);

    for (MapEntry<int, Recognition> item in registered.entries) {
      if (registered.entries.isEmpty) {
        print('empty');
        continue;
      }

      final int number = item.key;
      List<double> knownEmb = item.value.embedding;

      double distance =
          euclideanDistance(embedding, knownEmb); //Tính khoảng cách Euclide

      if (distance < pair.distance) {
        // Cập nhật
        pair = Pair(number, distance);
      }
    }

    return pair;
  }

  double euclideanDistance(List<double> embedding, List<double> knownEmb) {
    double distance = 0;
    for (int i = 0; i < embedding.length; i++) { //Tính tổng bình phương hiệu giữa các phần tử tương ứng của hai vectơ:
      double diff = embedding[i] - knownEmb[i];
      distance += diff * diff;
    }
    distance = sqrt(distance);
    return distance;
  }

  late List<Face> faces;
  List<int> listUser = [];
  dynamic image;

  doFaceDetection(List<File> files) async {
    for (File _image in files) {
      InputImage inputImage = InputImage.fromFile(_image);
      image = await decodeImageFromList(_image.readAsBytesSync());

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

        final bytes = _image.readAsBytesSync();
        img.Image? faceImg = img.decodeImage(bytes);
        img.Image croppedFace = img.copyCrop(faceImg!,
            x: left.toInt(),
            y: top.toInt(),
            width: width.toInt(),
            height: height.toInt());
        Pair recognition = recognize(croppedFace, boundingBox);
        if (recognition.distance > 1.25) {
          recognition.number = -1;
        }
        listUser.add(recognition.number);
        print('id = ${recognition.number}');
      }
    }
    print('listUser = ${listUser.length}');

    postListSuggestionsList(listUser).then((value) => null);
  }

  void close() {
    interpreter.close();
  }
}

class Pair {
  int number;
  double distance;
  Pair(this.number, this.distance);
}
