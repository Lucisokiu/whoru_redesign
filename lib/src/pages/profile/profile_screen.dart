import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/pages/feed/widget/feed_card.dart';
import 'package:whoru/src/pages/profile/widget/update_profile.dart';
import 'package:whoru/src/pages/profile/widget/info.dart';
import 'package:whoru/src/utils/token.dart';

import '../../models/user_model.dart';
import '../feed/widget/skeleton_loading.dart';
import 'widget/tabbar_profile.dart';

class ProfilePage extends StatefulWidget {
  final int? idUser;
  final bool isMy;

  const ProfilePage({super.key, this.idUser, required this.isMy});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  UserModel? user;
  List<FeedModel>? allPost;
  late TabController _tabController;

  fetchData() async {
    int? idUser = widget.idUser;
    idUser ??= await getIdUser();
    print(idUser);
    user = await getInfoUserById(idUser!);
    allPost = await getAllPostById(idUser);
    if (mounted) {
      setState(() {
        print(allPost);
      });
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: (widget.isMy)
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(user?.fullName ?? 'Loading...',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  ListTile(
                    title: Text('Update Avatar',
                        style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () {
                      customUpdateProfileDialog(context, 'avatar');
                    },
                  ),
                  ListTile(
                    title: Text('Update background',
                        style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () {
                      customUpdateProfileDialog(context, 'background');
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Update Info',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () {
                      customUpdateProfileDialog(context, 'info');
                    },
                  ),
                  ListTile(
                    title: Text('Change Password',
                        style: Theme.of(context).textTheme.bodyMedium),
                    onTap: () {
                      customUpdateProfileDialog(context, 'changePass');
                    },
                  ),
                ],
              ),
            )
          : null,
      body: (user != null)
          ? SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 60.h,
                      pinned: true,
                      floating: true,
                      centerTitle: true,
                      title: Text(user?.fullName ?? 'Loading...'),
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            Container(
                              color: Theme.of(context).cardColor,
                              height: 40.h,
                              child: ClipRRect(
                                child: Image.network(
                                  user!.background,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Positioned(
                              top: screenHeight * 0.3,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  // color: Colors.white,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(40),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  info(context, user!, widget.isMy),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          controller: _tabController,
                          indicatorColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          tabs: [
                            const Tab(
                              icon: Icon(Icons.view_headline_sharp),
                            ),
                            Tab(
                              icon: Icon(PhosphorIcons.addressBook()),
                            ),
                            Tab(
                              icon: Icon(PhosphorIcons.addressBook()),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      floating: false,
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    // Nội dung của tab thứ nhất
                    photoProfile(context, allPost),
                    // Nội dung của tab thứ hai
                    Text("view 2"),
                    // Nội dung của tab thứ ba
                    Text("view 3"),
                  ],
                ),
              ),
            )
          : const MySkeletonLoadingWidget(),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
