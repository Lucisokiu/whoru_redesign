class Story {
  int idUser;
  int idStory;
  String name;
  String avatar;
  String imageUrl;
  String date;

  Story({
    required this.idUser,
    required this.idStory,
    required this.date,
    required this.avatar,
    required this.imageUrl,
    required this.name,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      idUser: json['idUser'],
      idStory: json['idStory'],
      name: json['name'],
      avatar: json['avatar'],
      imageUrl: json['imageUrl'],
      date: json['date'],
    );
  }
}
