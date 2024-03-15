import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import '../../../model/NotificationModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationModel> notifications = [
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'John Doe',
      time: '2 hours ago',
      content: 'You have a new friend request.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Jane Smith',
      time: '5 hours ago',
      content: 'Your post was liked by 3 people.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
    NotificationModel(
      avatarUrl: 'https://via.placeholder.com/150',
      name: 'Alice Johnson',
      time: 'Yesterday',
      content: 'You have a new follower.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: const MyAppBar()),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 0, bottom: 11.h),

              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                //   Container(
                //     child: Center(
                //       child: ElevatedButton.icon(
                //         icon: const Icon(Icons.notifications_outlined),
                //         onPressed: () {
                //           NotificationsController.showSimpleNotification(
                //             title: "Simple Notification",
                //             body: "This is a simple notification",
                //             payload: "This is simple data",
                //           );
                //         },
                //         label: const Text("Simple Notification"),
                //       ),
                //     ),
                //   ),
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
}
