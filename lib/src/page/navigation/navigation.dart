import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/page/home/page/post_page.dart';
import 'package:get/get.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}




class _NavigationState extends State<Navigation> {
  int currentPage  = 0;

  final _screens = [
    const PostPage(),
    const PostPage(),
    const PostPage(),
    const PostPage(),
    const PostPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation : .0,
        child: Container(
          height: 52.sp,
          padding: EdgeInsets.symmetric(horizontal: 6.5.sp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).dividerColor,
                width: .2,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildItemBottomBar(
                PhosphorIcons.house,
                PhosphorIcons.house_fill,
                0,
                'Home',
              ),
              _buildItemBottomBar(
                PhosphorIcons.magnifying_glass,
                PhosphorIcons.magnifying_glass_bold,
                1,
                'Search',
              ),
              _buildItemBottomBar(
                PhosphorIcons.chats_teardrop,
                PhosphorIcons.chats_teardrop_fill,
                2,
                'Message',
              ),
              _buildItemBottomBar(
                PhosphorIcons.intersect,
                PhosphorIcons.intersect_fill,
                3,
                'Discover',
              ),
              // _buildItemBottomAccount(
              //   'https://avatars.githubusercontent.com/u/60530946?v=4',
              //   4,
              // ),
            ],
          ),
        ),
      )
    );
  }


  
  Widget _buildItemBottomBar(inActiveIcon, activeIcon, index, title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentPage = index;
          });
          if (index == 0) {
            // showIncommingCallBottomSheet();
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                child: Icon(
                  index == currentPage ? activeIcon : inActiveIcon,
                  size: 21.5.sp,
                  color: index == currentPage
                      ? null
                      : Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 2.5.sp),
              Container(
                height: 4.sp,
                width: 4.sp,
                decoration: BoxDecoration(
                  color: index == 2 ? null : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
