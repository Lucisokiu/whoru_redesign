import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/model/User.dart';
import 'package:whoru/src/pages/login/LoginSreen.dart';
import 'package:whoru/src/pages/profile/widget/UpdateProfile.dart';
import 'package:whoru/src/pages/profile/widget/info.dart';
import 'package:whoru/src/pages/profile/widget/tabbar_profile.dart';
import 'package:whoru/src/utils/get_theme.dart';
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

  fetchData() async {
    widget.idUser ??= await getIdUser();
    if (mounted) {
      if (widget.idUser == null) {
        widget.idUser = await getIdUser();
      }
      user = await getInfoUserById(widget.idUser!);
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
                    title: Text(user?.fullName ?? 'Loading...'),
                  ),
                  ListTile(
                    title: Text('Update Avatar'),
                    onTap: () {
                      customUpdateProfileDialog(context, 'avatar');
                    },
                  ),
                  ListTile(
                    title: Text('Update background'),
                    onTap: () {
                      customUpdateProfileDialog(context, 'background');
                    },
                  ),
                  ListTile(
                    title: Text('Update Info'),
                    onTap: () {
                      customUpdateProfileDialog(context, 'info');
                    },
                  ),
                ],
              ),
            )
          : null,
      body:
          // SafeArea(
          //   bottom: false,
          //   child:
          Stack(
        children: [
          (user != null)
              ? Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 40.h,
                            child: ClipRRect(
                              child: Image.network(
                                user!.background,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: EdgeInsets.only(top: screenHeight * 0.3),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(40), // Bán kính góc trên
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              info(context, user!),
                              // const TabBarProfile(),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : MySkeletonLoadingWidget(),
        ],
        // ),
      ),
    );
  }
}
