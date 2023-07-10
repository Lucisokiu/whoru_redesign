class UserModel {
  int id;
  String username;
  String avt;
  String contact;

  UserModel({
    required this.id,
    required this.username,
    required this.avt,
    required this.contact,
  });
}

UserModel user = UserModel(
  id: 1,
  username: "john_doe",
  avt:
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
  contact: "123",
);


List<UserModel> listUsers = [
UserModel(
  id: 1,
  username: "Nhut",
  avt:
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
  contact: "123",
),
UserModel(
  id: 2,
  username: "Dat",
  avt:
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
  contact: "123",
),
UserModel(
  id: 3,
  username: "Giang",
  avt:
      'https://images.ctfassets.net/23aumh6u8s0i/4TsG2mTRrLFhlQ9G1m19sC/4c9f98d56165a0bdd71cbe7b9c2e2484/flutter',
  contact: "123",
),
];