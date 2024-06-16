class NotificationModel {
  final int idUser;
  final String avatarUrl;
  final String name;
  final String time;
  final String content;

  NotificationModel({
    required this.idUser,
    required this.avatarUrl,
    required this.name,
    required this.time,
    required this.content,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      idUser: json['idUser'] as int,
      avatarUrl: json['avatar'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      content: json['notification'] as String,
    );
  }
}
