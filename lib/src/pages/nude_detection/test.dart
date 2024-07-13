import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Detect nudity in images
class FlutterNudeDetector {
  static const _threshold = 0.7;
  static const _modelPath = 'assets/ml_models/nude.tflite';

  /// The function check if image contains nudity content and returns bool
  /// type of result. You can specify custom values of threshold and path
  /// to model .tflite default threshold is 0.7 and default path to model is
  /// assets/ml_models/nude.tflite
  static Future<bool> detect({
    required String path,
    double threshold = _threshold,
    String modelAssetsPath = _modelPath,
  }) async {
    try {
      final inputImage = InputImage.fromFilePath(path);
      final modelPath = await getModel(modelAssetsPath);
      final options = LocalLabelerOptions(
        modelPath: modelPath,
        confidenceThreshold: threshold,
      );

      final imageLabeler = ImageLabeler(options: options);
      final imageLabels = await imageLabeler.processImage(inputImage);
      if (imageLabels.isEmpty) return false;
      final label = imageLabels.first;
      switch (label.index) {
        case 0:
          print("check0 : ${label.confidence}");
          print("check : ${label.confidence < threshold}");
          return label.confidence < threshold;
        case 1:
          print("check1 : ${label.confidence}");
          print("check : ${label.confidence > threshold}");

          return label.confidence > threshold;

        default:
          return false;
      }
    } catch (e) {
      if (kDebugMode) {
        log('flutter_nude_detector throwing error!', error: e);
      }

      return false;
    }
  }

  /// Get path to model .tflite
  static Future<String> getModel(String assetPath) async {
    if (Platform.isAndroid) return 'flutter_assets/$assetPath';

    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    final file = File(path);

    await Directory(dirname(path)).create(recursive: true);
    if (!file.existsSync()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    }
    print("check");

    return file.path;
  }
}
