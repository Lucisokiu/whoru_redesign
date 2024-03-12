import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/model/Feed.dart';
import 'package:whoru/src/model/Login.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/feed/widget/FeedCart.dart';
import 'package:whoru/src/pages/feed/widget/skeleton_loading.dart';
import 'package:whoru/src/pages/story/StoryWidget.dart';
import 'package:whoru/src/pages/login/LoginSreen.dart';
import 'package:whoru/src/utils/token.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<FeedModel> listFeed = [];
  int? CurrentUser;
  void getFeed() async {
    List<FeedModel>? result = await getAllPost();
    if (mounted) {
      if (result != null) {
        setState(() {
          listFeed = result;
        });
      } else {
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const LoginScreen(),
        //   ),
        //   (route) => false,
        // );
      }
    }
  }

  void getCurentUser() async {
    int? id = await getIdUser();
    if (mounted) {
      setState(() {
        CurrentUser = id;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurentUser();
    getFeed();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 10.h,
              flexibleSpace: const MyAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        storywidget(context),
                        SizedBox(height: 2.h),
                        CardFeed(
                          feed: listFeed[index],
                          CurrentUser: CurrentUser!,
                        ),
                      ],
                    );
                  } else {
                    return CardFeed(
                      feed: listFeed[index],
                      CurrentUser: CurrentUser!,
                    );
                  }
                },
                childCount: listFeed.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
