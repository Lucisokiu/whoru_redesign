import 'dart:convert';
import 'package:whoru/src/models/comment_model.dart';
import 'package:whoru/src/utils/shared_pref/token.dart';
import 'package:whoru/src/utils/url.dart';
import 'package:http/http.dart' as http;

Future<List<CommentModel>?> getCommentByIdFeed(int idFeed, int page) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Comments/GetAllCommentByFeedId');
    print(url);
    String? token = await getToken();
    final body = jsonEncode({"idPost": idFeed, "page": page});

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
      // Decode JSON and map it to List<FeedModel>
      List<dynamic> decodedData = jsonDecode(response.body);
      List<CommentModel> commentList =
          decodedData.map((data) => CommentModel.fromJson(data)).toList();
      print("OK");
      return commentList;
    } else {
      print("false to call API: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("false to call API: $e");
  }
  return null;
}

Future<void> postComment(idFeed, content) async {
  var url = Uri.https(baseUrl, '/api/v1/Comments/Post');
  String? token = await getToken();
  var comment = createMapComment(idFeed, content);
  var response = await http.post(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: jsonEncode(comment),
  );

  if (response.statusCode == 201) {
    print('Comment request successful');
  } else {
    print(
        'Failed to make Comment request. Status code: ${response.statusCode}');
  }
}

Future<void> deleteComment(idComment) async {
  var url = Uri.https(baseUrl, '/api/v1/Comments/Delete');
  String? token = await getToken();
  var response = await http.delete(
    url,
    headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    },
    body: idComment.toString(),
  );

  if (response.statusCode == 200) {
    print('Delete request successful');
  } else {
    print('Failed to make Delete request. Status code: ${response.statusCode}');
  }
}
