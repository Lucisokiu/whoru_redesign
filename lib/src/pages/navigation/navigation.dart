import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/pages/home/page/feed_page.dart';
import 'package:whoru/src/pages/location/location_page.dart';
import 'package:whoru/src/pages/profile/profile_page.dart';
import 'package:whoru/src/pages/search/search_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPage = 0;

  final _screens = [
    const FeedPage(),
    const SearchPage(),
    const LocationPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Container(
          child: _screens[currentPage],
        ),
        bottomNavigationBar: Container(
          // color : Colors.transparent,
          padding: const EdgeInsets.all(12),
          // margin: EdgeInsets.symmetric(horizontal: 24),
          // margin: const EdgeInsets.all(16),
          margin: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          decoration: BoxDecoration(
            // color: Colors.black87.withOpacity(0.8),
            color: Colors.black87.withOpacity(0.8),

            borderRadius: const BorderRadius.all(Radius.circular(24)),
            //       gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Colors.black87, Colors.transparent],
            // ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Căn các widget con theo khoảng cách đều nhau

            children: [
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 0
                    ? PhosphorIcons.fill.house
                    : PhosphorIcons.thin.house),
                color: Colors.white,
                onPressed: () {
                  print("Home");

                  // Switch to the Home page
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 36,
                icon: Icon(currentPage == 1
                    ? PhosphorIcons.fill.magnifyingGlass
                    : PhosphorIcons.thin.magnifyingGlass),
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
                    // ? PhosphorIcons.fill.globeHemisphereWest
                    // : PhosphorIcons.thin.globeHemisphereWest),
                    ? PhosphorIcons.fill.mapPinLine
                    : PhosphorIcons.light.mapPinLine),
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
                    ? PhosphorIcons.fill.userCircle
                    : PhosphorIcons.thin.userCircle),
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
