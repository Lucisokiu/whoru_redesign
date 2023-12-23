import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> sharePost(idPost) async {
  var url = Uri.https(baseUrl, '/api/v1/Shares/SharePost');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idPost.toString(),
    );

    if (response.statusCode == 200) {
      print('sharePost request successful');
    } else {
      print(
          'Failed to make sharePost request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<void> unSharePost(idPost) async {
  var url = Uri.https('$baseUrl  + /api/Share/unSharePost');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idPost,
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



Future<List<Map<String, dynamic>>> getListShare(idPost) async {
  var url = Uri.https(baseUrl, '/api/v1/Shares/GetAllSharedUser');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idPost.toString(), // Sending the idPost as JSON
    );
    if (response.statusCode == 200) {
      // Parse the response and extract the list of users as a list of maps
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Map<String, dynamic>> listShare =
      List<Map<String, dynamic>>.from(jsonList);
      return listShare;
    } else {
      print('Failed to make Like request. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error during the Like request: $e');
  }
  return [];
}
