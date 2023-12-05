import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> likePost(idPost) async {
  var url = Uri.https(baseUrl,'/api/Like/LikePost');
  String? token = await getToken();
  print(url);
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
    print('Like request successful');
  } else {
    print('Failed to make Like request. Status code: ${response.statusCode}');
  }
}
