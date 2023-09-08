import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/model/feed.dart';

class TabBarProfile extends StatefulWidget {
  const TabBarProfile({super.key});

  @override
  State<TabBarProfile> createState() => _TabBarProfileState();
}

class _TabBarProfileState extends State<TabBarProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(controller: _tabController, tabs: [
            Tab(
              icon: Icon(Icons.view_headline_sharp),
            ),
            Tab(
              icon: Icon(PhosphorIcons.thin.thumbsUp),
            ),
            Tab(
              icon: Icon(PhosphorIcons.thin.fileArrowDown),
            ),
          ]),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: TabBarView(
                controller: _tabController,
                children: [
                  photo_profile(context),
                  photo_profile(context),
                  photo_profile(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget photo_profile(BuildContext context) {
  return ListView(
    children: [
      Wrap(
        children: [
          for (int i = 0; i < feedList.length + 50; i++)
            Padding(
              padding: const EdgeInsets.only(left: 1),
              child: yourPicture(context, feedList[0].imageUrls[0]),
            ),
        ],
      ),
    ],
  );
}

Column yourPicture(BuildContext context, urlImage) {
  return Column(
    children: [
      Image.network(
        urlImage,
        fit: BoxFit.fill,
        height: 10.5.h,
      ),
    ],
  );
}
