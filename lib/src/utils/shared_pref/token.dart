import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', value);
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<void> deleteToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

Future<void> deleteIdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('idUser');
}
