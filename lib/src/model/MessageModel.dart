class MessageModel {
  int? id;
  final String date;
  final String message;
  final String type;
  final int userSend;
  final int userReceive;

  MessageModel({
    this.id,
    required this.date,
    required this.message,
    required this.type,
    required this.userSend,
    required this.userReceive,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      date: json['date'],
      message: json['message'],
      type: json['type'],
      userSend: json['userSend'],
      userReceive: json['userReceive'],
    );
  }
}
