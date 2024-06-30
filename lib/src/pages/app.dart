import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/utils/constant.dart';
import 'package:whoru/src/utils/hive/box_user.dart';

import '../models/user_model.dart';
import '../socket/web_socket_service.dart';
import '../utils/shared_pref/iduser.dart';
import 'navigation/navigation.dart';

late int localIdUser;
late UserModel localUser;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  WebSocketService webSocketService = WebSocketService();
  int? _id;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  initialize() async {
    await getUser();
    await initBox();
    connected();
  }

  initBox() async {
    await Hive.openBox(boxUser);
    saveUser(_user!);
  }

  getUser() async {
    _id = await getIdUser();
    _user = await getInfoUserById(_id!);
    localIdUser = _id!;
    localUser = _user!;
  }

  void connected() {
    webSocketService.connect();
    webSocketService.listenCall(context, _id);
    webSocketService.listenNotif();
  }

  @override
  void dispose() {
    super.dispose();
    webSocketService.close();
  }

  @override
  Widget build(BuildContext context) {
    return const Navigation();
  }
}
