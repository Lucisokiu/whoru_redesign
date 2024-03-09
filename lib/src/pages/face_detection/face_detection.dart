import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

// import '../../../main.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  late CameraController _cameraController;
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
        body: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
              child: Container(height: double.infinity,
                child: CameraPreview(_cameraController)),
            ),
          ],
        ));
  }
}
