import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:whoru/src/models/chat_model.dart';
import 'package:whoru/src/models/message_model.dart';
import 'package:whoru/src/utils/token.dart';
import 'package:whoru/src/utils/url.dart';

Future<List<ChatModel>> getAllUserChat() async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Chats/GetAllChatUser');
    String? token = await getToken();

    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Decode JSON and map it to List<FeedModel>
      List<dynamic> decodedData = jsonDecode(response.body);
      List<ChatModel> chatList =
          decodedData.map((data) => ChatModel.fromJson(data)).toList();
      return chatList;
    } else {
      print("Error ${response.statusCode}");

      return [];
    }
  } catch (e) {
    print("Error $e");
    return [];
  }
}

Future<List<MessageModel>> getAllChat(int idUser) async {
  try {
    var url = Uri.https(baseUrl, '/api/v1/Chats/GetAllChat');
    String? token = await getToken();

    var response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'bearer $token',
      },
      body: idUser.toString(),
    );

    if (response.statusCode == 200) {
      // Decode JSON and map it to List<FeedModel>
      List<dynamic> decodedData = jsonDecode(response.body);
      List<MessageModel> chatList =
          decodedData.map((data) => MessageModel.fromJson(data)).toList();
      return chatList;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}
