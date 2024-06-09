import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setNotif(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  print(value);

  return prefs.setBool('isNotif', value);
}

Future<bool> getNotif() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isNotif') ?? false;
}

Future<void> deleteNotif() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isNotif');
}