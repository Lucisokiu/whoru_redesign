import 'package:flutter/material.dart';
import 'package:whoru/src/pages/login/widget/field_form_forgot_pass.dart';

Future<Object?> customForgotPassDialog(
    BuildContext contextScafford,
    ) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Verify Code",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (contextScafford, _, __) => Forgot(contextScafford: contextScafford));
}

class Forgot extends StatefulWidget {
  BuildContext contextScafford;

  Forgot({super.key,required this.contextScafford});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                          ),
                        ),
                        ForgotPassForm(contextScafford:widget.contextScafford),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Divider(),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 16),
                        //       child: Text(
                        //         "OR",
                        //         style: Theme.of(context).textTheme.bodyMedium,
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Divider(),
                        //     ),
                        //   ],
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                        //   child: TextButton(
                        //       onPressed: () {
                        //         // Navigator.of(context).pushReplacement(
                        //         //   MaterialPageRoute(
                        //         //       builder: (context) =>
                        //         //           ()),
                        //         // );
                        //       },
                        //       child: Text(
                        //           "If you don't have Account, Sign up here",
                        //           style:
                        //               Theme.of(context).textTheme.bodyMedium)),
                        // )
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
