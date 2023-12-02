import 'package:http/http.dart' as http;import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> likePost(idPost) async {
  var url = Uri.https('$baseUrl  + /api/Like/LikePost');
  String? token = await getToken();

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idPost,
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