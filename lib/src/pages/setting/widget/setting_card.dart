// import 'package:flutter/material.dart';
// import 'package:whoru/src/matherial/matherial_animation.dart';
// import 'package:whoru/src/pages/setting/setting_screen.dart';
// import 'package:whoru/src/utils/color.dart';

// class SettingsCard extends StatelessWidget {
//   final IconData iconData;
//   final String title;
//   final IconData? iconDataTwo;
//   final Color? color;
//   final Color? colorTwo;
//   final bool? twoIcon;
//   const SettingsCard({Key? key, required this.iconData, this.color, this.twoIcon, this.iconDataTwo, this.colorTwo, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Container(
//         decoration: BoxDecoration(
//           color: saveTheme ? decorationCardPostColorWhite : backgroundColor,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MaterialAnimation(
//               duration: const Duration(seconds: 1),
//               name: "flipY",
//               child: Center(
//                 child: twoIcon == true
//                     ? Padding(
//                       padding: const EdgeInsets.all(0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                       Icon(iconData , size: 60 , color: color),
//                       Icon(iconDataTwo , size: 60 , color: colorTwo),
//                   ],
//                 ),
//                     ) : Icon(iconData , size: 80 , color: color),
//               ),
//             ),
//             MaterialAnimation(
//               duration: const Duration(seconds: 1),
//               name: "slideHorizontal",
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Text(title , style: TextStyle(fontSize: 14 , color: backgroundColorWhite)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }