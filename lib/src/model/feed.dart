import 'package:whoru/src/model/user.dart';

class FeedModel {
  UserModel userModel;
  String content;
  List<String> imageUrls;
  int likeCount;
  int commentCount;
  int shareCount;
  bool? active;
  bool? account;
  String title;

  FeedModel({
    required this.userModel,
    required this.content,
    required this.imageUrls,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.title,
    this.active,
    this.account,
  });
}

List<FeedModel> feedList = [
  FeedModel(
    userModel: user1,
    content:
        'Những khoảnh khắc tươi đẹp luôn đáng để chia sẻ. Hôm nay, mình đã bắt gặp một khoảnh khắc đáng nhớ và muốn chia sẻ nó với mọi người. Chia sẻ niềm vui và nắm bắt những khoảnh khắc tuyệt vời trong cuộc sống của bạn! 📷❤️ #LifeMoments #SharingJoy',
    imageUrls: [
      'https://static2.yan.vn/YanNews/2167221/202002/cach-selfie-dep-than-sau-giup-ban-co-nhung-buc-hinh-nghin-likes-038cefad.jpg',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: false,
    account: false,
    title: "vừa cập nhật trạng thái của cô ấy",
  ),
  FeedModel(
    userModel: user2,
    content:
        'Ngày nắng đẹp như thế này làm mình cảm thấy sống đúng nghĩa. Chia sẻ niềm vui cùng mọi người! ☀️📸 #NangAm #CuocSong',
    imageUrls: [
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiZ6vGLQBc9GIK_tpP4YFbIXzFWQ85BO7r5Q&usqp=CAU',
      'https://kenh14cdn.com/thumb_w/660/203336854389633024/2022/1/11/photo-1-1641890852658866773669.jpg',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: true,
    account: true,
    title: "vừa đăng một khoảng khắc của cô ấy",
  ),
  FeedModel(
    userModel: user3,
    content:
        'Một chút đổi gió giữa ngày bình thường. Chúng ta cùng nhau tạo nên những kỷ niệm đáng nhớ. 🌈💫 #KhoanhKhacYeuThuong #ChiaSeNiemVui',
    imageUrls: [
      'https://www.vivosmartphone.vn/uploads/MANGOADS/ch%E1%BB%A5p%20%E1%BA%A3nh/selfie%20nu%20dep/cach%20selfie%20dep%20cho%20nu%204.jpg',
      'https://static2.yan.vn/YanNews/2167221/201704/20170423-111017-s1_480x600.jpeg',
      'https://www.chapter3d.com/wp-content/uploads/2020/07/selfie-2.jpg',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: true,
    account: false,
    title: "vừa đăng một khoảng khắc của cô ấy",
  ),
  FeedModel(
    userModel: user4,
    content:
        'Một chút đổi gió giữa ngày bình thường. Chúng ta cùng nhau tạo nên những kỷ niệm đáng nhớ. 🌈💫 #KhoanhKhacYeuThuong #ChiaSeNiemVui',
    imageUrls: [
      'https://www.vietnamfineart.com.vn/wp-content/uploads/2023/07/gai-tay-lanh-lung-2.jpg',
      'https://i.pinimg.com/236x/f8/c0/75/f8c0757ec32e006e8b62a4432fd6b3ff.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSuGXyn_spHo6Qlk9gIJa5zazZMq3F9w3g9cnRp87DzRJ34gt4uSS4f9ChOveppEljmDQg&usqp=CAU',
      'https://images.kienthuc.net.vn/zoom/800/uploaded/nguyenanhson/2021_06_03/4/dep-tua-tinh-dau-hot-girl-nga-lam-netizen-tan-chay-la-ai-hinh-3.jpg',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: false,
    account: true,
    title: "vừa đăng một khoảng khắc của cô ấy",
  ),
  FeedModel(
    userModel: user5,
    content:
        'Chúng ta có thể khám phá thế giới và khám phá bản thân mình mỗi ngày. Hãy giữ vững niềm tin và mãi mãi yêu cuộc sống. 🌎📸 #KhamPhaBanThan #CuocSongLaPhieuLuu',
    imageUrls: [
      'https://mixhotel.vn/uploads/images/62441d61d6a5eb1d06698106/cach-tao-dang-selfie__8_.webp',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLVP6zHLYcoaHWdHCmobHBo_T7NoMEWhxEtA&usqp=CAU',
      'https://inkythuatso.com/uploads/thumbnails/800/2023/02/cach-tao-dang-selfie-cho-nu-tay-chong-cam-5-16-14-35-26.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzsriJoSv4ppOLIAvi2JerzuRPEXLNgp96ow&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzsriJoSv4ppOLIAvi2JerzuRPEXLNgp96ow&usqp=CAU',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: true,
    account: false,
    title: "vừa đăng một khoảng khắc của cô ấy",
  ),
  FeedModel(
    userModel: user6,
    content:
        'Hãy để niềm đam mê dẫn lối cho bạn và tạo ra những kỷ niệm đáng nhớ. Cuộc sống đẹp đến từ việc khám phá và trải nghiệm. 🌺📸 #DamMe #KhoanhKhacDep',
    imageUrls: [
      'https://ktmt.vnmediacdn.com/stores/news_dataimages/nguyenducgiang/062019/30/15/in_article/khi-canh-vat-cung-biet-buon_2.jpg',
      'https://anhdep123.com/wp-content/uploads/2020/11/anh-bai-bien-buon-luc-hoang-hon.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfgEP17ST4k71VoAGFrl5x-rIBfu9gjFAK3fashdAbZ0IuEHP1G_nWQuBPptqAcfturYI&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7xIkdpcrioF4G6ukaVc24a9QsNGyWlWYSHhKMTx5d6YNUSa12tGPMM9Birxu0AmLQeE&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7xIkdpcrioF4G6ukaVc24a9QsNGyWlWYSHhKMTx5d6YNUSa12tGPMM9Birxu0AmLQeE&usqp=CAU',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC7xIkdpcrioF4G6ukaVc24a9QsNGyWlWYSHhKMTx5d6YNUSa12tGPMM9Birxu0AmLQeE&usqp=CAU',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: false,
    account: false,
    title: "vừa đăng một khoảng khắc của cô ấy",
  ),
  FeedModel(
    userModel: user7,
    content:
        'Hãy để niềm đam mê dẫn lối cho bạn và tạo ra những kỷ niệm đáng nhớ. Cuộc sống đẹp đến từ việc khám phá và trải nghiệm. 🌺📸 #DamMe #KhoanhKhacDep',
    imageUrls: [
      'https://genk.mediacdn.vn/N0WoyYblO3QdmZFKPMtKnadHAHTevz/Image/2012/VienChinh/06/wallpaper1_11e19.jpg',
      'https://media.istockphoto.com/id/691930476/vi/anh/phong-c%E1%BA%A3nh-tuscany-l%C3%BAc-b%C3%ACnh-minh-v%E1%BB%9Bi-s%C6%B0%C6%A1ng-m%C3%B9-th%E1%BA%A5p.jpg?s=612x612&w=0&k=20&c=QJmqogk4OA_ykhTw1JoL0-_kbYFfFCqOTsaWR9R0X0c=',
      'https://media.istockphoto.com/id/1042404662/vi/anh/%C4%91%E1%BB%89nh-n%C3%BAi-zugspitze-ng%C3%A0y-h%C3%A8-t%E1%BA%A1i-h%E1%BB%93-eibsee-g%E1%BA%A7n-garmisch-partenkirchen-bavaria-%C4%91%E1%BB%A9c.jpg?s=612x612&w=0&k=20&c=MW8fZ3NhCtafoeo8gREfgPlxOaO51wefD3LaIOz_Bv4=',
      'https://lh5.googleusercontent.com/QDhhmOxeT2y4lX_c6GBNk9A0UPA6IE2WdSkaJMPjRGZK44qOBwuUPQ6ovxizz_TG5M7hfuqPKybNc2TL1KZz0zsqzq-wkQoHvRWbgIC6dCcN_F2RB3w0nEBqoYJN5EMTeFMtY0M=s0',
      'https://lh5.googleusercontent.com/QDhhmOxeT2y4lX_c6GBNk9A0UPA6IE2WdSkaJMPjRGZK44qOBwuUPQ6ovxizz_TG5M7hfuqPKybNc2TL1KZz0zsqzq-wkQoHvRWbgIC6dCcN_F2RB3w0nEBqoYJN5EMTeFMtY0M=s0',
      'https://lh5.googleusercontent.com/QDhhmOxeT2y4lX_c6GBNk9A0UPA6IE2WdSkaJMPjRGZK44qOBwuUPQ6ovxizz_TG5M7hfuqPKybNc2TL1KZz0zsqzq-wkQoHvRWbgIC6dCcN_F2RB3w0nEBqoYJN5EMTeFMtY0M=s0',
      'https://lh5.googleusercontent.com/QDhhmOxeT2y4lX_c6GBNk9A0UPA6IE2WdSkaJMPjRGZK44qOBwuUPQ6ovxizz_TG5M7hfuqPKybNc2TL1KZz0zsqzq-wkQoHvRWbgIC6dCcN_F2RB3w0nEBqoYJN5EMTeFMtY0M=s0',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
    active: false,
    account: false,
    title: "vừa đăng một khoảng khắc của cô ấy",
  ),
];
