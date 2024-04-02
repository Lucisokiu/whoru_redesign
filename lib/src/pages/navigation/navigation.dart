import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/pages/feed/screens/feed_screen.dart';
import 'package:whoru/src/pages/location/location_screen.dart';
import 'package:whoru/src/pages/notification/controller/notifications_controller.dart';
import 'package:whoru/src/pages/notification/screen/notification_screen.dart';
import 'package:whoru/src/pages/user/user.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;

  final _screens = [
    const FeedPage(),
    const NotificationScreen(),
    const LocationPage(),
    const UserPage(),
  ];
  void _notification() async {
    await NotificationsController.init();
    await NotificationsController.requestPermission();
  }
  @override
  void initState() {
    super.initState();
    _notification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: _screens[currentPage],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 0
                    ? PhosphorIconsFill.house
                    : PhosphorIconsThin.house),
                color: Colors.white,
                onPressed: () {
                  print("Home");
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 1
                    ? PhosphorIconsFill.bellSimpleRinging
                    : PhosphorIconsThin.bellSimpleRinging),
                color: Colors.white,
                onPressed: () {
                  print("Chat");
                  setState(() {
                    currentPage = 1;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 2
                    ? PhosphorIconsFill.mapPinLine
                    : PhosphorIconsLight.mapPinLine),
                color: Colors.white,
                onPressed: () {
                  print("Location");
                  setState(() {
                    currentPage = 2;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 3
                    ? PhosphorIconsFill.userCircle
                    : PhosphorIconsThin.userCircle),
                color: Colors.white,
                onPressed: () {
                  print("Profile");
                  setState(() {
                    currentPage = 3;
                  });
                },
              ),
            ],
          ),
        ));
  }
}