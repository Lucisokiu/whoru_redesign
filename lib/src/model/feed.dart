import 'package:whoru/src/model/user.dart';

class FeedModel {
  UserModel userModel;
  String content;
  List<String> imageUrls;
  int likeCount;
  int commentCount;
  int shareCount;

  FeedModel({
    required this.userModel,
    required this.content,
    required this.imageUrls,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  });
}

List<FeedModel> feedList = [
  FeedModel(
    userModel: user,
    content: 'Lorem ipsum dolor sit amet',
    imageUrls: [
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
  ),
  FeedModel(
    userModel: user,
    content: 'Lorem ipsum dolor sit amet',
    imageUrls: [
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
  ),
  FeedModel(
    userModel: user,
    content: 'Lorem ipsum dolor sit amet',
    imageUrls: [
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
  ),
  FeedModel(
    userModel: user,
    content: 'Lorem ipsum dolor sit amet',
    imageUrls: [
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
    ],
    likeCount: 10,
    commentCount: 5,
    shareCount: 3,
  ),
];
