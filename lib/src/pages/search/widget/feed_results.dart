import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:whoru/src/models/feed_model.dart';

import '../../../api/feed.dart';
import '../../../utils/shared_pref/iduser.dart';
import 'package:http/http.dart' as http;

import 'card_feed_search.dart';

class FeedResults extends StatefulWidget {
  const FeedResults(
      {super.key, required this.query, required this.parentContext});
  final String query;
  final BuildContext parentContext;

  @override
  State<FeedResults> createState() => _FeedResultsState();
}

class _FeedResultsState extends State<FeedResults> {
  List<FeedModel> items = [];
  int? currentUser;
  int page = 0;
  bool isLoading = true;
  bool isNoResults = false;

  void getResult(query) async {
    isLoading = true;
    print("page $page");
    Response results = await searchPost(query, ++page);
    List<dynamic> jsonList = jsonDecode(results.body);

    final result = jsonList.map((item) => FeedModel.fromJson(item)).toList();

    items.addAll(result);
    if (mounted) {
      setState(() {
        isLoading = false;
        if (result.isEmpty) {
          isNoResults = true;
        }
      });
    }
  }

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
    if (widget.query.isNotEmpty) {
      getResult(widget.query);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    } else if (isLoading) {
      return Container(
          color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(widget.parentContext).dividerColor,
              color: Colors.black,
            ),
          ));
    } else if (items.isEmpty) {
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

    return Container(
      color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: items.length + 1,
        itemBuilder: (contextListView, index) {
          if (index == items.length) {
            if (!isNoResults) {
              getResult(widget.query);
            }

            return isNoResults
                ? Container()
                : Container(
                    color:
                        Theme.of(widget.parentContext).scaffoldBackgroundColor,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor:
                            Theme.of(widget.parentContext).dividerColor,
                        color: Colors.black,
                      ),
                    ));
          }

          return CardFeedSearch(
            parentContext: widget.parentContext,
            feed: items[index],
            currentUser: currentUser!,
          );
        },
      ),
    );
  }
}
