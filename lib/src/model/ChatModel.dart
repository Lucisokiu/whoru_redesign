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
    idUser: 3,
    fullName: "Nguyen Minh Nhut",
    avatar:
    "https://firebasestorage.googleapis.com/v0/b/whoru-2f115.appspot.com/o/Avatars%2Fdefault-avatar.jpg?alt=media&token=7721df77-f806-41c7-bcfe-2aae9acc98c7",
    currentMessage: "hello",
    type: "Message",
    isSeen: true,
  ),
  ChatModel(
    idUser: 2,
    fullName: "Nguyen Minh Nhut",
    avatar:
    "https://firebasestorage.googleapis.com/v0/b/whoru-2f115.appspot.com/o/Avatars%2Fdefault-avatar.jpg?alt=media&token=7721df77-f806-41c7-bcfe-2aae9acc98c7",
    currentMessage: "hello",
    type: "Message",
    isSeen: true,
  ),
];

List<ChatModel> additionalChatmodels = [
  ChatModel(
    idUser: 4,
    fullName: "Balram Rathore",
    avatar: "path_to_avatar", // Thay thế bằng đường dẫn thực sự đến hình ảnh avatar
    currentMessage: "Hi Dev Stack",
    type: "Message",
    isSeen: false, // Thay đổi tùy thuộc vào trạng thái
  ),
];

ChatModel srcchat = ChatModel(
  idUser: 4,
  fullName: "Balram Rathore",
  avatar: "path_to_avatar", // Thay thế bằng đường dẫn thực sự đến hình ảnh avatar
  currentMessage: "Hi Dev Stack",
  type: "Message",
  isSeen: false, // Thay đổi tùy thuộc vào trạng thái
);
