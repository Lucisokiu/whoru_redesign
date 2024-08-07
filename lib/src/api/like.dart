import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> likePost(idPost) async {
  var url = Uri.https(baseUrl, '/api/v1/Likes/LikePost');
  String? token = await getToken();
  print(url);
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
    print('Like request successful');
  } else {
    print('Failed to make Like request. Status code: ${response.statusCode}');
  }
}

Future<void> unLikePost(idPost) async {
  var url = Uri.https(baseUrl, '/api/v1/Likes/unLikePost');
  String? token = await getToken();
  print(url);
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
    print('unLikePost request successful');
  } else {
    print('Failed to make unLikePost request. Status code: ${response.statusCode}');
  }
}


Future<List<Map<String, dynamic>>> getListLike(idPost,int page) async {
  var url = Uri.https(baseUrl, '/api/v1/Likes/GetAllLikedUser');
  String? token = await getToken();
  Map<String, dynamic> map = {
    "idPost": idPost,
    "page": page,
  };
  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: jsonEncode(map), // Sending the idPost as JSON
    );
    if (response.statusCode == 200) {
      // Parse the response and extract the list of users as a list of maps
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Map<String, dynamic>> likeList =
          List<Map<String, dynamic>>.from(jsonList);
      return likeList;
    } else {
      print('Failed to make Like request. Status code: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error during the Like request: $e');
  }
  return [];
}
