import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/appbar/widget/build_PopupMenu.dart';
import 'package:whoru/src/pages/camera/camera_screen.dart';
import 'package:whoru/src/pages/chat/chat_screen.dart';
import 'package:whoru/src/pages/login/login_screen.dart';
import 'package:whoru/src/pages/search/controller/search_bar.dart';

Widget buildActionHome(context, title, icon) {
  return InkWell(
      onTap: () {
        if (title == "Camera") {
          showPopupMenu(context);
        }
        if (title == "Search") {
          // showSearch(
          //   context: context,
          //   delegate: CustomSearch(),
          // );
        }
        if (title == "Chat") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(), // ChatPage(),
            ),
          );
        }
      },
      child: Container(
        width: 8.w,
        margin: EdgeInsets.only(bottom: 2.sp),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,

          // don't beauttiful. i think so
          // for light mode
          // boxShadow: [
          //   BoxShadow(
          //     // color: Colors.purple,
          //     spreadRadius: 1,
          //     blurRadius: 2,
          //     offset: Offset(2.0, 2.0),
          //   ),
          //   BoxShadow(
          //     // color: Colors.white,
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: Offset(-1.0, -1.0),
          //   ),
          // ],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 23.sp,
          // color: Theme.of(context).buttonTheme.colorScheme!.primary,
        ),
      ));
}
