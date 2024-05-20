import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whoru/src/models/feed_model.dart';

import '../../../api/feed.dart';
import '../../../utils/token.dart';
import 'package:http/http.dart' as http;

import 'card_feed_search.dart';

class FeedResults extends StatefulWidget {
  const FeedResults({super.key, required this.query, required this.parentContext});
  final String query;
  final BuildContext parentContext;

  @override
  State<FeedResults> createState() => _FeedResultsState();
}

class _FeedResultsState extends State<FeedResults> {
  List<FeedModel> items = [];
  int? currentUser;

  void getCurentUser() async {
    int? id = await getIdUser();
    if (mounted) {
      setState(() {
        currentUser = id;
      });
    }
  }

  @override
  void initState() {
    getCurentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Feed Results");

    return FutureBuilder<http.Response>(
        future: searchPost(widget.query), // search Post
        builder: (contextFutureBuilder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(widget.parentContext).dividerColor,
                    color: Colors.black,
                  ),
                ));
          } else if (snapshot.hasError) {
            return Container(
              color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                ),
              ),
            );
          } else {
            if (widget.query.isEmpty) {
              return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    'Enter information',
                    style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                  ),
                ),
              );
            } else if (snapshot.data != null &&
                snapshot.data!.statusCode == 200) {
              List<dynamic> jsonList = jsonDecode(snapshot.data!.body);
              items = jsonList.map((item) => FeedModel.fromJson(item)).toList();
            } else {
              return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    'No results found.',
                    style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                  ),
                ),
              );
            }

            if (items.isEmpty) {
              return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    'No results found.',
                    style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CardFeedSearch(
                  parentContext: widget.parentContext,
                  feed: items[index],
                  currentUser: currentUser!,
                );
              },
            );
          }
        });
  }
}
