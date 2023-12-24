import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/pages/login/LoginSreen.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:whoru/src/utils/get_theme.dart';
import 'package:whoru/src/utils/token.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // bool? darkMode;
  final ThemeController themeController = Get.find<ThemeController>();

  // getTheme() {
  //   setState(() async {
  //     darkMode = await themeController.getDarkMode();
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Change to start
        children: [
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Handle button tap
                // Navigate to user profile page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Add space between widgets
                  children: [
                    // CircleAvatar( // Add a circular image
                    //   radius: 24,
                    //   backgroundImage: AssetImage('images/avatar.jpg'), // Replace with your image asset
                    // ),
                    Text(
                      'My account', // Add a label
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ProfilePage(isMy: true)));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: TextButton.icon(
              onPressed: () {
                // Handle button tap
                // Change the background color
              },
              icon: Icon(
                Icons.color_lens, // Choose an appropriate icon
                size: 24.0,
              ),
              label: Row(
                children: [
                  Text(
                    'Change Theme',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.change_circle_outlined),
                    onPressed: () {
                      themeController.toggleDarkMode();
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: TextButton.icon(
              onPressed: () async {
                deleteToken();
                deleteIdUser();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => LoginScreen()),
                    (route) => false);
              },
              icon: Icon(
                Icons.account_circle, // Choose an appropriate icon
                size: 24.0,
              ),
              label: Row(
                children: [
                  Text(
                    'Log out',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.logout_outlined),
                    onPressed: () async {
                      deleteToken();
                      deleteIdUser();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => LoginScreen()),
                              (route) => false);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
