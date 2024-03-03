import 'package:flutter/material.dart';
import 'package:whoru/src/pages/notification/controller/NotificationController.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Notifications")),
        body: SizedBox(
            height: double.infinity,
            child: Center(
                child: ElevatedButton.icon(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                NotificationsController.showSimpleNotification(
                title: "Simple Notification",
                body: "This is a simple notification",
                payload: "This is simple data");
              },
              label: const Text("Simple Notification"),
            ))));
  }
}
