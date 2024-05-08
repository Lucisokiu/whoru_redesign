import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whoru/src/models/feed_model.dart';

import '../../../utils/token.dart';
import '../../feed/widget/feed_card.dart';
import 'package:http/http.dart' as http;

class FeedResults extends StatefulWidget {
  FeedResults({super.key, required this.query, required this.contextparent});
  String query;
  BuildContext contextparent;

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
        // future: getAllPost(), // search Post
        builder: (contextFutureBuilder, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
            color: Theme.of(widget.contextparent).scaffoldBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(widget.contextparent).dividerColor,
                color: Colors.black,
              ),
            ));
      } else if (snapshot.hasError) {
        return Container(
          color: Theme.of(widget.contextparent).scaffoldBackgroundColor,
          child: Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: Theme.of(widget.contextparent).textTheme.bodyMedium,
            ),
          ),
        );
      } else {
        if (widget.query.isEmpty) {
          return Container(
            color: Theme.of(widget.contextparent).scaffoldBackgroundColor,
            child: Center(
              child: Text(
                'Enter information',
                style: Theme.of(widget.contextparent).textTheme.bodyMedium,
              ),
            ),
          );
        } else if (snapshot.data != null && snapshot.data!.statusCode == 200) {
          List<dynamic> jsonList = jsonDecode(snapshot.data!.body);
          items = jsonList.map((item) => FeedModel.fromJson(item)).toList();
        } else {
          return Container(
            color: Theme.of(widget.contextparent).scaffoldBackgroundColor,
            child: Center(
              child: Text(
                'No results found.',
                style: Theme.of(widget.contextparent).textTheme.bodyMedium,
              ),
            ),
          );
        }

        if (items.isEmpty) {
          return Container(
            color: Theme.of(widget.contextparent).scaffoldBackgroundColor,
            child: Center(
              child: Text(
                'No results found.',
                style: Theme.of(widget.contextparent).textTheme.bodyMedium,
              ),
            ),
          );
        }

        return Container(
          color: Theme.of(widget.contextparent).scaffoldBackgroundColor,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return CardFeed(
                feed: items[index],
                CurrentUser: currentUser!,
              );
            },
          ),
        );
      }
    });
  }
}
