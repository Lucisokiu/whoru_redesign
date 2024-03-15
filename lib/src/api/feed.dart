import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:whoru/src/model/FeedModel.dart';
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<List<FeedModel>?> getAllPost() async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/GetAllPost');
    String? token = await getToken();
    print(url);
    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> decodedData = jsonDecode(response.body);
      List<FeedModel> feedList =
          decodedData.map((data) => FeedModel.fromJson(data)).toList();
      return feedList;
    } else {
      print("fail call api getAllPost");
      return null;
    }
  } catch (e) {
    print("fail call api getAllPost $e");

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
    body: idPost.toString(),
  );

  if (response.statusCode == 200) {
    print('POST request successful');
  } else {
    print('Failed to make POST request. Status code: ${response.statusCode}');
  }
}

Future<void> postApiWithImages({
  List<File>? imageFiles,
  required String content,
}) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/Post');
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

    // Thêm các trường dữ liệu khác vào FormData nếu cần
    request.fields['Status'] = content;
    request.headers.addAll(headers);
    // Thêm ảnh vào FormData
    if (imageFiles != null) {
      for (var imageFile in imageFiles) {
        var file = await http.MultipartFile.fromPath(
          'Files', // Thay thế 'image' bằng tên trường chứa ảnh trên API của bạn
          imageFile.path,
        );
        request.files.add(file);
      }
    }

    // Gửi request và nhận response
    var response = await request.send();

    // Kiểm tra mã trạng thái của response
    if (response.statusCode == 201) {
      print('Success with status ${response.statusCode}');
    } else {
      print('Failed with status ${response.statusCode}');
    }
  } catch (e) {
    print('Failed with status $e');
  }
}

Future<List<FeedModel>?> getAllPostById(int id) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/GetAllPostByUserId');
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
      List<dynamic> decodedData = jsonDecode(response.body);
      List<FeedModel> feedList =
          decodedData.map((data) => FeedModel.fromJson(data)).toList();

      return feedList;
    } else if (response.statusCode == 404) {
      // Return an empty list if the status code is 404
      return [];
    } else {
      print("Fail with StatusCode ${response.statusCode}");

      return null;
    }
  } catch (e) {
    print("Fail with StatusCode ${e}");
  }
  return [];
}
