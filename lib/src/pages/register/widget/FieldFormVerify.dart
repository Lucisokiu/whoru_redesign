import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whoru/src/api/log.dart';
import 'package:whoru/src/api/user.dart';
import 'package:whoru/src/model/Login.dart';
import 'package:whoru/src/pages/navigation/navigation.dart';
import 'package:whoru/src/pages/register/CustomSignUp.dart';
import 'package:whoru/src/pages/register/CustomVerifyAccount.dart';

class VerifyForm extends StatefulWidget {
  VerifyForm({
    super.key,
  });

  @override
  State<VerifyForm> createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _verifyCodeController = TextEditingController();
  // bool showError = false;

  var response;
  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void verify(BuildContext context,String Code) {
    Future.delayed(const Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        // if (response.statusCode == 200) {
        //   // show success
        //   Future.delayed(const Duration(seconds: 2), () {
        //     if (mounted) {
        //       setState(() {});
        //       Future.delayed(const Duration(seconds: 2), () {
        //         Navigator.of(context).pushAndRemoveUntil(
        //           MaterialPageRoute(builder: (context) => const Navigation()),
        //           (Route<dynamic> route) => false,
        //         );
        //       });
        //     }
        //   });
        // } else {
        //   Future.delayed(Duration(seconds: 2), () {
        //     setState(() {});
        //   });
        // }
      } else {
        setState(() {
          // showError = true;
        });
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            // showError = false;
          });
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
                  "Verify Code",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _verifyCodeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this fileds";
                      }
                      return null;
                    },
                    onSaved: (username) {},
                    style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .color), // Màu văn bản nhập vào
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset("assets/icons/email.svg"),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        verify(context, _verifyCodeController.text);
                        Future.delayed(Duration(milliseconds: 800), () {
                          customVerifyDialog(context);
                        });
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
                      label: const Text("Register")),
                )
              ],
            )),
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
