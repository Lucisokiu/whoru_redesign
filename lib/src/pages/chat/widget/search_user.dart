import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/models/search_model.dart';
import 'package:whoru/src/models/user_chat.dart';
import 'package:whoru/src/pages/chat/screens/individual_page.dart';

import '../../../utils/shared_pref/iduser.dart';

class SearchUserChat extends SearchDelegate {
  dynamic res;
  int? id;
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
    res = await getInfoUserByName(name,1);
    id = await getIdUser();
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndividualPage(
                            user: UserChat.fromSearchModel(result),
                            currentId: id!,
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
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndividualPage(
                            user: UserChat.fromSearchModel(result),
                            currentId: id!,
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
            hintStyle: Theme.of(context).textTheme.bodyMedium),
        textTheme: Theme.of(context).textTheme);
  }
}
