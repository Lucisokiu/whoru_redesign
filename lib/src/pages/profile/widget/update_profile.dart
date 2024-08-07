import 'package:flutter/material.dart';
import 'package:whoru/src/pages/profile/widget/change_password.dart';
import 'package:whoru/src/pages/profile/widget/update_avatar.dart';
import 'package:whoru/src/pages/profile/widget/update_background.dart';
import 'package:whoru/src/pages/profile/widget/update_info.dart';

Future<void> customUpdateProfileDialog(
    BuildContext context, String title) async {
  await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: title,
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 520,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    resizeToAvoidBottomInset: false,
                    body: (title == 'avatar')
                        ? const UpdateAvatar()
                        : (title == 'background')
                            ? const UpdateBackground()
                            : (title == 'changePass')
                                ? const ChangePassword()
                                : const UpdateInfo(),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -15,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ));
}
