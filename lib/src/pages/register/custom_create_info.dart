import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/register/widget/field_form_create_info.dart';

Future<Object?> customCreateInfoDialog(
  BuildContext contextScafford,
) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Create Info",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => CreateInfo(
            contextScafford: contextScafford,
          ));
}

class CreateInfo extends StatefulWidget {
  final BuildContext contextScafford;

  const CreateInfo({required this.contextScafford, super.key});

  @override
  State<CreateInfo> createState() => _CreateInfoState();
}

class _CreateInfoState extends State<CreateInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 75.h,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Create Info",
                            style:
                                TextStyle(fontSize: 34, fontFamily: "Poppins"),
                          ),
                        ),
                        CreateInfoForm(contextScafford: widget.contextScafford),
                      ]),
                    ],
                  ),
                ],
              ),
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
    );
  }
}
