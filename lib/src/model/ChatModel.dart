class ChatModel {
  final int idUser;
  final String fullName;
  final String avatar;
  final String currentMessage;
  final String type;
  bool isSeen;

  ChatModel({
    required this.idUser,
    required this.fullName,
    required this.avatar,
    required this.currentMessage,
    required this.type,
    this.isSeen = false,
  });
}

List<ChatModel> chatmodels = [
  ChatModel(
    idUser: 2,
    fullName: "Nguyen Minh Nhut",
    avatar:
    "https://firebasestorage.googleapis.com/v0/b/whoru-2f115.appspot.com/o/Avatars%2Fdefault-avatar.jpg?alt=media&token=7721df77-f806-41c7-bcfe-2aae9acc98c7",
    currentMessage: "hello",
    type: "Message",
    isSeen: true,
  ),
  ChatModel(
    idUser: 1,
    fullName: "Nguyen Minh Cuong",
    avatar:
    "https://firebasestorage.googleapis.com/v0/b/whoru-2f115.appspot.com/o/Avatars%2Fdefault-avatar.jpg?alt=media&token=7721df77-f806-41c7-bcfe-2aae9acc98c7",
    currentMessage: "hello",
    type: "Message",
    isSeen: true,
  ),
];
