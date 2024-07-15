import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setIdUser(int value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setInt('idUser', value);
}

Future<int?> getIdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('idUser');
}

Future<void> deleteIdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('idUser');
}
