import 'dart:async';
import 'dart:convert';

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

class SignUpForm extends StatefulWidget {
  BuildContext contextScafford;

  SignUpForm({
    super.key,
    required this.contextScafford,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _useEmail = true;
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;
  var response;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  void signup(BuildContext context, String userName, String password,
      String email, String phone) {
    Map<dynamic, dynamic> SignUpData = {
      'userName': userName,
      'password': password,
      'email': email,
      'phone': phone,
    };

    Future.delayed(const Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        response = await CreateAccount(SignUpData);
        if (response.statusCode == 201) {
          Map<String, dynamic> jsonMap = json.decode(response);
          int userId = jsonMap['userId'];
          check.fire();
          Future.delayed(Duration(milliseconds: 800), () {
            if (mounted) {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
              Future.delayed(const Duration(seconds: 2), () {
                if(_emailController.text != null){
                  sendCodeByEmail(userId);
                }else {
                  sendCodeBySMS(userId);
                }

                Navigator.of(context).pop();
              });
            }
          }).then((value) => customVerifyDialog(widget.contextScafford));
        } else {
          error.fire();
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isShowLoading = false;
            });
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.clear();
    _passwordController.clear();
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
                  "Usname",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _userNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this Usname";
                      }
                      return null;
                    },
                    onSaved: (username) {},
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                    // Màu văn bản nhập vào
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
                Text(
                  "Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this Password";
                      }
                      return null;
                    },
                    onSaved: (password) {},
                    obscureText: true,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                    // Màu văn bản nhập vào

                    decoration: InputDecoration(
                        prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset("assets/icons/password.svg"),
                    )),
                  ),
                ),
                Text(
                  "Confirm Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _confirmpasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea Confirm Password";
                      }
                      if (_confirmpasswordController.text !=
                          _passwordController.text) {
                        return "Confirm Password not match";
                      }
                      return null;
                    },
                    onSaved: (confirm) {},
                    obscureText: true,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color),
                    // Màu văn bản nhập vào

                    decoration: InputDecoration(
                        prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset("assets/icons/password.svg"),
                    )),
                  ),
                ),
                Text(
                  _useEmail ? "Email" : "Phone",
                  style: Theme.of(context).textTheme.bodyMedium,
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
                                obscureText: true,
                                style: TextStyle(
                                    color: Theme.of(context)
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
                                obscureText: true,
                                style: TextStyle(
                                    color: Theme.of(context)
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        signup(
                            context,
                            _userNameController.text,
                            _passwordController.text,
                            _emailController.text,
                            _phoneController.text);
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
