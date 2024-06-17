import 'package:flutter/material.dart';

import '../socket/web_socket_service.dart';
import '../utils/shared_pref/iduser.dart';
import 'navigation/navigation.dart';
import 'notification/controller/notifications_controller.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  WebSocketService webSocketService = WebSocketService();
  // late StreamSubscription<dynamic> messageSubscription;
  int? _id;

  @override
  void initState() {
    super.initState();
    getUser();
    connected();
  }

  getUser() async {
    _id = await getIdUser();
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
