import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/model/feed.dart';
import 'package:whoru/src/model/login.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/feed/widget/feed_cart.dart';
import 'package:whoru/src/pages/feed/widget/skeleton_loading.dart';
import 'package:whoru/src/pages/feed/widget/story_widget.dart';
import 'package:whoru/src/pages/login/login_screen.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<FeedModel> listFeed = [];
  void getFeed() async {
    List<FeedModel>? result = await getAllPost();
    if (mounted) {
      if (result != null) {
        setState(() {
          listFeed = result;
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MyAppBar(),
          (listFeed.isNotEmpty)
              ? Expanded(
                  child: Builder(
                    builder: (context) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: listFeed.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                storywidget(context),
                                SizedBox(height: 2.h),
                                CardFeed(feed: listFeed[index]),
                              ],
                            );
                          } else {
                            return CardFeed(feed: listFeed[index]);
                          }
                        },
                      );
                    },
                  ),
                )
              : Expanded(child: MySkeletonLoadingWidget()),
        ],
      ),
    );
  }
}
