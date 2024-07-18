import 'dart:convert';
import 'package:whoru/src/pages/face_detection/DB/face_registration_info.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';
import 'package:http/http.dart' as http;

Future<void> postEmbedding(List<double> embeddeding) async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/PostEmbeddingForUser');
  String? token = await getToken();

  var body = {
    "embedded": embeddeding,
  };
  print('Body $body');
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(body),
  );
  print(response.statusCode);
  if (response.statusCode == 201) {
    print('embeddeding request successful');
  } else {
    print(
        'Failed to make embeddeding request. Status code: ${response.statusCode}');
  }
}

Future<List<FaceRegistrationInfo>> getAllEmbedding() async {
  var url = Uri.https(baseUrl, '/api/v1/UserInfos/GetListEmbedding');
  String? token = await getToken();

  var response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.body);

  List<dynamic> jsonList = json.decode(response.body);
  List<FaceRegistrationInfo> faceRegistrationInfos =
      jsonList.map((json) => FaceRegistrationInfo.fromJson(json)).toList();

  for (var info in faceRegistrationInfos) {
    print('ID from API: ${info.id}');
  }
  if (response.statusCode == 200) {
    print('embeddeding request successful');
    return faceRegistrationInfos;
  } else {
    print(
        'Failed to make embeddeding request. Status code: ${response.statusCode}');
    return [];
  }
}
