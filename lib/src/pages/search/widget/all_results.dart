import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whoru/src/models/feed_model.dart';

import '../../../api/user_info.dart';
import '../../../models/search_model.dart';
import '../../../utils/token.dart';
import '../../feed/widget/feed_card.dart';
import '../../profile/profile_screen.dart';
import 'package:http/http.dart' as http;

class AllResults extends StatefulWidget {
  const AllResults({super.key, required this.query, required this.parentContext});
  final String query;
  final BuildContext parentContext;
  @override
  State<AllResults> createState() => _AllResultsState();
}

class _AllResultsState extends State<AllResults> {
  List<dynamic> items = [];
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
    print("All Results");
    return FutureBuilder<http.Response>(
        future: getInfoUserByName(widget.query),
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
              items =
                  jsonList.map((item) => SearchModel.fromJson(item)).toList();
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

            return Container(
              color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
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
                              color:
                                  Theme.of(widget.parentContext).textTheme.bodyMedium!.color)
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
                  }
                  if (items[index] is FeedModel) {
                    FeedModel result = items[index];
                    CardFeed(
                      feed: result,
                      currentUser: currentUser!,
                    );
                  }

                  return null;
                },
              ),
            );
          }
        });
  }
}
