import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveNote(text) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('note', text);
}

Future<String> getNote() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('note') ?? '';
}

Future<void> deleteNote() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('note');
}
