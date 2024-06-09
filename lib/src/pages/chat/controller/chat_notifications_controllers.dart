// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class NotificationController {

//   late bool _notificationsEnabled;

//   bool get isEnabled => _notificationsEnabled;

//   NotificationController() {
//     isNotificationsEnabled().then((value) => print("NotificationController is complite"));
//   }

//   Future<void> isNotificationsEnabled() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int endTimeInMillis = prefs.getInt('endTimeInMillis') ?? 0;
//     int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
//     _notificationsEnabled = currentTimeInMillis > endTimeInMillis;
//     if (_notificationsEnabled == false) {
//       int timeLeftInMinutes = endTimeInMillis - currentTimeInMillis;
//       _scheduleNotification(timeLeftInMinutes);
//     }
//   }

//   Future<void> saveSelectedTime(int time) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
//     int endTimeInMillis = currentTimeInMillis + (time * 60000);
//     prefs.setInt('endTimeInMillis', endTimeInMillis);
//     _notificationsEnabled = false;

//     int timeLeftInMinutes = endTimeInMillis - currentTimeInMillis;
//     _scheduleNotification(timeLeftInMinutes);
//   }

//   void toggleNotifications(BuildContext context, Function getUserFunction) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Choose time'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 ListTile(
//                   title: const Text('15'),
//                   onTap: () {
//                     saveSelectedTime(15);
//                     getUserFunction();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 ListTile(
//                   title: const Text('30'),
//                   onTap: () {
//                     saveSelectedTime(30);
//                     getUserFunction();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _scheduleNotification(int time) {
//     Timer(Duration(milliseconds: time), () {
//       _notificationsEnabled = true;
//       SharedPreferences.getInstance().then((prefs) {
//         prefs.remove('endTimeInMillis');
//       });
//     });
//   }
// }
