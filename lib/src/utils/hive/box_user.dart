import 'package:hive/hive.dart';
import 'package:whoru/src/models/user_model.dart';
import 'package:whoru/src/utils/constant.dart';

void saveUser(UserModel userModel) {
  var box = Hive.box(boxUser);
  box.put('id', userModel.id);
  box.put('fullName', userModel.fullName);
  box.put('avt', userModel.avt);
  box.put('background', userModel.background);
  box.put('description', userModel.description);
  box.put('work', userModel.work);
  box.put('study', userModel.study);
  box.put('followerCount', userModel.followerCount);
  box.put('followingCount', userModel.followingCount);
  box.put('isFollow', userModel.isFollow);
}

UserModel getUser(int idUser) {
  var box = Hive.box(boxUser);
  final id = box.get('id');
  final fullName = box.get('fullName');
  final avt = box.get('avt');
  final background = box.get('background');
  final description = box.get('description');
  final work = box.get('work');
  final study = box.get('study');
  final followerCount = box.get('followerCount');
  final followingCount = box.get('followingCount');
  final isFollow = box.get('isFollow');

  final userModel = UserModel(
    id: id,
    fullName: fullName,
    avt: avt,
    background: background,
    description: description,
    work: work,
    study: study,
    followerCount: followerCount,
    followingCount: followingCount,
    isFollow: isFollow,
  );
  return userModel;
}
