import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/feed/widget/feed_card.dart';
import 'package:whoru/src/pages/story/story_widget.dart';
import 'package:whoru/src/utils/token.dart';

import '../widget/skeleton_loading.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<FeedModel> listFeed = [];
  int? CurrentUser;

  void getFeed() async {
    List<FeedModel>? result = await getAllPost();
    if (mounted) {
      if (result != null) {
        setState(() {
          // listFeed = result;
          listFeed.addAll(result); // Thêm dữ liệu mới vào cuối danh sách
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

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          0.8 * _scrollController.position.maxScrollExtent) {
        getFeed();
      }
    });
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
                  if (index == listFeed.length) {
                    return _buildListFooter();
                  }
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

  Widget _buildListFooter() {
    print("_buildListFooter");
    if (!_isLoading) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: CircularProgressIndicator(), // Hiển thị chỉ báo khi đang tải
        ),
      );
    }
  }
}
