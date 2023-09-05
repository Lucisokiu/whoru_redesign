import 'package:flutter/material.dart';
import 'package:whoru/src/model/user.dart';
import 'package:whoru/src/pages/profile/widget/tabbar_profile.dart';

Widget info(BuildContext context) {
  final double screenHeight = MediaQuery.of(context).size.height;
  final double screenWidth = MediaQuery.of(context).size.width;
  return Column(children: [
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.only(top: screenHeight * 0.22),
        decoration: BoxDecoration(
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
      user.username,
      style: TextStyle(
        fontFamily: "Lato",
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Căn giữa các phần tử theo chiều ngang

      children: [
        Expanded(
          child: Container(
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
        ),
        Expanded(
          child: Container(
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
        ),
        Expanded(
          child: Container(
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
        ),
      ],
    ),
  ]);
}
