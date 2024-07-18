import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notification_model.dart';
import '../utils/shared_pref/token.dart';
import '../utils/url.dart';

Future<List<NotificationModel>> getAllNotification() async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Notifications/GetAllNotification');
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
      List<NotificationModel> listNotif =
          decodedData.map((data) => NotificationModel.fromJson(data)).toList();
      return listNotif;
    } else {
      print("fail call api getAllNotification with page ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("fail call api getAllNotification $e");

    return [];
  }
}
