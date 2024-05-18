import 'package:flutter/material.dart';
import 'package:whoru/src/pages/login/widget/custom_signIn.dart';
import 'package:whoru/src/pages/register/widget/FieldFormSignUp.dart';

Future<Object?> customRegisDialog(
  BuildContext contextScafford,
) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Sign up",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => Regis(
            contextScafford: contextScafford,
          ));
}

class Regis extends StatefulWidget {
  BuildContext contextScafford;

  Regis({required this.contextScafford, super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  late bool isSignInDialogShown;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 720,
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
                        const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                        ),
                        SignUpForm(contextScafford: widget.contextScafford),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "OR",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            const Expanded(
                              child: Divider(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Future.delayed(const Duration(milliseconds: 800), () {
                                  Navigator.of(context).pop();
                                }).then((isSignInDialogShown) =>
                                    customSigninDialog(widget.contextScafford,
                                        onClosed: (_) {
                                    }));
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
