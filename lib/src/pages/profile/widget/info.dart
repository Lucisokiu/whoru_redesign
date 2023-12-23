import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/follow.dart';
import 'package:whoru/src/model/User.dart';
import 'package:whoru/src/pages/feed/widget/ListDialog.dart';

Widget info(BuildContext context, UserModel user, bool isMy) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;

  return SingleChildScrollView(
    child: StatefulBuilder(
      builder: (context, StateSetter setState) {
        return Column(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 150,
              width: 150,
              margin: EdgeInsets.only(top: screenHeight * 0.22),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  // color: Colors.grey.shade200,
                  color: Colors.black),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: Image.network(
                  user.avt,
                  fit: BoxFit.cover,
                ),
              ),
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
                  onTap: () async {
                    if (isMy) {
                      List<Map<String,
                          dynamic>> listLike = await getAllFollower();
                      showListDialog(context, listLike);
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        user.followerCount.toString(),
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
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
                  onTap: () async {
                    if (isMy) {
                      List<Map<String,
                          dynamic>> listLike = await getAllFollowing();
                      showListDialog(context, listLike);
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        user.followingCount.toString(),
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
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
                  child: Text('unFollow'),
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
                  child: Text('Follow'),
                ),
              ),
              SizedBox(width: 16), // Khoảng cách giữa hai nút
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút "Message" được nhấn
                  },
                  child: Text('Message'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Study at: ${user.work}',
                  style: const TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  user.study,
                  style: const TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          )
        ]
        );
      }
    ),
  );
}
