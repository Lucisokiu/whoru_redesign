import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/models/story_model.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/feed/widget/feed_card.dart';
import 'package:whoru/src/pages/story/widget/story_widget.dart';
import 'package:whoru/src/utils/shared_pref/iduser.dart';

import '../../../api/story.dart';
import '../widget/skeleton_loading.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  List<FeedModel> listFeed = [];
  List<Story> storyList = [];

  int? currentUser;
  int pagefeed = 0;
  int pageStory = 0;

  void getFeed() async {
    print("get new feed");
    List<FeedModel>? result = await getAllPost(++pagefeed);
    if (mounted) {
      if (result != null) {
        setState(() {
          listFeed.addAll(result);
        });
      }
    }
  }

  void getCurentUser() async {
    int? id = await getIdUser();
    if (mounted) {
      setState(() {
        currentUser = id;
      });
    }
  }

  void getStory() async {
    List<Story> result = await getStoryByUserId(++pageStory);
    if (mounted) {
      setState(() {
        storyList.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurentUser();
    getFeed();
    getStory();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent * 0.8) {
        getFeed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
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
                        storyList.isEmpty
                            ? const SizedBox(
                                height: 1000,
                                child: MySkeletonLoadingWidget(),
                              )
                            : storywidget(context,storyList),
                        SizedBox(height: 2.h),
                        listFeed.isEmpty
                            ? const SizedBox(
                                height: 1000,
                                child: MySkeletonLoadingWidget(),
                              )
                            : CardFeed(
                                feed: listFeed[index],
                                currentUser: currentUser!,
                              )
                      ],
                    );
                  } else if (index == listFeed.length) {
                    return _buildListFooter();
                  } else {
                    return CardFeed(
                      feed: listFeed[index],
                      currentUser: currentUser!,
                    );
                  }
                },
                childCount: listFeed.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListFooter() {
    getFeed();
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
