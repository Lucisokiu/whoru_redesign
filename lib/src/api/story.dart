import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:whoru/src/models/story_model.dart';
import '../utils/shared_pref/token.dart';
import '../utils/url.dart';

Future<void> postStory({
  required File imageFile,
}) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Storys/Create');
    String? token = await getToken();
    Map<String, String> headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    };
    // Tạo request
    var request = http.MultipartRequest(
      'POST',
      url,
    );

    request.headers.addAll(headers);
    // Thêm ảnh vào FormData
    var file = await http.MultipartFile.fromPath(
      'File',
      imageFile.path,
    );
    request.files.add(file);
    var response = await request.send();
    if (response.statusCode == 201) {
      print('Success with status ${response.statusCode}');
    } else {
      print('Failed with status ${response.statusCode}');
    }
  } catch (e) {
    print('Failed with status $e');
  }
}

Future<List<Story>> getStoryByUserId(int page) async {
    try {
    var url = Uri.https(baseUrl, '/api/v1/Storys/GetStoryByUserId');
    String? token = await getToken();
    print(url);
    print("Page $page");

    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: page.toString(),
    );

    if (response.statusCode == 200) {
      List<dynamic> decodedData = jsonDecode(response.body);
      List<Story> storyList =
          decodedData.map((data) => Story.fromJson(data)).toList();
      return storyList;
    } else {
      print("fail call api getStory with page $page");
      return [];
    }
  } catch (e) {
    print("fail call api getStory $e");

    return [];
  }
}
