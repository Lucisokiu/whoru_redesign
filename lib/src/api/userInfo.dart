import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whoru/src/model/user.dart';
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> createInfoUser(Map map) async {
  var url = Uri.https(baseUrl, '/api/UserInfo/Create');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: jsonEncode(map),
    );

    if (response.statusCode == 200) {
      print('createInfoUser request successful');
    } else {
      print(
          'Failed to make createInfoUser request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<void> updateInfoUser(Map map) async {
  var url = Uri.https('$baseUrl/api/UserInfo/UpdateInfo');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: jsonEncode(map),
    );

    if (response.statusCode == 200) {
      print('Follow request successful');
    } else {
      print(
          'Failed to make Follow request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<void> getInfoUserByName(String name) async {
  var url = Uri.https('$baseUrl  + /api/UserInfo/GetInfoByName');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: name,
    );

    if (response.statusCode == 200) {
      print('Follow request successful');
    } else {
      print(
          'Failed to make Follow request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<UserModel?> getInfoUserById(int Id) async {
  var url = Uri.https(baseUrl, 'api/UserInfo/GetInfoById');
  String? token = await getToken();
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: Id.toString(),
  );

  if (response.statusCode == 200) {
    Map<dynamic, dynamic> jsonData = jsonDecode(response.body);
    return UserModel.fromJson(jsonData);
  } else {
    print('Failed to make Follow request. Status code: ${response.statusCode}');
    return null;
  }
}
