import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/feed.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/model/Feed.dart';
import 'package:whoru/src/model/User.dart';
import 'package:whoru/src/pages/feed/widget/FeedCart.dart';
import 'package:whoru/src/pages/profile/widget/UpdateProfile.dart';
import 'package:whoru/src/pages/profile/widget/info.dart';
import 'package:whoru/src/utils/token.dart';

import '../feed/widget/skeleton_loading.dart';

class ProfilePage extends StatefulWidget {
  int? idUser;
  bool isMy;

  ProfilePage({super.key, this.idUser, required this.isMy});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  List<FeedModel>? allPost;

  fetchData() async {
    widget.idUser ??= await getIdUser();
    print(widget.idUser);
      user = await getInfoUserById(widget.idUser!);
      allPost = await getAllPostById(widget.idUser!);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.fullName ?? 'Loading...'),
        leading: IconButton(
          icon: Icon(Icons
              .arrow_back_ios_new_rounded), // Replace with your default icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      endDrawer: (widget.isMy)
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
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
              child: SingleChildScrollView(
                child: Column(
                children: [
                  Stack(
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
                            color: Theme.of(context).scaffoldBackgroundColor,
                            // color: Colors.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                      // info(context, user!, widget.isMy),

                      Container(
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            info(context, user!, widget.isMy),
                            // info(context, user!, widget.isMy),
                          ],
                        ),
                      )
                    ],
                  ),
                  for (final feed in allPost!)
                    CardFeed(feed: feed, CurrentUser: user!.id),
                ],
            ),
              ))
          : MySkeletonLoadingWidget(),
    );
  }
}
