// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:whoru/src/pages/setting/setting_screen.dart';
// import 'color.dart';




// class MaterialTheme extends StatefulWidget {
//   const MaterialTheme({Key? key}) : super(key: key);

//   @override
//   State<MaterialTheme> createState() => _MaterialThemeState();
// }

// class _MaterialThemeState extends State<MaterialTheme> {


//   _saveTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('saveTheme', saveTheme);
//   }
  
//   loadTheme() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       saveTheme = prefs.getBool('saveTheme')!;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadTheme();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: saveTheme ? backgroundColor : backgroundColorWhite,
//       body: Center(
//         child: Switch(
//           value: saveTheme,
//           onChanged: (val) {
//             setState(() {
//               saveTheme = val;
//               _saveTheme();
//             });
//           },
//           activeColor: Colors.deepPurpleAccent,
//         ),
//       ),
//       // floatingActionButton: const MaterialFloating(
//       //   push: true,
//       //   page: MaterialHome(),
//       // ),
//     );
//   }
// }