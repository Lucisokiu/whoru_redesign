import 'package:http/http.dart' as http;
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<void> Delete(idPost) async {
  var url = Uri.https('$baseUrl  + /api/Feed/Delete');
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
      print('POST request successful');
    } else {
      print('Failed to make POST request. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during API call: $e');
  }
}
