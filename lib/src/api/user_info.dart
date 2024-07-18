import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/login/login_screen.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';

import '../models/user_model.dart';
import '../pages/splash/splash.dart';
import '../utils/shared_pref/iduser.dart';

Future<bool> createInfoUser(Map map) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/Create');
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
  print(jsonEncode(map));
  if (response.statusCode == 201) {
    print('createInfoUser request successful');
    setIdUser(int.parse(response.body));
    return true;
  } else {
    print(
        'Failed to make createInfoUser request. Status code: ${response.statusCode}');
    return false;
  }
}

Future<void> updateInfoUser(Map map) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/UpdateInfo');
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
      print('updateInfoUser request successful');
    } else {
      print(
          'Failed to make updateInfoUser request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<http.Response> getInfoUserByName(String name, int page) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/SearchUser');
  String? token = await getToken();
  final body = jsonEncode({"keyword": name, "page": page});
  print("AAAAAAAAAAAAAAAAAAAA");
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: body,
  );
  return response;
}

Future<UserModel?> getInfoUserById(int id) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/GetInfoById');
  String? token = await getToken();
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: id.toString(),
  );

  if (response.statusCode == 200) {
    Map<dynamic, dynamic> jsonData = jsonDecode(response.body);
    return UserModel.fromJson(jsonData);
  } else {
    print(
        'Failed to make getInfoUserById request. Status code: ${response.statusCode}');
    return null;
  }
}

Future<void> updateAvatar({
  required File? imageFile,
}) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/UserInfos/UpdateAvatar');
    String? token = await getToken();
    Map<String, String> headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    };
    // Tạo request
    var request = http.MultipartRequest(
      'PUT',
      url,
    );

    // Thêm các trường dữ liệu khác vào FormData nếu cần
    request.headers.addAll(headers);
    // Thêm ảnh vào FormData
    if (imageFile != null) {
      var file = await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      );
      request.files.add(file);
    }

    // Gửi request và nhận response
    var response = await request.send();

    // Kiểm tra mã trạng thái của response
    if (response.statusCode == 200) {
      print('Success');
    } else {
      print('Failed with status ${response.statusCode}');
    }
  } catch (e) {
    print('Failed with status $e');
  }
}

Future<void> updateBackground({
  required File? imageFile,
}) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/UserInfos/UpdateBackground');
    String? token = await getToken();
    Map<String, String> headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    };
    // Tạo request
    var request = http.MultipartRequest(
      'PUT',
      url,
    );

    // Thêm các trường dữ liệu khác vào FormData nếu cần
    request.headers.addAll(headers);
    // Thêm ảnh vào FormData
    if (imageFile != null) {
      var file = await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      );
      request.files.add(file);
    }

    // Gửi request và nhận response
    var response = await request.send();

    // Kiểm tra mã trạng thái của response
    if (response.statusCode.isEven) {
      print('Success');
    } else {
      print('Failed with status ${response.statusCode}');
    }
  } catch (e) {
    print('Failed with status $e');
  }
}
