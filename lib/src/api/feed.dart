import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<List<FeedModel>> getAllPost(int page) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/GetAllPost');
    String? token = await getToken();
    print(url);

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
      print('GetAllPost $decodedData');
      List<FeedModel> feedList =
          decodedData.map((data) => FeedModel.fromJson(data)).toList();
      return feedList;
    } else {
      print("fail call api getAllPost with page $page");
      print("fail call api getAllPost with response.statusCode ${response.statusCode}");

      return [];
    }
  } catch (e) {
    print("fail call api getAllPost $e");

    return [];
  }
}

Future<void> delete(idPost) async {
  var url = Uri.https(baseUrl, '/api/v1/Feeds/Delete');
  String? token = await getToken();

  var response = await http.delete(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: idPost.toString(),
  );

  if (response.statusCode == 200) {
    print('DELETE request successful');
  } else {
    print('Failed to make DELETE request. Status code: ${response.statusCode}');
  }
}

Future<void> postApiWithImages({
  List<File>? imageFiles,
  required String content,
  required int status,
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

    request.fields['Status'] = content;
    request.fields['State'] = status.toString();

    request.headers.addAll(headers);
    // Thêm ảnh vào FormData
    if (imageFiles != null) {
      for (var imageFile in imageFiles) {
        var file = await http.MultipartFile.fromPath(
          'Files',
          imageFile.path,
        );
        request.files.add(file);
      }
    }
    var response = await request.send();
    if (response.statusCode == 201) {
      print('Success with status ${response.statusCode}');
    } else {
      print('status code ${response.statusCode}');
    }
  } catch (e) {
    print('Failed with status $e');
  }
}

Future<void> updateApiWithImages({
  required int id,
  required List<File> imageFiles,
  required String content,
  required int status,
}) async {
  try {
    print("imageFiles ${imageFiles.length}");
    var url = Uri.https(baseUrl, '/api/v1/Feeds/UpdateFeed');
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
    request.fields['Id'] = id.toString();
    request.fields['Status'] = content;
    request.fields['State'] = status.toString();

    request.headers.addAll(headers);
    // Thêm ảnh vào FormData
    for (var imageFile in imageFiles) {
      var file = await http.MultipartFile.fromPath(
        'Files',
        imageFile.path,
      );
      request.files.add(file);
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Success with status ${response.statusCode}');
    } else {
      print('Failed with status ${response.statusCode}');
    }
  } catch (e) {
    print('Failed with status $e');
  }
}

Future<List<FeedModel>?> getAllPostById(int id, int page) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/GetAllPostById');
    String? token = await getToken();
    final body = jsonEncode({"id": id, "page": page});
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      List<dynamic> decodedData = jsonDecode(response.body);
      List<FeedModel> feedList =
          decodedData.map((data) => FeedModel.fromJson(data)).toList();

      return feedList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      print("Fail with StatusCode ${response.statusCode}");

      return null;
    }
  } catch (e) {
    print("Fail with StatusCode $e");
  }
  return [];
}

Future<Response> searchPost(String title, int page) async {
  var url = Uri.https(baseUrl, '/api/v1/Feeds/SearchPost');
  String? token = await getToken();
  print(url);
  final body = jsonEncode({"keyword": title, "page": page});

  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    // List<dynamic> decodedData = jsonDecode(response.body);
    // List<FeedModel> feedList =
    //     decodedData.map((data) => FeedModel.fromJson(data)).toList();
    // return feedList;
    return response;
  } else {
    print("fail call api searchPost with title ${response.statusCode}");
    return response;
  }
}

Future<FeedModel?> getPostById(int id) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/GetPostById');
    String? token = await getToken();
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: id,
    );

    if (response.statusCode == 200) {
      FeedModel feed = jsonDecode(response.body);
      return feed;
    } else if (response.statusCode == 404) {
      //push to login screen
      return null;
    } else {
      // orther status
      print("Fail with StatusCode ${response.statusCode}");

      return null;
    }
  } catch (e) {
    print("Fail with StatusCode $e");
  }
  return null;
}

Future<List<FeedModel>?> getAllSavePost(int id, int page) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Feeds/GetAllSavePost');
    String? token = await getToken();
    final body = jsonEncode({"id": id, "page": page});
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      List<dynamic> decodedData = jsonDecode(response.body);
      List<FeedModel> feedList =
          decodedData.map((data) => FeedModel.fromJson(data)).toList();

      return feedList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      print("Fail with StatusCode ${response.statusCode}");

      return null;
    }
  } catch (e) {
    print("Fail with StatusCode $e");
  }
  return [];
}


Future<void> savePost(idPost) async {
  var url = Uri.https(baseUrl, '/api/v1/SavedFeeds/SavePost');
  String? token = await getToken();
  print(url);
  try {
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
      print('savePost request successful');
    } else {
      print(
          'Failed to make savePost request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}