import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/follow.dart';
import 'package:whoru/src/models/user_chat.dart';
import 'package:whoru/src/pages/feed/widget/list_like_dialog.dart';

import '../../../models/user_model.dart';
import '../../../utils/shared_pref/iduser.dart';
import '../../chat/screens/individual_page.dart';

Widget info(BuildContext context, UserModel user, bool isMy) {
  final double screenHeight = MediaQuery.of(context).size.height;
  // final double screenWidth = MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    child: StatefulBuilder(builder: (context, StateSetter setState) {
      return Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 15.h,
            width: 40.w,
            margin: EdgeInsets.only(top: screenHeight * 0.22),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.grey.shade200,
                color: Colors.black),
            child: CachedNetworkImage(
                imageUrl: user.avt,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      backgroundColor: Colors.transparent,
                    )),
          ),
        ),
        Text(
          user.fullName,
          style: const TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isMy) {
                    getAllFollower()
                        .then((listLike) => showListDialog(context, listLike));
                  }
                },
                child: Column(
                  children: [
                    Text(
                      user.followerCount.toString(),
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      "Followers",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isMy) {
                    getAllFollowing()
                        .then((listLike) => showListDialog(context, listLike));
                  }
                },
                child: Column(
                  children: [
                    Text(
                      user.followingCount.toString(),
                      style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      "Following",
                      style: TextStyle(
                        fontFamily: "Lobster",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        (isMy)
            ? Container()
            : Row(
                children: [
                  (user.isFollow)
                      ? Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              unFollowUser(user.id);

                              setState(() {
                                user.followerCount--;
                                user.isFollow = !user.isFollow;
                              });
                            },
                            child: const Text('unFollow'),
                          ),
                        )
                      : Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              followUser(user.id);
                              setState(() {
                                user.followerCount++;
                                user.isFollow = !user.isFollow;
                              });
                            },
                            child: const Text('Follow'),
                          ),
                        ),
                  const SizedBox(width: 16), // Khoảng cách giữa hai nút
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // int? currentId = await getIdUser();
                        // UserChat userChat = UserChat(
                        //     idUser: user.id,
                        //     fullName: user.fullName,
                        //     avatar: user.avt);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (contex) => IndividualPage(
                        //         currentId: currentId!, user: userChat),
                        //   ),
                        // );

                        getIdUser().then((currentId) {
                          UserChat userChat = UserChat(
                            idUser: user.id,
                            fullName: user.fullName,
                            avatar: user.avt,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (contex) => IndividualPage(
                                currentId: currentId!,
                                user: userChat,
                              ),
                            ),
                          );
                        });
                      },
                      child: const Text('Message'),
                    ),
                  ),
                ],
              ),
        SizedBox(
          height: 2.h,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // alignment: Alignment.topLeft,
                  child: Text(
                    'Work at: ${user.work}',
                    style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  // alignment: Alignment.topLeft,
                  child: Text(
                    'Study at: ${user.study}',
                    style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  // alignment: Alignment.topLeft,
                  child: Text(
                    'Description: ${user.description}',
                    style: const TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        )
      ]);
    }),
  );
}
