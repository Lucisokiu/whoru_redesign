import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whoru/src/model/login.dart';
import 'package:whoru/src/utils/url.dart';
import 'package:whoru/src/utils/token.dart';

Future<Login> apiLogin(Map map) async {
  var url = Uri.https(baseUrl, '/api/Log/Login'); // Sửa lỗi dấu nháy đơn ở đây
  print('apiLogin $url');
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(map),
  );
  if (response.statusCode == 200) {
    String token = jsonDecode(response.body)['token'];
    int idUser = jsonDecode(response.body)['userId'];
    setToken(token);
    setIdUser(idUser);
    Map<dynamic, dynamic> jsonData = jsonDecode(response.body);
    jsonData['success'] = true;
    print('apiLogin statuscode 200 $jsonData');
    return Login.fromJson(jsonData);
  } else {
    Map<dynamic, dynamic> jsonData = await jsonDecode(response.body);
    jsonData['success'] = false;
    print('apiLogin without statuscode 200 $jsonData');
    return Login.fromJson(jsonData);
  }
}

void resetPassword(password) async {
  var url = Uri.https('$baseUrl  + /api/Log/ResetPassword');
  String? token = await getToken();
  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: password,
    );

    if (response.statusCode == 200) {
      print("Reset Password Success");
    } else {
      throw Exception('Failed auth');
    }
  } catch (e) {
    throw Exception('Error during API call: $e');
  }
}

Future<void> sendCodeByEmail(idUser) async {
  var url = Uri.https('$baseUrl  + /api/Log/SendCodeByMail');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idUser,
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

Future<void> sendCodeBySMS(idUser) async {
  var url = Uri.https('$baseUrl  + /api/Log/SendCodeBySMS');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idUser,
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

void verifyAccount(code) async {
  var url = Uri.https('$baseUrl  + /api/Log/VerifyAccount');
  String? token = await getToken();
  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: code,
    );

    if (response.statusCode == 200) {
      print("Reset Password Success");
    } else {
      throw Exception('Failed auth');
    }
  } catch (e) {
    throw Exception('Error during API call: $e');
  }
}
