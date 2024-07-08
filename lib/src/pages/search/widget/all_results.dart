import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:whoru/src/models/feed_model.dart';
import 'package:whoru/src/models/user_model.dart';

import '../../../api/feed.dart';
import '../../../api/user_info.dart';
import '../../../models/search_model.dart';
import '../../../utils/shared_pref/iduser.dart';
import '../../feed/widget/feed_card.dart';
import '../../profile/profile_screen.dart';
import 'package:http/http.dart' as http;

import 'card_feed_search.dart';

class AllResults extends StatefulWidget {
  const AllResults(
      {super.key, required this.query, required this.parentContext});
  final String query;
  final BuildContext parentContext;
  @override
  State<AllResults> createState() => _AllResultsState();
}

class _AllResultsState extends State<AllResults> {
  List<dynamic> items = [];
  int? currentUser;
  bool isLoading = true;
  bool isNoResults = false;
  int page = 0;
  void getCurentUser() async {
    int? id = await getIdUser();
    if (mounted) {
      setState(() {
        currentUser = id;
      });
    }
  }

  getResult(query) async {
    int pages = ++page;
    Response results1 = await searchPost(query, pages);
    Response results2 = await getInfoUserByName(query, pages);

    List<dynamic> jsonList1 = jsonDecode(results1.body);
    List<dynamic> jsonList2 = jsonDecode(results2.body);

    final result1 = jsonList1.map((item) => FeedModel.fromJson(item)).toList();
    final result2 =
        jsonList2.map((item) => SearchModel.fromJson(item)).toList();
    print(result1.length);
    print(result2.length);
    // cho usre lên trên feed
    items.addAll(result2); // user
    items.addAll(result1); // feed
    if (mounted) {
      setState(() {
        isLoading = false;
        if (result1.isEmpty && result2.isEmpty) {
          isNoResults = true;
        }
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
          if (items[index] is SearchModel) {
            SearchModel result = items[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(result.avatar),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    result.fullName,
                    style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                  ),
                  Icon(Icons.account_circle,
                      color: Theme.of(widget.parentContext)
                          .textTheme
                          .bodyMedium!
                          .color)
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => ProfilePage(
                      idUser: result.idUser,
                      isMy: false,
                    ),
                  ),
                );
              },
            );
          } else if (items[index] is FeedModel) {
            FeedModel result = items[index];
            return CardFeedSearch(
              parentContext: widget.parentContext,
              feed: result,
              currentUser: currentUser!,
            );
          }

          return Container();
        },
      ),
    );
  }
}
