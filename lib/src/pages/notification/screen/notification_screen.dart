import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
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
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ProfilePage(
                            isMy: false,
                            idUser: notificationsList[index].idUser,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(notification.avatarUrl),
                    ),
                  ),
                  title: Text(
                    notification.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Text(notification.content),
                    ],
                  ),
                  trailing: Text(notification.time,
                      style: Theme.of(context).textTheme.bodyMedium),
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
