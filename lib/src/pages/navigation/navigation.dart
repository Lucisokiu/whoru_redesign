import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/pages/feed/screens/feed_screen.dart';
import 'package:whoru/src/pages/location/location_screen.dart';
import 'package:whoru/src/pages/notification/screen/NotificationScreen.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:whoru/src/pages/search/page/search_page.dart';
import 'package:whoru/src/pages/user/user.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;

  final _screens = [
    const FeedPage(),
    const NotificationScreen(),
    const LocationPage(),
    const UserPage(),
  ];

  @override
  void initState() {
    super.initState();
    // currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: _screens[currentPage],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            color: Colors.black87.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 0
                    ? PhosphorIconsFill.house
                    : PhosphorIconsThin.house),
                color: Colors.white,
                onPressed: () {
                  print("Home");
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 1
                    ? PhosphorIconsFill.bellSimpleRinging
                    : PhosphorIconsThin.bellSimpleRinging),
                color: Colors.white,
                onPressed: () {
                  print("Chat");
                  setState(() {
                    currentPage = 1;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 2
                    ? PhosphorIconsFill.mapPinLine
                    : PhosphorIconsLight.mapPinLine),
                color: Colors.white,
                onPressed: () {
                  print("Location");
                  setState(() {
                    currentPage = 2;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 3
                    ? PhosphorIconsFill.userCircle
                    : PhosphorIconsThin.userCircle),
                color: Colors.white,
                onPressed: () {
                  print("Profile");
                  setState(() {
                    currentPage = 3;
                  });
                },
              ),
            ],
          ),
        ));
  }
}

// custom
//       bottomNavigationBar: StylishBottomBar(
//         // backgroundColor: Colors.lightBlue,
// //  option: AnimatedBarOptions(
// //    iconSize: 32,
// //    barAnimation: BarAnimation.liquid,
// //    iconStyle: IconStyle.animated,
// //    opacity: 0.3,
// //  ),
//         option: AnimatedBarOptions(

//           padding: const EdgeInsets.only(top: 15.0),
//           inkColor: Colors.grey,
//           barAnimation: BarAnimation.transform3D,
//           inkEffect: true,
//           iconStyle: IconStyle.animated,
//           opacity: 0.8,
//         ),
//         items: [
//           BottomBarItem(
//             icon: const Icon(PhosphorIcons.house_line_fill),
//             title: const Text('Home'),
//             // backgroundColor: Colors.blue,
//             // selectedIcon: const Icon(Icons.read_more),
//           ),
//           BottomBarItem(
//             icon: const Icon(PhosphorIcons.magnifying_glass_light),
//             title: const Text('Find'),
//             // backgroundColor: Colors.orange,
//           ),
//           BottomBarItem(
//             icon: const Icon(PhosphorIcons.globe_hemisphere_east_fill),
//             title: const Text('Location'),
//             // backgroundColor: Colors.purple,
//           ),
//           BottomBarItem(
//             icon: const Icon(PhosphorIcons.user_circle_fill),
//             title: const Text('User'),
//             // backgroundColor: Colors.purple,
//           ),
//         ],
//         // borderRadius : BorderRadius.circular(50) ,
//         // barStyle : BubbleBarStyle,
//         fabLocation: StylishBarFabLocation.center,
//         hasNotch: true,
//         currentIndex: currentPage,
//         onTap: (index) {
//           setState(() {
//             currentPage = index;
//             // index.jumpToPage(index);
//           });
//         },
//       ),
//       body: Container(
//         child: _screens[currentPage],
//       ),
//         // _screens[currentPage],
