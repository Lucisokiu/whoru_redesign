import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
  int _currentCameraIndex = 0; // Biến để theo dõi camera hiện tại
  bool _showFilter = false;
  _initCamera() {
    _cameraController =
        CameraController(cameras[_currentCameraIndex], ResolutionPreset.max);
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

    _initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Camera"),
        ),
        body: image == null ? cameraView() : imageView());
  }

  Widget imageView() {
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
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          image = null;
                        });
                      },
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                      iconSize: 48,
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context, image);
                      },
                      icon: const Icon(Icons.check),
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

  Widget cameraView() {
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _toggleCamera,
                      icon: PhosphorIcon(
                          PhosphorIcons.cameraRotate(PhosphorIconsStyle.light)),
                      color: Colors.white,
                      iconSize: 48,
                    ),
                    GestureDetector(
                      onTap: () async {
                        image = await _cameraController.takePicture();
                        image = await applyFilterToImage(
                          image!,
                          colorFilters[indexFilter],
                        );
                        setState(() {});
                      },
                      child: Container(
                        height: 10.h,
                        width: 10.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // Màu viền
                            width: 3, // Độ dày của viền
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.sp),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.transparent, // Màu viền

                                width: 3, // Độ dày của viền
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          _showFilter = !_showFilter;
                        });
                      },
                      icon: const Icon(Icons.filter_center_focus),
                      color: Colors.white,
                      iconSize: 48,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
        _showFilter
            ? SizedBox(
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
                        aspectRatio: 1,
                        child: ColorFiltered(
                          colorFilter: colorFilters[index],
                          child: CameraPreview(_cameraController),
                        ),
                      ),
                    );
                  },
                ),
              )
            : Container(),
      ],
    );
  }

  void _toggleCamera() async {
    await _cameraController.dispose();
    setState(() {
      _currentCameraIndex = (_currentCameraIndex + 1) % cameras.length;
      _initCamera();
    });
  }
}
