class UserModel {
  int id;
  String fullName;
  String avt;
  String background;
  String description;
  String work;
  String study;
  int followerCount;
  int followingCount;
  bool isFollow;

  UserModel({
    required this.id,
    required this.fullName,
    required this.avt,
    required this.background,
    required this.description,
    required this.work,
    required this.study,
    required this.followerCount,
    required this.followingCount,
    required this.isFollow,


  });
  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      avt: json['avatar'] as String,
      background: json['background'] as String,
      description: json['description'] as String,
      work: json['work'] as String,
      study: json['study'] as String,
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      isFollow: json['isFollow'] as bool,

    );
  }
}