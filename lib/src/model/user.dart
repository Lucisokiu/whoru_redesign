class UserModel {
  int id;
  String fullName;
  String avt;
  String background;

  String description;
  String work;
  String study;

  UserModel({
    required this.id,
    required this.fullName,
    required this.avt,
    required this.background,
    required this.description,
    required this.work,
    required this.study,
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
    );
  }
}
// UserModel user = UserModel(
//   id: 0,
//   username: "Nguyễn Minh Nhựt",
//   avt:
//       'https://avatars.githubusercontent.com/u/95356357?v=4',
//   contact: "0909374409",
// );

// UserModel user1 = UserModel(
//   id: 1,
//   username: "Yến Nhi",
//   avt:
//       'https://gaixinhbikini.com/wp-content/uploads/2023/02/anh-gai-dep-toc-ngan-che-mat-cute.jpg',
//   contact: "123",
// );

// UserModel user2 = UserModel(
//   id: 2,
//   username: "Nữ",
//   avt:
//       'https://gaixinhbikini.com/wp-content/uploads/2022/08/xinh-toc-ngang-vai-2k9-anh-gai-1.jpg',
//   contact: "123",
// );
// UserModel user3 = UserModel(
//   id: 3,
//   username: "Giang",
//   avt:
//       'https://computechz.com/wp-content/uploads/2022/08/anh-con-gai-uong-tra-sua-che-mat-4.jpg',
//   contact: "123",
// );
// UserModel user4 = UserModel(
//   id: 4,
//   username: "Thư",
//   avt:
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZD2wSC7J4pmarEQ0_JmVaZJq7gPPeIzeOeA&usqp=CAU',
//   contact: "123",
// );
// UserModel user5 = UserModel(
//   id: 5,
//   username: "Linh",
//   avt:
//       'https://haycafe.vn/wp-content/uploads/2022/03/Anh-gai-xinh-deo-kinh-480x600.jpg',
//   contact: "123",
// );
// UserModel user6 = UserModel(
//   id: 6,
//   username: "Ngọc",
//   avt:
//       'https://baoninhbinh.org.vn/DATA/ARTICLES/2022/11/7/trien-lam-ben-may-gioi-thieu-40-buc-tranh-phong-canh-c13db.jpg',
//   contact: "123",
// );
// UserModel user7 = UserModel(
//   id: 7,
//   username: "Mỹ",
//   avt:
//       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJ-8Ks3VVOKKrckdnK06eQhsMVtxuY4bA3pAT-5eh_4lwi4uwlo_R8fF7BZ-VbHBN5RCo&usqp=CAU',
//   contact: "123",
// );

// List<UserModel> listUsers = [
// UserModel(
//   id: 1,
//   username: "Trúc",
//   avt:
//       'https://mega.com.vn/media/news/0406_anh-gai-xinh-106.jpg',
//   contact: "123",
// ),
// UserModel(
//   id: 2,
//   username: "Nữ",
//   avt:
//       'https://gaixinhbikini.com/wp-content/uploads/2022/08/xinh-toc-ngang-vai-2k9-anh-gai-1.jpg',
//   contact: "123",
// ),
// UserModel(
//   id: 3,
//   username: "Giang",
//   avt:
//       'https://my7up.vn/wp-content/uploads/gai-xinh-che-mat-13.jpg',
//   contact: "123",
// ),
// UserModel(
//   id: 4,
//   username: "Flutter",
//   avt:
//       'https://yt3.googleusercontent.com/ytc/APkrFKaD8t4oFlgXcZKoW512Z81CBJuej3K9uHAlSI0x=s900-c-k-c0x00ffffff-no-rj',
//   contact: "123",
// ),
// ];