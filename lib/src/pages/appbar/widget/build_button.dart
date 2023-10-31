
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/camera/camera_screen.dart';
import 'package:whoru/src/pages/chat/chat_screen.dart';

Widget buildActionHome(context, title, icon) {
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


class AppBarIconContainer extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final Color iconColor;
  final Widget? text;
  final bool? textBool;
  final double height;
  final double width;
  const AppBarIconContainer({Key? key, this.icon, this.color, required this.iconColor, this.text, this.textBool , required this.height , required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: textBool == true ? text : Icon(icon , size: 21 , color: iconColor),
    );
  }
}