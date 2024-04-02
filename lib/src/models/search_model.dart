class SearchModel {
  int idUser;
  String fullName;
  String avatar;


  SearchModel({
    required this.idUser,
    required this.fullName,
    required this.avatar,

  });
  factory SearchModel.fromJson(Map<dynamic, dynamic> json) {
    return SearchModel(
      idUser: json['idUser'] as int,
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String,
    );
  }
}