import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/page/splash/splash.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      toolbarHeight: 0.0, // Đặt chiều cao mới của AppBar
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(100.0),  
      child: AppBar(

      toolbarHeight: 54.0, // Đặt chiều cao mới của AppBar
        // elevation: .0,

      // shadowColor: Colors.black,
      // backgroundColor: const Color.fromARGB(31, 187, 187, 187),
      // backgroundColor: Colors.grey.shade300,

      title:
      Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SplashScreen()));
                },
                icon: SizedBox(
                  height: 15.h,
                  width: 10.w,
                  child: Lottie.asset('assets/lottie/splash_cat.json'),
                )),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SplashScreen()));
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
          ]),

      actions: [

        Row(
            mainAxisAlignment: MainAxisAlignment.start,

          children: [

            _buildActionHome(
              context,
              'Show Snackbar',
              PhosphorIcons.chats_circle_fill,
            ),
            _buildActionHome(
              context,
              'Show Snackbar',
              PhosphorIcons.chats_circle_fill,
            ),
          ],
        ),
      ],
    ),
    ),
        ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Widget _buildActionHome(context, title, icon) {
  return Container(
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

    child: GestureDetector
    (
      onTap: (){
        
      },
    child : Icon(
      icon,
      size: 18.sp,
      color: const Color.fromARGB(255, 0, 0, 0),
    ),
    )
  );
}
