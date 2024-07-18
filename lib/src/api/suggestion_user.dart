import 'dart:convert';
import 'package:whoru/src/models/suggestion.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';
import 'package:http/http.dart' as http;

Future<List<Suggestion>> getListSuggestionsList() async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/GetListSuggestions');
  String? token = await getToken();

  var response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    print('getListSuggestionsList request successful');
    List<dynamic> decodedData = jsonDecode(response.body);
    List<Suggestion> result =
        decodedData.map((data) => Suggestion.fromJson(data)).toList();

    return result;
  } else {
    print(
        'Failed to make getListSuggestionsList request. Status code: ${response.statusCode}');
    return [];
  }
}

Future<void> postListSuggestionsList(List<int> listIdUser) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/GetListSuggestions');
  String? token = await getToken();

  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'listIdUser': listIdUser,
    }),
  );

  if (response.statusCode == 200) {
    print('postListSuggestionsList request successful');
  } else {
    print(
        'Failed to make postListSuggestionsList request. Status code: ${response.statusCode}');
  }
}
