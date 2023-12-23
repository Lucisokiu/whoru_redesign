import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> getAll(idPost) async {
  var url = Uri.https('$baseUrl  + /api/User/GetAll');
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

Future<void> getUserByName(idPost) async {
  var url = Uri.https('$baseUrl  + /api/User/GetUserByName');
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
      print('Follow request successful');
    } else {
      print(
          'Failed to make Follow request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<void> CreateAccount(Map map) async {
  var url = Uri.https('$baseUrl  + /api/v1/Users/Create');
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

Future<void> updateAccount(Map map) async {
  var url = Uri.https('$baseUrl  + /api/User/Update');
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
      print('Follow request successful');
    } else {
      print(
          'Failed to make updateAccount request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}
