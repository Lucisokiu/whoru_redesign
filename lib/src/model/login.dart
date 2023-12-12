class Login {
  int userId;
  String? userName;
  String message;
  bool success;
  bool? isDisabled;
  String? token;
  Login(
      {required this.userId,
      this.userName,
      required this.message,
      required this.success,
      this.isDisabled,
      this.token
      }
      );

  factory Login.fromJson(dynamic json) {
    return Login(
      userId: json['userId'],
      userName: json['userName'] as String?,
      message: json['message'],
      success: json['success'],
      isDisabled: json['isDisabled'] as bool?,
      token: json['token'] as String?,
    );
  }
}

Map<String, dynamic> createMapLogin(userName, password) {
  return {
    'userName': userName,
    'password': password,
  };
}
