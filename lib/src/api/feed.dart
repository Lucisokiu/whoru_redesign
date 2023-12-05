import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whoru/src/model/feed.dart';
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<List<FeedModel>?> getAllPost() async {
  try {
    var url = Uri.https(baseUrl, '/api/Feed/GetAllPost');
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
      // Decode JSON and map it to List<FeedModel>
      List<dynamic> decodedData = jsonDecode(response.body);
      List<FeedModel> feedList =
          decodedData.map((data) => FeedModel.fromJson(data)).toList();
      return feedList;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<void> Delete(idPost) async {
  var url = Uri.https(baseUrl, '/api/Feed/Delete');
  String? token = await getToken();

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
    print('POST request successful');
  } else {
    print('Failed to make POST request. Status code: ${response.statusCode}');
  }
}
