import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/widget/build_button.dart';
import 'package:whoru/src/pages/camera/camera_screen.dart';
import 'package:whoru/src/pages/chat/ChatPage.dart';
import 'package:whoru/src/pages/splash/splash.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 2.h),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 10.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: SizedBox(
                      height: 15.h,
                      width: 15.w,
                      child: Lottie.asset('assets/lottie/splash_cat.json'),
                    )),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ),
                      (route) => false, // Xóa toàn bộ màn hình khỏi stack
                    );
                  },
                  child: Text(
                    'Whoru',
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                Spacer(),
                buildActionHome(
                  context,
                  'Create',
                  PhosphorIcons.fill.plusCircle,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildActionHome(
                    context,
                    'Search',
                    PhosphorIcons.fill.magnifyingGlass,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildActionHome(
                    context,
                    'Chat',
                    PhosphorIcons.fill.wechatLogo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
