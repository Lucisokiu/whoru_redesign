import 'dart:convert';
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';
import 'package:http/http.dart' as http;

Future<void> getListSuggestionsList(List<int> listUser) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/GetListSuggestions');
  String? token = await getToken();

  var body = {
    "listIdUser": listUser,
  };
  print('Body $body');
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    print('getListSuggestionsList request successful');
  } else {
    print(
        'Failed to make getListSuggestionsList request. Status code: ${response.statusCode}');
  }
}
