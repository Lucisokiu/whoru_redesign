import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import '../../../api/notification.dart';
import '../../../models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin {
  List<NotificationModel> notificationsList = [];

  getNotif() async {
    List<NotificationModel> result = await getAllNotification();
    if (mounted) {
      setState(() {
        notificationsList.addAll(result);
      });
    }
  }

  @override
  void initState() {
    getNotif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: const MyAppBar()),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 11.h),
              itemCount: notificationsList.length,
              itemBuilder: (context, index) {
                final notification = notificationsList[index];
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // NotificationsController.showSimpleNotification(
                      //   title: "Simple Notification",
                      //   body: "This is a simple notification",
                      //   payload: "This is simple data",
                      // );
                    },
                    label: const Text("Simple Notification"),
                  ),
                );
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(notification.avatarUrl),
                  ),
                  title: Text(notification.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Text(notification.content),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.time),
                    ],
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
