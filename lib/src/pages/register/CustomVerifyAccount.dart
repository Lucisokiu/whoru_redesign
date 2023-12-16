import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whoru/src/pages/register/widget/FieldFormSignUp.dart';
import 'package:whoru/src/pages/login/widget/FieldFormSignIn.dart';

Future<Object?> customVerifyDialog(
  BuildContext context,
) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Verify Code",
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Verify());
}

class Verify extends StatefulWidget {

  Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 520,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                        const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                        ),
                        // SignUpForm(),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "OR",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextButton(
                              onPressed: () {
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           ()),
                                // );
                              },
                              child: Text(
                                  "If you don't have Account, Sign up here",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium)),
                        )
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
