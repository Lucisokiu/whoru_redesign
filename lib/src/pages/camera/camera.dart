import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import '../../../main.dart';
import '../../matherial/filter.dart';
import 'dart:io';
import 'dart:ui' as ui;

// import '../../../main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  XFile? image;
  List<ColorFilter> colorFilters = Filter().getFilters();
  int indexFilter = 0;

  initCamera() {
    _cameraController = CameraController(cameras[1], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError(
      (error) {
        print('Camera Controller Error: $error');
        _cameraController.dispose();
        Navigator.pop(context);
      },
    );
  }

  Future<XFile> applyFilterToImage(XFile imageFile, ColorFilter filter) async {
    final imageBytes = await imageFile.readAsBytes();
    final ui.Image image = await decodeImageFromList(imageBytes);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paint = Paint()..colorFilter = filter;
    canvas.drawImage(image, Offset.zero, paint);

    final img = await recorder.endRecording().toImage(
          image.width,
          image.height,
        );
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    File filteredImageFile = File(tempPath);
    await filteredImageFile.writeAsBytes(buffer);
    return XFile(tempPath);
  }

  @override
  void initState() {
    super.initState();

    initCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Camera"),
        ),
        body: image == null ? CameraView() : ImageView());
  }

  Widget ImageView() {
    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          image = null;
                        });
                      },
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      iconSize: 48,
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context, image);
                      },
                      icon: Icon(Icons.check),
                      color: Colors.white,
                      iconSize: 48,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget CameraView() {
    return Column(
      children: [
        Expanded(
          child: Stack(children: [
            ColorFiltered(
              colorFilter: colorFilters[indexFilter],
              child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CameraPreview(_cameraController)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 16),
                child: IconButton(
                  onPressed: () async {
                    image = await _cameraController.takePicture();
                    image = await applyFilterToImage(
                        image!, colorFilters[indexFilter]);
                    setState(() {});
                  },
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.white,
                  iconSize: 48,
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 10.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorFilters.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    indexFilter = index;
                  });
                },
                child: AspectRatio(
                  aspectRatio: 1, // Chỉ định tỷ lệ khung hình 1:1 (hình vuông)
                  child: ColorFiltered(
                    colorFilter: colorFilters[index],
                    child: CameraPreview(_cameraController),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
