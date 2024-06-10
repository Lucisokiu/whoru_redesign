import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../models/story_model.dart';

Widget storywidget(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      height: 15.h,
      decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(24)),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(2.0, 2.0),
            ),
          ]),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            addStory(context),
            for (int i = 0; i < storyList.length; i++)
              yourStory(context, storyList[i].imageUrl, storyList[i].userName),
            SizedBox(
              width: 2.w,
            )
          ],
        ),
      ),
    ),
  );
}

Widget yourStory(BuildContext context, urlImage, userName) {
  return Padding(
    padding: const EdgeInsets.only(left: 24),
    child: Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFBAA47),
                  Color(0xffD91A46),
                  Color(0xffA60F93),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.centerRight,
              ),
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.network(
              urlImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          userName,
          style: const TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

Widget addStory(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 24),
    child: Column(
      children: [
        SizedBox(
            width: 70,
            height: 70,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Icon(
                PhosphorIconsFill.plusCircle,
                color: Theme.of(context).iconTheme.color
              ),
            )),
        const SizedBox(
          height: 6,
        ),
        const Text(
          "Add story",
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}
