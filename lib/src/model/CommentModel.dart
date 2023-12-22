class CommentModel {
  final int idComment;
  final String content;
  final int idUser;
  final String fullName;
  final String avatar;

  CommentModel({
    required this.idComment,
    required this.content,
    required this.idUser,
    required this.fullName,
    required this.avatar,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      idComment: json['idComment'] as int,
      content: json['content'] as String,
      idUser: json['idUser'] as int,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String,
    );
  }
}

Map<String, dynamic> createMapComment(idFeed, content) {
  return {
    'idFeed': idFeed,
    'content': content,
  };
}
