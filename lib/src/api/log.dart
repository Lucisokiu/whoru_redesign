import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/url.dart';
import 'package:whoru/src/utils/token.dart';

Future<http.Response> apiLogin(Map map) async {
  try{
  var url = await Uri.http(baseUrl, '/api/v1/Logs/Login');
  print(url);

  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(map),
  );

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
  }catch (error) {
  print('apiLogin error: $error');
  throw('Error occurred during API call', 500);
}
}

Future<int?> ForgotPassword(email) async {
  var url = Uri.http(baseUrl, '/api/v1/Logs/ForgotPassword');
  String? token = await getToken();
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: jsonEncode(email),
  );

  if (response.statusCode == 200) {
    print("Reset Password Success");
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    String messageValue = jsonData["message"];
    int? numberValue = int.tryParse(messageValue);
    return numberValue;
  }
  print(response.statusCode);

  return null;

}

Future<void> sendCodeByEmail(idUser) async {
  var url = Uri.http(baseUrl,'/api/v1/Logs/SendCodeByMail');

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: idUser.toString(),
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
  var url = Uri.http(baseUrl, '/api/Log/SendCodeBySMS');
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: idUser.toString(),
  );

  if (response.statusCode == 200) {
    print('sendCodeBySMS request successful');
  } else {
    print(
        'sendCodeBySMS to make Follow request. Status code: ${response.statusCode}');
  }
}

Future<http.Response> verifyAccount(int idUser,String code) async {
  var url = Uri.http(baseUrl,'/api/v1/Logs/VerifyAccount');
  Map data = {
    "idUser": idUser,
    "code": code,
  };
  print(jsonEncode(data));
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    body: jsonEncode(data),
  );
  if(response.statusCode == 200) {
    Map<String, dynamic> responseDataMap = jsonDecode(response.body);
    String message = responseDataMap['message'];
    setToken(message);
    return response;
  }
  return response;

}

void ChangePass(String pass) async {
  var url = Uri.http(baseUrl, '/api/v1/Logs/ChangePassword');
  String? token = await getToken();
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: '"$pass"',
  );

  if (response.statusCode == 200) {
    print("Reset Password Success");
  }else{
    print(response.statusCode);
  }
}