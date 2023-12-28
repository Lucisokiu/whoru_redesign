import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> followUser(idUser) async {
  var url = Uri.http(baseUrl,'/api/v1/Follows/FollowUser');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idUser.toString(),
    );

    if (response.statusCode == 200) {
      print('Follow request successful');
    } else {
      print(
          'Failed to make followUser request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<void> unFollowUser(idUser) async {
  var url = Uri.http(baseUrl, '/api/v1/Follows/UnFollowUser');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idUser.toString(),
    );

    if (response.statusCode == 200) {
      print('unFollowUser request successful');
    } else {
      print(
          'Failed to make unFollowUser request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<List<Map<String, dynamic>>> getAllFollower() async {
  var url = Uri.http(baseUrl, '/api/v1/Follows/GetAllFollower');
  String? token = await getToken();
  var response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(jsonList);
    return list;
  } else {
    print('Failed to make getAllFollower request. Status code: ${response.statusCode}');
    return [];
  }
}

Future<List<Map<String, dynamic>>> getAllFollowing() async {
  var url = Uri.http(baseUrl, '/api/v1/Follows/GetAllFollowing');
  String? token = await getToken();

  var response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(jsonList);
    return list;
  } else {
    print('Failed to make getAllFollowing request. Status code: ${response.statusCode}');
    return [];
  }
}
