
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

// import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:whoru/src/page/home/page/feed_page.dart';
import 'package:whoru/src/page/location/location_page.dart';
import 'package:whoru/src/page/navigation/style_nav/helpers/enums.dart';

import 'package:whoru/src/page/navigation/style_nav/model/options.dart';

// import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:whoru/src/page/navigation/style_nav/bottom_bar.dart';
import 'package:whoru/src/page/navigation/style_nav/model/bar_items.dart';
import 'package:whoru/src/page/profile/profile_page.dart';
import 'package:whoru/src/page/search/search_page.dart';

// import 'package:whoru/src/page/navigation/style_nav/model/stylish_bottom_bar.dart';

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
    // bool 
    return Scaffold(
      floatingActionButton:
      Visibility(
      visible: currentPage == 0,
      child : FloatingActionButton( //Floating action button on Scaffold
      onPressed: (){
          //code to execute on button press
      },
      // shape
      child: const Icon(Icons.add),
  ),

      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      extendBody: true,


      bottomNavigationBar:
      ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(70),
        topLeft: Radius.circular(70),
      ),
        child: StylishBottomBar(
          option: AnimatedBarOptions(
            
            padding: const EdgeInsets.only(top: 15.0),
            inkColor: Colors.grey,
            barAnimation: BarAnimation.transform3D,
            inkEffect: true,
            iconStyle: IconStyle.animated,
            opacity: 0.8,
          ),
          items: [
            BottomBarItem(
              icon: const Icon(PhosphorIcons.house_line_fill),
              title: const Text('Home'),
              // backgroundColor: Colors.blue,
              // selectedIcon: const Icon(Icons.read_more),
            ),
            BottomBarItem(
              icon: const Icon(PhosphorIcons.magnifying_glass_light),
              title: const Text('Find'),
              // backgroundColor: Colors.orange,
            ),
            BottomBarItem(
              icon: const Icon(PhosphorIcons.globe_hemisphere_east_fill),
              title: const Text('Location'),
              // backgroundColor: Colors.purple,
            ),
            BottomBarItem(
              icon: const Icon(PhosphorIcons.user_circle_fill),
              title: const Text('User'),
              // backgroundColor: Colors.purple,
            ),
          ],
          fabLocation: StylishBarFabLocation.center,
          hasNotch: true,
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
      ),
      
      body: 
        _screens[currentPage],
    );
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