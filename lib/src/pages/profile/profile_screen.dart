import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/model/user.dart';
import 'package:whoru/src/pages/profile/widget/info.dart';
import 'package:whoru/src/pages/profile/widget/tabbar_profile.dart';
import 'package:whoru/src/utils/get_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.find<ThemeController>();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: SafeArea(
      //   bottom: false,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      child: ClipRRect(
                        child: Image.network(
                          user.avt,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: EdgeInsets.only(top: screenHeight * 0.3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(40), // Bán kính góc trên
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        info(context),

                        IconButton(
                            onPressed: () => {themeController.toggleDarkMode()},
                            icon: const Icon(Icons.brightness_2)),
                        const TabBarProfile(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          IconButton(
              icon: Icon(PhosphorIcons.thin.arrowArcLeft), onPressed: () {}),
        ],
      ),
      // ),
    );
  }
}
