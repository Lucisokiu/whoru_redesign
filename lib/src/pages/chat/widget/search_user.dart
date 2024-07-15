import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/models/search_model.dart';
import 'package:whoru/src/models/user_chat.dart';
import 'package:whoru/src/pages/chat/screens/individual_page.dart';
import 'package:whoru/src/pages/chat/widget/search_widget.dart';

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
    res = await getInfoUserByName(name, 1);
    id = await getIdUser();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BuildSearchWidget(query: query, parentContext: context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildSearchWidget(query: query, parentContext: context);
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
