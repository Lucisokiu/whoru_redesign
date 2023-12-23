import 'package:whoru/src/model/ChatModel.dart';
import 'package:whoru/src/model/SearchModel.dart';

class UserChat {
  int idUser;
  String fullName;
  String avatar;


  UserChat({
    required this.idUser,
    required this.fullName,
    required this.avatar,

  });
  factory UserChat.fromJson(Map<dynamic, dynamic> json) {
    return UserChat(
      idUser: json['idUser'] as int,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String,
    );
  }
  factory UserChat.fromSearchModel(SearchModel searchModel) {
    return UserChat(
      idUser: searchModel.idUser,
      fullName: searchModel.fullName,
      avatar: searchModel.avatar,
    );
  }
  factory UserChat.fromChatModel(ChatModel chatModel) {
    return UserChat(
      idUser: chatModel.id,
      fullName: chatModel.name,
      avatar: chatModel.icon,
    );
  }
}