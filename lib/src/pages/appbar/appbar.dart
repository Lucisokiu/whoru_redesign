import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/widget/build_button.dart';
import 'package:whoru/src/pages/camera/camera_screen.dart';
import 'package:whoru/src/pages/chat/chat_screen.dart';
import 'package:whoru/src/pages/splash/splash.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 12.h, // Chiều cao của Row
          color: Colors.white,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ),
                    (route) => false, // Xóa toàn bộ màn hình khỏi stack
                  );
                },
                icon: SizedBox(
                  height: 15.h,
                  width: 10.w,
                  child: Lottie.asset('assets/lottie/splash_cat.json'),
                )),
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false, // Xóa toàn bộ màn hình khỏi stack
                );
              },
              icon: Text.rich(
                TextSpan(
                  text: 'Whoru',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lobster',
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25.w,
              // height: 0.h,
            ),
            buildActionHome(
              context,
              'Camera',
              PhosphorIcons.fill.gameController,
              // PhosphorIcons.fill.chatCircle,
            ),
            SizedBox(
              // height: 0.h,
              width: 3.w,
            ),
            buildActionHome(
              context,
              'Chat',
              PhosphorIcons.fill.chatTeardrop,

              // PhosphorIcons.fill.chatCircle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
