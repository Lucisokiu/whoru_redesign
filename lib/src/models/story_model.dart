class Story {
  int idUser;
  String userName;
  String avatar;
  String imageUrl;

  String date;

  Story({
    required this.idUser,
    required this.date,
    required this.avatar,
    required this.imageUrl,
    required this.userName,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      idUser: json['id'],
      userName: json['name'],
      avatar: json['avatar'],
      imageUrl: json['imageUrl'],
      date: json['date'],
    );
  }
}
