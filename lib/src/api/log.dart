import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/url.dart';
import 'package:whoru/src/utils/token.dart';

Future<http.Response> apiLogin(Map map) async {
  var url = Uri.https(baseUrl, '/api/v1/Logs/Login');

  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(map),
  );
  print("response.statusCode ${response}");

  print("response.statusCode ${response.statusCode}");
  if (response.statusCode == 200) {
    String token = jsonDecode(response.body)['token'];
    int idUser = jsonDecode(response.body)['infoId'];
    setToken(token);
    setIdUser(idUser);
    return response;
  } else {
    print('apiLogin statuscode without 200 ${response.body}');
    return response;
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
          'Failed to make sendCodeByEmail request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}

Future<void> sendCodeBySMS(idUser) async {
  var url = Uri.https(baseUrl, '/api/Log/SendCodeBySMS');
  String? token = await getToken();
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
    print('sendCodeBySMS request successful');
  } else {
    print(
        'sendCodeBySMS to make Follow request. Status code: ${response.statusCode}');
  }
}

Future<http.Response> verifyAccount(code) async {
  var url = Uri.https('$baseUrl  + /api/Log/VerifyAccount');
  String? token = await getToken();
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: code,
  );

  return response;
}
