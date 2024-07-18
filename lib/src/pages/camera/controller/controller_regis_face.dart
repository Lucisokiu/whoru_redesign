import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class RecognizerRegister {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  @override
  RecognizerRegister({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    init();
  }

  init() async {
    await loadModel();
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

  List<double> recognize(img.Image image, Rect location) {
    var input = imageToArray(image);
    print(input.shape.toString());

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
    return doubleListOutput;
  }

  void close() {
    interpreter.close();
  }
}
