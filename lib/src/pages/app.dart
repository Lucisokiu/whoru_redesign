import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/pages/login/login_screen.dart';
import 'package:whoru/src/utils/constant.dart';
import 'package:whoru/src/utils/hive/box_user.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';

import '../models/user_model.dart';
import '../socket/web_socket_service.dart';
import '../utils/sensitive_words.dart';
import '../utils/shared_pref/iduser.dart';
import 'camera/camera_regis_face.dart';
import 'face_detection/ML/view/face_register_view.dart';
import 'navigation/navigation.dart';
import 'splash/splash.dart';

final RegExp sensitiveWordPattern = RegExp(
  '\\b(${sensitiveWords.join('|')})\\b',
  caseSensitive: false,
);

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late WebSocketService webSocketService;

  @override
  void initState() {
    webSocketService = WebSocketService();
    initialize();

    super.initState();
  }

  initialize() async {
    await initBox();
    connected();
  }

  initBox() async {
    await Hive.openBox(boxUser);
    saveUser(localUser);
  }

  void connected() {
    webSocketService.connect();
    if (mounted) {
      webSocketService.listenSocket(context);
    }
  }

  @override
  void dispose() {
    webSocketService.close();
    print("dispose App");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Navigation();
  }
}
