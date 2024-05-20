import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/widget/build_button.dart';
import 'package:whoru/src/pages/splash/splash.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Spacer(),
          buildActionHome(
            context,
            'Create',
            PhosphorIconsFill.plusCircle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildActionHome(
              context,
              'Search',
              PhosphorIconsFill.magnifyingGlass,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildActionHome(
              context,
              'Chat',
              PhosphorIconsFill.wechatLogo,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
