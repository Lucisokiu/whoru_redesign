import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/model/feed.dart';
import 'package:whoru/src/model/user.dart';

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
            const Tab(
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
              alignment: Alignment.center,
              color: const Color.fromARGB(0, 196, 44, 44),
              child: TabBarView(
                controller: _tabController,
                children: [
                  photoProfile(context),
                  photoProfile(context),
                  photoProfile(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget photoProfile(BuildContext context) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: 1.0,
      mainAxisSpacing: 2.0,
      // childAspectRatio: 1.1,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 1),
        child: yourPicture(context, user.avt),
      );
    },
    itemCount: feedList.length,
  );
}

Widget yourPicture(BuildContext context, urlImage) {
  return Image.network(
    urlImage,
    fit: BoxFit.fill,
    // height: 10.5.h,
  );
}
