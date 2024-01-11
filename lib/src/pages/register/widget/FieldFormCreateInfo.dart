import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/pages/navigation/navigation.dart';

class CreateInfoForm extends StatefulWidget {
  BuildContext contextScafford;

  CreateInfoForm({
    super.key,
    required this.contextScafford,

  });

  @override
  State<CreateInfoForm> createState() => _CreateInfoFormState();
}

class _CreateInfoFormState extends State<CreateInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _studyController = TextEditingController();
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  bool showError = false;
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

  void createInfo(BuildContext context,String fullName, String description, String work, String study) {

    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(const Duration(seconds: 1), () async {
      if (_formKey.currentState!.validate()) {
        Map<dynamic, dynamic> createInfoData = {
          'fullName': fullName,
          'description': description,
          'work': work,
          'study': study,
        };
        response = await createInfoUser(createInfoData);

        if (response) {
          check.fire();
          // show success
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                isShowLoading = false;

              });
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Navigation()),
                      (Route<dynamic> route) => false,
                );
              });
            }
          });
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
                  "Full Name",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _fullNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this fileds";
                      }
                      return null;
                    },
                    onSaved: (code) {},
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
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        )),
                  ),
                ),
                Text(
                  "Study at?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _studyController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this fileds";
                      }
                      return null;
                    },
                    onSaved: (code) {},
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
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        )),
                  ),
                ),
                Text(
                  "Woking at?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _workController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this fileds";
                      }
                      return null;
                    },
                    onSaved: (code) {},
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
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        )),
                  ),
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: TextFormField(
                    controller: _desController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Plesea fill this fileds";
                      }
                      return null;
                    },
                    onSaved: (code) {},
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
                          child: SvgPicture.asset("assets/icons/password.svg"),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        createInfo(context, _fullNameController.text,_desController.text,_workController.text,_studyController.text);
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
                      label: const Text("Create Info")),
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
