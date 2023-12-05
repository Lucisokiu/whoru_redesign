import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/model/user.dart';
import 'package:whoru/src/pages/login/login_screen.dart';
import 'package:whoru/src/pages/profile/widget/info.dart';
import 'package:whoru/src/pages/profile/widget/tabbar_profile.dart';
import 'package:whoru/src/utils/get_theme.dart';
import 'package:whoru/src/utils/token.dart';

import '../feed/widget/skeleton_loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int? idUser;
  UserModel? user;
  fetchData() async {
    idUser = await getIdUser();
    if (mounted) {
      if (idUser != null) {
        user = await getInfoUserById(idUser!);
        setState(() {});
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
          // SafeArea(
          //   bottom: false,
          //   child:
          Stack(
        children: [
          (user != null)
              ? Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 40.h,
                            child: ClipRRect(
                              child: Image.network(
                                user!.background,
                                fit: BoxFit.fitHeight,
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
                          Positioned(
                            top: screenHeight * 0.3,
                            right: 0,
                            child: IconButton(
                                onPressed: () =>
                                    {themeController.toggleDarkMode()},
                                icon: const Icon(Icons.brightness_2)),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              info(context, user!),

                              // const TabBarProfile(),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Expanded(child: MySkeletonLoadingWidget()),
        ],
        // ),
      ),
    );
  }
}
