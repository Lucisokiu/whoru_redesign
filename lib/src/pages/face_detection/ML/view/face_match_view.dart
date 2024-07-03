import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../../api/suggestion_user.dart';
import '../../constants/painter.dart';
import '../viewmodel/face_match.dart';

import '../viewmodel/face_register.dart';
import '../viewmodel/facedetector.dart';

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({Key? key}) : super(key: key);

  @override
  State<RecognitionScreen> createState() => _RecognitionScreen();
}

class _RecognitionScreen extends State<RecognitionScreen> {
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
  }



  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doFaceDetection();
      });
    }
  }

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doFaceDetection();
      });
    }
  }

  late List<Face> faces;
  List<Recognition> recognitions = [];
  List<int> listUser = [];
  doFaceDetection() async {
    InputImage inputImage = InputImage.fromFile(_image!);
    recognitions.clear();
    image = await decodeImageFromList(_image!.readAsBytesSync());

    faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;
      // print("RECTTTTT =" + boundingBox.toString());

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
      if (recognition.distance > 1.25) {
        recognition.number = -1;
      }
      recognitions.add(recognition);
      listUser.add(recognition.number);
      print('id = ${recognition.number}');
      print('embedding = ${recognition.embedding}');
      print('rect = ${recognition.location}');
      print('distance = ${recognition.distance}');
    }
    // getListSuggestionsList(listUser);
    drawRectangleAroundFaces();
  }
/*
  Future<void> showRegisteredFacesDialog(BuildContext context) async {
    DatabaseHelper databaseHelper = DatabaseHelper();

    try {
      await databaseHelper.init();
      List<Map<String, dynamic>> allFaces = await databaseHelper.getAllFaces();
      print(allFaces.length);
      for (final faceMap in allFaces) {
        print('------------------------');
        print('ID: ${faceMap[DatabaseHelper.columnId]}');
        print('Numara: ${faceMap[DatabaseHelper.columnStdNumber]}');
        print('Ad: ${faceMap[DatabaseHelper.columnFirstName]}');
        print('Soyad: ${faceMap[DatabaseHelper.columnLastName]}');
        print('Embedding: ${faceMap[DatabaseHelper.columnEmbedding]}');
      }
      print('kayıtlı yüz sayısı = ${allFaces.length}');
      Fluttertoast.showToast(
          msg: "Kayıtlı Yüz Sayısı: ${allFaces.length}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.black,
          fontSize: 16.0);
      /*if (allFaces.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Kayıtlı Yüzler"),
            content: SizedBox(
              height: 500,
              width: 300,
              child: ListView.builder(
                itemCount: allFaces.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Öğrenci Bilgileri",
                                    textAlign: TextAlign.center),
                                content: SizedBox(
                                  height: 300,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Öğrenci Adı= ${allFaces[index]['name']}' +
                                            '\n' +
                                            'Öğrenci Numarası= ${allFaces[index]['id']}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 112,
                                        width: 112,
                                        child: CircleAvatar(
                                            child: Icon(
                                                Icons.abc) //burada resim olcak
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    },
                    title: Text(allFaces[index]['name']),
                    trailing: IconButton(
                      onPressed: () async {
                        await databaseHelper.dropTable();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Yüz Silindi")));
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Kayıtlı Yüz Bulunamadı"),
        ));
      } */
    } catch (e) {
      print("yüz listeleme hatası: $e");
    }
  }
  */

  removeRotation(File inputImage) async {
    final img.Image? capturedImage =
        img.decodeImage(await File(inputImage.path).readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage!);
    return await File(_image!.path).writeAsBytes(img.encodeJpg(orientedImage));
  }

  dynamic image;
  drawRectangleAroundFaces() async {
    print("${image.width}   ${image.height}");
    setState(() {
      image;
      recognitions;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhận dạng khuôn mặt"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () async {
              bool silmeOnayi = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Xóa khuôn mặt đã lưu"),
                    content:
                        const Text("Bạn có muốn xóa khuôn mặt đã đăng ký?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Xóa"),
                      ),
                    ],
                  );
                },
              );
              if (silmeOnayi == true) {
                // await deleteAllRow();
              }
            },
            icon: const Icon(Icons.delete_forever_outlined),
          ),
          IconButton(
            onPressed: () async {
              // await showRegisteredFacesDialog(context);
              showAllRow();
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              image != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 50,
                              left: 60,
                              right: 10,
                              bottom: 0,
                            ),
                            child: FittedBox(
                              child: SizedBox(
                                width: image.width.toDouble() * 1.2,
                                height: image.width.toDouble() * 1.2,
                                child: CustomPaint(
                                  painter: FaceRecognitionPainter(
                                      facesList: recognitions,
                                      imageFile: image),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.amber,
                          width: screenWidth,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.3),
                          child: Center(
                            child: Text(
                              recognitions.isNotEmpty
                                  ? recognitions
                                      .map((recognition) => recognition.number)
                                      .join(",")
                                  : "Khuôn mặt không được nhận dạng!",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 60),
                      height: 300,
                      width: 300,
                      color: Colors.black,
                    ),
              Container(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 0) {
            _imgFromGallery();
          } else if (index == 1) {
            _imgFromCamera();
          } else if (index == 2) {
            Navigator.replace(context,
                oldRoute: ModalRoute.of(context)!,
                newRoute: MaterialPageRoute(
                    builder: (context) => const FaceDetectorView()));
          }
        },
        backgroundColor: Colors.amber,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image, size: 40),
            label: 'Thư viện',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              size: 40,
            ),
            label: 'Chụp ảnh',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, size: 40),
            label: 'Cam trực tiếp',
          ),
        ],
      ),
    );
  }

  // Future<void> deleteAllRow() async {
  //   DatabaseHelper databaseHelper = DatabaseHelper();
  //   try {
  //     await databaseHelper.init();
  //     int kayitSayisi = await databaseHelper.queryRowCount();
  //     if (kayitSayisi > 0) {
  //       await databaseHelper.deleteAllRow();
  //       print('tum yuzler silindiiiiiiiii');
  //     } else {
  //       print('silinecek yuz bulunamadi');
  //     }
  //   } catch (e) {
  //     print("Yüzleri silerken hata oluştu: $e");
  //   }
  // }

  Future<void> showAllRow() async {
    // DatabaseHelper databaseHelper = DatabaseHelper();
    try {

      // for (FaceRegistrationInfo faceRegister1 in faceRegisters1) {
      //   print('Number: ${faceRegister1.id}');
      //   print('Embedding: ${faceRegister1.embedding}');
      // }
    } catch (e) {
      print(e);
    }
  }
}
