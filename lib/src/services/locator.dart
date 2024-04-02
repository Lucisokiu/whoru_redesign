import 'package:get_it/get_it.dart';

import '../pages/face_detection/face_recogtion/services/camera.service.dart';
import '../pages/face_detection/face_recogtion/services/face_detector_service.dart';
import '../pages/face_detection/face_recogtion/services/ml_service.dart';

final locator = GetIt.instance;

void setupServices() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
  locator.registerLazySingleton<FaceDetectorService>(() => FaceDetectorService());
  locator.registerLazySingleton<MLService>(() => MLService());
}