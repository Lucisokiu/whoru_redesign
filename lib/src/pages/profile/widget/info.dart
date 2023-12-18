import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/User.dart';

Widget info(BuildContext context, UserModel user) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;
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


    // ElevatedButton(
    //   onPressed: () {
    //     // Handle follow button tap
    //     // You can implement the logic to follow/unfollow the user here
    //   },
    //   style: ElevatedButton.styleFrom(
    //     primary: Colors.blue, // Button color
    //     onPrimary: Colors.white, // Text color
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8.0),
    //     ),
    //     padding: EdgeInsets.symmetric(horizontal: 16.0),
    //   ),
    //   child: Text(
    //     'Follow',
    //     style: TextStyle(fontSize: 16.0),
    //   ),
    // ),
    const Row(
      // mainAxisAlignment:
      //     MainAxisAlignment.center, // Căn giữa các phần tử theo chiều ngang

      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "99",
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
        Expanded(
          child: Column(
            children: [
              Text(
                "19",
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
        Expanded(
          child: Column(
            children: [
              Text(
                "999",
                style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                "Like",
                style: TextStyle(
                  fontFamily: "Lobster",
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    SizedBox(
      height: 10.h,
    ),
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Container(
    //       alignment: Alignment.topLeft,
    //       child: Text(
    //         'Study at: ${user.work}',
    //         style: const TextStyle(
    //           fontFamily: "Lato",
    //           fontWeight: FontWeight.bold,
    //           fontSize: 24,
    //         ),
    //       ),
    //     ),
    //     Container(
    //       alignment: Alignment.topLeft,
    //       child: Text(
    //         user.study,
    //         style: const TextStyle(
    //           fontFamily: "Lato",
    //           fontWeight: FontWeight.bold,
    //           fontSize: 24,
    //         ),
    //       ),
    //     ),
    //   ],
    // )
  ]);
}
