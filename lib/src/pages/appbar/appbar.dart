import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/camera/camera_page.dart';
import 'package:whoru/src/pages/chat/chat_page.dart';
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
            _buildActionHome(
              context,
              'Camera',
              PhosphorIcons.fill.gameController,
              // PhosphorIcons.fill.chatCircle,
            ),
            SizedBox(
              // height: 0.h,
              width: 3.w,
            ),
            _buildActionHome(
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

Widget _buildActionHome(context, title, icon) {
  return InkWell(
      onTap: () {
        if (title == "Camera") {
          print("Camera");

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraPage(),
            ),
          );
        }

        if (title == "Chat") {
          print("Chat");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatPage(),
            ),
          );
        }
      },
      child: Container(
        width: 65, // Kích thước chiều rộng của container
        height: 70, // Kích thước chiều cao của container
        margin: EdgeInsets.only(bottom: 2.sp),
        padding: EdgeInsets.all(5.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.purple,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2.0, 2.0),
            ),
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(-1.0, -1.0),
            ),
          ],
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ));
}
