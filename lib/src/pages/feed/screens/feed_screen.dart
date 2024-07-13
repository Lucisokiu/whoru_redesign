import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/api/suggestion_user.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/models/story_model.dart';
import 'package:whoru/src/models/suggestion.dart';
import 'package:whoru/src/models/user_model.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/feed/widget/feed_card.dart';
import 'package:whoru/src/pages/feed/widget/suggest_card.dart';
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
  List<Suggestion> suggestList = [];
  bool isLoadingStory = true;

  int pageFeed = 0;
  int pageStory = 0;
  void getFeed() async {
    List<FeedModel>? result = await getAllPost(++pageFeed);
    if (mounted) {
      if (result != null) {
        setState(() {
          listFeed.addAll(result);
        });
      }
    }
  }

  void getSuggestionList() async {
    List<Suggestion> result = await getListSuggestionsList();
    if (mounted) {
      setState(() {
        suggestList.addAll(result);
      });
    }
  }

  void getStory() async {
    List<Story> result = await getStoryByUserId(++pageStory);
    print(result);
    if (mounted) {
      setState(() {
        storyList.addAll(result);
        isLoadingStory = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFeed();
    getStory();
    getSuggestionList();
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
                        storywidget(context, storyList, isLoadingStory),
                        SizedBox(height: 0.5.h),
                        suggestList.isEmpty
                            ? Container()
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 22.h,
                                      width: 50.w,
                                      child: ListView.builder(
                                          itemCount: suggestList.length,
                                          itemBuilder: (context, index) {
                                            return SuggestionCard(
                                              id: suggestList[index].id,
                                              name: suggestList[index].name,
                                              avt: suggestList[index].avt,
                                            );
                                          }),
                                    ),

                                  ],
                                ),
                              ),

                        listFeed.isEmpty
                            ? const SizedBox(
                                height: 1000,
                                child: MySkeletonLoadingWidget(),
                              )
                            : CardFeed(
                                feed: listFeed[index],
                              )
                      ],
                    );
                  } else if (index == listFeed.length) {
                    return _buildListFooter();
                  } else {
                    return CardFeed(
                      feed: listFeed[index],
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
