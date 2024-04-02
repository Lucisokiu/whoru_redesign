import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whoru/src/api/log.dart';
import 'package:whoru/src/pages/navigation/navigation.dart';


class ForgotPassForm extends StatefulWidget {
  BuildContext contextScafford;

  ForgotPassForm({
    super.key,
    required this.contextScafford,
  });

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _verifyCodeController = TextEditingController();
  bool showError = false;
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;
  bool _useEmail = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  var response;
  int? id;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
    StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void verify(BuildContext context, String Code) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(const Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        if (id != null) {
          response = await verifyAccount(id!, Code);
          if (response.statusCode == 200) {
            check.fire();
            // show success
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                setState(() {
                  isShowLoading = false;
                });
                Future
                    .delayed(const Duration(seconds: 2), () {})
                    .then(
                        (value) =>
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) => const Navigation(),
                        ),
                                (route) => false));
                }
                });
          }
        } else {
          error.fire();

          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isShowLoading = false;
            });
          });
        }
      } else {
        setState(() {
          isShowLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _useEmail ? "Email" : "Phone",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: Row(
                    children: [
                      _useEmail
                          ? Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Plesea fill this email";
                            }
                            return null;
                          },
                          onSaved: (email) {},
                          obscureText: false,
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          // Màu văn bản nhập vào

                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: SvgPicture.asset(
                                    "assets/icons/email.svg"),
                              )),
                        ),
                      )
                          : Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Plesea fill this number phone";
                            }
                            return null;
                          },
                          onSaved: (phone) {},
                          obscureText: false,
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          // Màu văn bản nhập vào

                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: SvgPicture.asset(
                                    "assets/icons/password.svg"),
                              )),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _useEmail = !_useEmail;
                            print(_useEmail);
                          });
                        },
                        icon: Icon(Icons.sync_alt),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    id = await ForgotPassword(_emailController.text);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF77D8E),
                  ),
                  child: Text("Send Code",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium),
                ),
                Text(
                  "Forgot Code",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _verifyCodeController,
                    onSaved: (code) {},
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .color),
                    // Màu văn bản nhập vào
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color:
                            Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .color),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        verify(context, _verifyCodeController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF77D8E),
                          minimumSize: const Size(double.infinity, 56),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25)))),
                      icon: const Icon(
                        CupertinoIcons.arrow_right,
                        color: Color(0xFFFE0037),
                      ),
                      label: const Text("Verify Code")),
                )
              ],
            )),
        isShowLoading
            ? CustomPositioned(
            child: RiveAnimation.asset(
              "assets/RiveAssets/check.riv",
              onInit: (artboard) {
                StateMachineController controller =
                getRiveController(artboard);
                check = controller.findSMI("Check") as SMITrigger;
                error = controller.findSMI("Error") as SMITrigger;
                reset = controller.findSMI("Reset") as SMITrigger;
              },
            ))
            : Container(),
        isShowConfetti
            ? CustomPositioned(
            child: Transform.scale(
              scale: 6,
              child: RiveAnimation.asset(
                "assets/RiveAssets/confetti.riv",
                onInit: (artboard) {
                  StateMachineController controller =
                  getRiveController(artboard);
                  confetti =
                  controller.findSMI("Trigger explosion") as SMITrigger;
                },
              ),
            ))
            : const SizedBox()
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
