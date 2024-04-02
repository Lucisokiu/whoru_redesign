import 'package:flutter/material.dart';
import 'package:whoru/src/pages/login/widget/custom_forgot_password.dart';
import 'package:whoru/src/pages/register/custom_signup.dart';
import 'package:whoru/src/pages/login/widget/field_form_signin.dart';

Future<Object?> customSigninDialog(BuildContext contextScafford,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => LoginDialog(
            contextScafford: contextScafford,
          )).then((onClosed));
}

class LoginDialog extends StatefulWidget {
  final BuildContext contextScafford;

  LoginDialog({super.key, required this.contextScafford});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 520,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(children: [
                    const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                    ),
                    SignInForm(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: TextButton(
                          onPressed: () {
                            Future.delayed(Duration(milliseconds: 800), () {
                              Navigator.of(context).pop();
                            }).then((_) => {
                                  customForgotPassDialog(
                                      widget.contextScafford)
                                });
                          },
                          child: Text(
                              "If you forgot your Account, click here",
                              style: Theme.of(context).textTheme.bodyMedium)),
                    ),
                    Row(
                      children: [
                        const Expanded(
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
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: TextButton(
                          onPressed: () {
                            Future.delayed(Duration(milliseconds: 800), () {
                              Navigator.of(context).pop();
                            }).then((_) =>
                                customRegisDialog(widget.contextScafford));
                          },
                          child: Text(
                              "If you don't have Account, Sign up here",
                              style: Theme.of(context).textTheme.bodyMedium)),
                    )
                  ]),
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
