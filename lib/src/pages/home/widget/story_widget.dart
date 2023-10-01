import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/story.dart';



Widget storywidget(BuildContext context) {
    // List<Story> story_data = storyList;
    return Container(
      height: 15.h,
              decoration: BoxDecoration(
          color: Colors.white,  
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2.0, 2.0),
            ),
            // BoxShadow(
            //   color: Colors.black38,
            //   spreadRadius: 1,
            //   blurRadius: 5,
            //   offset: Offset(-1.0, -1.0),
            // ),
        ]
        ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0 ; i < storyList.length ; i++)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: yourStory(context,storyList[i].imageUrl,storyList[i].userName),
              ),
          ],
        ),
      ),
    );
  }

Column yourStory(BuildContext context, urlImage, userName) {
    return Column(
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
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
      ],
    );
  }


