class Login {
  int userId;
  String userName;
  String message;
  bool success;
  Login({
    required this.userId,
    required this.userName,
    required this.message,
    required this.success,
  });

  factory Login.fromJson(dynamic json) {
    return Login(
      userId: json['userId'],
      userName: json['userName'],
      message: json['message'],
      success: json['success'],
    );
  }
}
  Map<String, dynamic> createMapLogin(userName, password) {
    return {
      'userName': userName,
      'password': password,
    };
  }