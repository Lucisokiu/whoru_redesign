class ChatModel {
  final String name;
  final String icon;
  final bool isGroup;
  final String time;
  final String currentMessage;
  String? status;
  bool select = false;
  final int id;
  ChatModel({
    required this.name,
    required this.icon,
    required this.isGroup,
    required this.time,
    required this.currentMessage,
    this.status,
    this.select = false,
    required this.id,
  });
}
  List<ChatModel> chatmodels = [
    ChatModel(
      name: "Dev Stack",
      isGroup: false,
      currentMessage: "Hi Everyone",
      time: "4:00",
      icon: "person.svg",
      id: 1,
      status: "A full stack developer",
    ),
    ChatModel(
      name: "Kishor",
      isGroup: false,
      currentMessage: "Hi Kishor",
      time: "13:00",
      icon: "person.svg",
      id: 2,
      status: "A full stack developer",
    ),

    ChatModel(
      name: "Collins",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "8:00",
      icon: "person.svg",
      id: 3,
      status: "A full stack developer",
    ),

    ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
      status: "A full stack developer",
    ),
  ];

  ChatModel srcchat =     ChatModel(
      name: "Balram Rathore",
      isGroup: false,
      currentMessage: "Hi Dev Stack",
      time: "2:00",
      icon: "person.svg",
      id: 4,
      status: "A full stack developer",
    );