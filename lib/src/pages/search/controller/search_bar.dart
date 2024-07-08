import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/models/search_model.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:whoru/src/pages/search/widget/buid_suggestions.dart';
import 'package:whoru/src/pages/search/widget/build_results.dart';

class CustomSearch extends SearchDelegate {
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

  @override
  Widget buildSuggestions(BuildContext context) {
    return BuildSuggestionsWidget(query: query, parentContext: context);
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildResultsWidget(query: query, parentContext: context);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData(
      appBarTheme: AppBarTheme(
        color: theme.scaffoldBackgroundColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
            color: theme.focusColor, // Màu viền khi thanh tìm kiếm được focus
            width: 3.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
          borderSide: BorderSide(
            color: theme.dividerColor,
            // Màu viền khi thanh tìm kiếm không được focus
            width: 1.0,
          ),
        ),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            titleLarge: TextStyle(color: theme.textTheme.bodyMedium!.color),
          ),
    );
  }
}
