import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/model/User.dart';

class CustomSearch extends SearchDelegate {
  var res;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => {
                query = '',
              },
          icon: Icon(Icons.clear, color: Theme.of(context).iconTheme.color)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {
              close(context, null),
            },
        icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color));
  }

  void getUser(String name) async {
    res = await getInfoUserByName(name);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getUser(query);
    List<UserModel> matchQuery = [];
    if (res != null && res.statusCode == 200) {
      List<Map<dynamic, dynamic>> jsonList = jsonDecode(res.body);
      // Convert each item in the JSON array to a UserModel
      matchQuery = jsonList.map((item) => UserModel.fromJson(item)).toList();
    } else {
      return const Center(
        child: Text('No results found.'),
      );
    }
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
          title: Text(result.fullName),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    getUser(query);

    List<UserModel> matchQuery = [];
    if (res != null && res.statusCode == 200) {
      List<Map<dynamic, dynamic>> jsonList = jsonDecode(res.body);
      // Convert each item in the JSON array to a UserModel
      matchQuery = jsonList.map((item) => UserModel.fromJson(item)).toList();
    } else {
      return const Center(
        child: Text('No results found.'),
      );
    }
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
          title: Text(result.fullName),
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData(
      appBarTheme: AppBarTheme(
        color: theme.primaryColor,
      ),
      primaryColor: theme.primaryColor,
      primaryIconTheme: IconThemeData(
        color: theme.iconTheme.color,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: theme.textTheme.bodyMedium,
      ),
    );
  }
}
