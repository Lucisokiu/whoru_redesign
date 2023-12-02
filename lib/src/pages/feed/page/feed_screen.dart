import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/feed.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/feed/widget/feed_cart.dart';
import 'package:whoru/src/pages/feed/widget/story_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(),
          Expanded(
            child: Builder(
              builder: (context) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: feedList.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          storywidget(context),
                          SizedBox(height: 2.h),
                        ],
                      );
                    } else {
                      return CardFeed(feedModel: feedList[index - 1]);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
