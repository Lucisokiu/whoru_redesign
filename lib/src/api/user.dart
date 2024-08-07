import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> getAll() async {
  var url = Uri.https(baseUrl,'/api/v1/Users/GetAll');
  String? token = await getToken();

  try {
    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('getAll request successful');
    } else {
      print(
          'Failed to make getAll request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<http.Response> createAccount(Map map) async {
  var url = Uri.https(baseUrl, '/api/v1/Users/Create');
  String? token = await getToken();

    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: jsonEncode(map),
    );
      return response;

}

Future<void> updateAccount(Map map) async {
  var url = Uri.https(baseUrl, '/api/v1/Users/Update');
  String? token = await getToken();

  try {
    var response = await http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: jsonEncode(map),
    );

    if (response.statusCode == 200) {
      print('updateAccount request successful');
    } else {
      print(
          'Failed to make updateAccount request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}
