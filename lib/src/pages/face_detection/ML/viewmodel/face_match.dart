import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:whoru/src/api/face_recog.dart';
import 'package:whoru/src/pages/face_detection/DB/face_registration_info.dart';
import 'package:whoru/src/pages/face_detection/ML/view/face_register_view.dart';
import 'face_register.dart';

class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  Map<int, Recognition> registered = {};

  List<FaceRegistrationInfo> faceRegisters = [];

  @override
  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    init();
  }

  init() async {
    await loadModel();
    // await fetchData();
    // await loadRegisteredFaces();
  }

  Future<void> fetchData() async {
    faceRegisters = await getAllEmbedding();

    for (FaceRegistrationInfo faceRegister in faceRegisters) {
      print('Length Embedding: ${faceRegister.embedding.length}');
    }
  }

  // bool checkdata() {
  //   if (faceRegisters.isNotEmpty && faceRegister.isNotEmpty) {
  //     if (faceRegisters[0].embedding.length !=
  //         faceRegister[0].embedding.length) {
  //       print("khác length");
  //       return false; // Hai danh sách có độ dài khác nhau
  //     }
  //     for (int i = 0; i < 512; i++) {
  //       if (faceRegisters[0].embedding[i] != faceRegister[0].embedding[i]) {
  //         print("Có phần tử không trùng nhau");
  //         print(i);
  //         print('server: ${faceRegisters[0].embedding[i]}'); // server
  //         print('local: ${faceRegister[0].embedding[i]}'); // local

  //         // return false;
  //       }
  //     }
  //   }
  //   print("Mọi thứ đều trùng");
  //   return true;
  // }

  Future<void> loadRegisteredFaces() async {
    List<FaceRegistrationInfo> faceRegisters = [];
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
  // List<dynamic> imageTOARRAY (img.Image inputImage){}

  Recognition recognize(img.Image image, Rect location) {
    var input = imageToArray(image);
    print(input.shape.toString());

    List output = List.filled(1 * 512, 0).reshape([1, 512]);

    final runs = DateTime.now().millisecondsSinceEpoch;
    interpreter.run(input, output);
    final run = DateTime.now().millisecondsSinceEpoch - runs;
    print('Time to run inference: $run ms$output');
    String stringOutput = output.first.toString();
    String cleanOutput = stringOutput.substring(1, stringOutput.length - 1);

    List<double> doubleListOutput = cleanOutput
        .split(',')
        .map((e) => double.parse(e))
        .toList()
        .cast<double>();
    print('doubleListOutput=========== ${doubleListOutput.length}');
    Pair pair = findNearest(doubleListOutput);
    print("mesafe= ${pair.distance}");

    return Recognition(pair.number, location, doubleListOutput, pair.distance);
  }

  double cosineSimilarity(List<double> vector1, List<double> vector2) {
    if (vector1.length != vector2.length ||
        vector1.isEmpty ||
        vector2.isEmpty) {
      throw ArgumentError(
          "Các vectơ phải có kích thước bằng nhau và không trống.");
    }

    // İki vektörün iç çarpımını hesapla
    double dotProduct = 0;
    for (int i = 0; i < vector1.length; i++) {
      dotProduct += vector1[i] * vector2[i];
    }

    // İki vektörün normlarını hesapla
    double norm1 = vectorNorm(vector1);
    double norm2 = vectorNorm(vector2);

    // Kosinüs benzerliği hesapla
    double similarity = dotProduct / (norm1 * norm2);

    return similarity;
  }

  double vectorNorm(List<double> vector) {
    // Vektörün normunu hesapla (Euclidean norm)
    double sum = 0;
    for (int i = 0; i < vector.length; i++) {
      sum += vector[i] * vector[i];
    }
    return sqrt(sum);
  }

  /*findNearest(List<double> embedding) {
    Pair pair = Pair("Yüz Tanınmıyor", -5);

    for (MapEntry<String, Recognition> item in registered.entries) {
      final String number = item.key;
      List<double> knownEmb = item.value.embedding;

      // Kosinüs benzerliğini hesapla
      double similarity = cosineSimilarity(embedding, knownEmb);

      if (pair.distance == -5 || similarity > pair.distance) {
        pair.distance = similarity;
        pair.number = number;
      }
    }

    return pair;
  }*/

  //öklid mesafesi ile benzelik hesaplamak için kullanılan fonksiyon
  /*findNearest(List<double> embedding) {
    Pair pair = Pair("Yüz Tanınmıyor", -5);

    for (MapEntry<String, Recognition> item in registered.entries) {
      if (registered.entries.isEmpty) {
        print('empty');
      }
      print(registered.entries);
      final String number = item.key;
      print(number);
      List<double> knownEmb = item.value.embedding;
      double distance = 0;
      for (int i = 0; i < embedding.length; i++) {
        double diff = embedding[i] - knownEmb[i];
        distance += diff * diff;
      }
      distance = sqrt(distance);
      if (pair.distance == -5 || distance < pair.distance) {
        pair.distance = distance;
        pair.number = number;
      }
    }
    return pair;
  }
*/
/*findNearest(List<double> embedding) {
    Pair pair = Pair("Yüz Tanınmıyor", -5);

    for (MapEntry<String, Recognition> item in registered.entries) {
      if (registered.entries.isEmpty) {
        print('empty');
      }
      print(registered.entries);
      final String number = item.key;
      print(number);
      List<double> knownEmb = item.value.embedding;

      double distance = 0;
      for (int i = 0; i < embedding.length; i++) {
        double diff = embedding[i] - knownEmb[i];
        distance += diff * diff;
      }
      distance = sqrt(distance);
      if (pair.distance == -5 || distance < pair.distance) {
        pair.distance = distance;
        pair.number = number;
      }
    }
    return pair;
  } */
  findNearest(List<double> embedding) {
    Pair pair = Pair(
        -1,
        double
            .infinity); // Nếu không tìm thấy kết quả khớp, khoảng cách được đặt thành 5

    for (MapEntry<int, Recognition> item in registered.entries) {
      if (registered.entries.isEmpty) {
        print('empty');
        continue; // Bỏ qua vòng lặp nếu không có mục nào được ghi lại
      }

      final int number = item.key;
      List<double> knownEmb = item.value.embedding;

      double distance =
          euclideanDistance(embedding, knownEmb); //Tính khoảng cách Euclide

      if (distance < pair.distance) {
        // Cập nhật nếu tìm thấy kết quả phù hợp hơn
        pair = Pair(number, distance);
      }
    }

    return pair;
  }

  double euclideanDistance(List<double> embedding, List<double> knownEmb) {
    double distance = 0;
    for (int i = 0; i < embedding.length; i++) {
      double diff = embedding[i] - knownEmb[i];
      distance += diff * diff;
    }
    distance = sqrt(distance);
    return distance;
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
