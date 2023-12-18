import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> followUser(idUser) async {
  var url = Uri.https('$baseUrl  + /api/v1/UserInfos/UpdateInfo');
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

Future<void> unFollowUser(idUser) async {
  var url = Uri.https(baseUrl, '/api/v1/Follows/UnFollowUser');
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

Future<void> getAllFollower() async {
  var url = Uri.https(baseUrl,'/api/v1/Follows/GetAllFollower');
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

Future<void> getAllFollowing() async {
  var url = Uri.https(baseUrl,'/api/v1/Follows/GetAllFollowing');
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
