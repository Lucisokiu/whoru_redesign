import 'package:flutter/material.dart';
import 'package:whoru/src/api/user.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/model/User.dart';

class CustomSearch extends SearchDelegate {
  List<UserModel>? user;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => {
                query = '',
              },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {
              close(context, null),
            },
        icon: const Icon(Icons.arrow_back));
  }

  void getUser(String name) async {
    // user = await getInfoUserByName(name);
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> matchQuery = [];

    // for (UserModel item in listUsers) {
    //   if (query.isNotEmpty &&
    //       item.username.toLowerCase().contains(query.toLowerCase())) {
    //     print("$item + $query");
    //     matchQuery.add(item);
    //   }
    // }

    if (matchQuery.isEmpty) {
      return const Center(
        child: Text('No results found.'),
      );
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        UserModel result = matchQuery[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(result.avt),
          ),
          // title: Text(result.username),
        );
      },
    );
  }

// cho phép tìm kiếm bài viết theo tên người dùng, cho các lựa chọn [người dùng, bài viết]
// nhập username -> tìm người dùng : bài viết của người dùng đó
  @override
  Widget buildResults(BuildContext context) {
    print(query);
    List<UserModel> matchQuery = [];
    // for (UserModel item in listUsers) {
    //   if (query.isNotEmpty &&
    //       item.username.toLowerCase().contains(query.toLowerCase())) {
    //     print("$item + $query");
    //     matchQuery.add(item);
    //   }
    // }

    if (matchQuery.isEmpty) {
      return const Center(
        child: Text('No results found.'),
      );
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        UserModel result = matchQuery[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(result.avt),
          ),
          // title: Text(result.username),
        );
      },
    );
  }
}
