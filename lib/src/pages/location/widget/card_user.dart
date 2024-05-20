import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../models/user_model.dart';

Future<Object?> cardUser(
  BuildContext contextScafford,
  UserModel user,
) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Create Info",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => CardUserMap(
            contextScafford: contextScafford,
            user: user,
          ));
}

class CardUserMap extends StatefulWidget {
  final BuildContext contextScafford;
  final UserModel user;
  const CardUserMap({super.key, required this.contextScafford, required this.user});

  @override
  State<CardUserMap> createState() => _CardUserMapState();
}

class _CardUserMapState extends State<CardUserMap> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 25.h,
        // margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(40))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5.h,
                      backgroundImage: NetworkImage(
                        widget.user.avt,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            widget.user.fullName,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          Text(
                            widget.user.description,
                            style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.person_add),
                          SizedBox(
                            width: 1.w,
                          ),
                          const Text("Follow"),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.chatCircleDots(),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          const Text("Message"),
                        ],
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
