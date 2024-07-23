import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:whoru/src/pages/splash/splash.dart';

import '../../../api/follow.dart';
import '../../../models/location_models.dart';
import '../../../models/user_chat.dart';
import '../../../models/user_model.dart';
import '../../chat/screens/individual_page.dart';
import '../../user/controller/language/app_localization.dart';

Future<Object?> cardUser(
  BuildContext contextScafford,
  UserModel? user,
  UserLocation? userLocation,
) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Create Info",
      context: contextScafford,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, 1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) => CardUserMap(
            contextScafford: contextScafford,
            user: user,
            userLocation: userLocation,
          ));
}

class CardUserMap extends StatefulWidget {
  final BuildContext contextScafford;
  final UserModel? user;
  final UserLocation? userLocation;

  const CardUserMap(
      {super.key, required this.contextScafford, this.user, this.userLocation});

  @override
  State<CardUserMap> createState() => _CardUserMapState();
}

class _CardUserMapState extends State<CardUserMap> {
  bool isUserLocal = true;
  bool isFollow = false;

  @override
  void initState() {
    isUserLocal = widget.user != null;
    if (widget.user != null) {
      isFollow = widget.user!.isFollow;
    }
    super.initState();
  }

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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (contex) => isUserLocal
                                ? const ProfilePage(
                                    isMy: true,
                                  )
                                : ProfilePage(
                                    isMy: false,
                                    idUser: widget.user!.id,
                                  ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 5.h,
                        backgroundImage: NetworkImage(
                          isUserLocal
                              ? widget.user!.avt
                              : widget.userLocation!.avt,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            isUserLocal
                                ? widget.user!.fullName
                                : widget.userLocation!.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color),
                          ),
                          Text(
                            isUserLocal
                                ? widget.user!.description
                                : widget.userLocation!.note ?? '',
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
                if (!isUserLocal)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (!isFollow) {
                            followUser(widget.user!.id);
                            setState(() {
                              isFollow = !isFollow;
                            });
                          } else {
                            unFollowUser(widget.user!.id);
                            setState(() {
                              isFollow = !isFollow;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                                !isFollow ? Icons.person_add : Icons.person_off),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(!isFollow ? AppLocalization.of(context)
                                .getTranslatedValues('follow') : AppLocalization.of(context)
                                .getTranslatedValues('unfollow') ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) => IndividualPage(
                                        user: UserChat.fromUserModel(
                                            widget.user!),
                                        currentId: localIdUser,
                                      )));
                        },
                        child: Row(
                          children: [
                            Icon(
                              PhosphorIcons.chatCircleDots(),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(AppLocalization.of(context)
                                .getTranslatedValues('message1')),
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
