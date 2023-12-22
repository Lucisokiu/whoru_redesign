import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/model/SearchModel.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';

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
    List<SearchModel> matchQuery = [];
    if (res != null && res.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(res.body);
      // Convert each item in the JSON array to a UserModel
      matchQuery = jsonList.map((item) => SearchModel.fromJson(item)).toList();
    } else {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Text(
            'No results found.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    if (matchQuery.isEmpty) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Text(
            'No results found.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          SearchModel result = matchQuery[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(result.avatar),
            ),
            title: Text(
              result.fullName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => ProfilePage(
                            idUser: result.idUser,
                            isMy: false,
                          )));
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    getUser(query);

    List<SearchModel> matchQuery = [];
    if (res != null && res.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(res.body);
      // Convert each item in the JSON array to a UserModel
      matchQuery = jsonList.map((item) => SearchModel.fromJson(item)).toList();
    } else {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Text(
            'No results found.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    if (matchQuery.isEmpty) {
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Text(
            'No results found.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          SearchModel result = matchQuery[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(result.avatar),
            ),
            title: Text(
              result.fullName,
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => ProfilePage(
                            idUser: result.idUser,
                            isMy: false,
                          )));
            },
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData(
        appBarTheme: AppBarTheme(
          color: theme.scaffoldBackgroundColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: Theme.of(context).textTheme.bodyMedium
        ),
        textTheme: Theme.of(context).textTheme);
  }
}
