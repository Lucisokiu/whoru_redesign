import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../utils/shared_pref/notification.dart';

class NotificationsController {
  static bool? isNotification;

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future requestPermission() async {
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<bool> updateNoti() async {
    await setNotif(!noti);
    isNotification = await getNotif();
    return isNotification ?? true;
  }

  static Future init() async {
    isNotification = await getNotif();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (detail) {},
    );
  }

  static Future showSimpleNotification({
    required int index, // UserID
    required String title, //name
    required String body, //title ( like )
    required String payload, //avt
  }) async {
    String titleLike = "like your post";
    String titleFollow = "follow you";
    if (body == "Like") {
      body = '$title $titleLike';
    } else {
      body = '$title $titleFollow';
    }
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(index.toString(), title,
            channelDescription: payload,
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(index, title, body, notificationDetails, payload: payload);
    print("showSimpleNotification");
  }

  static bool get noti => isNotification ?? false;
}
