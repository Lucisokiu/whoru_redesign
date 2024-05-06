import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:whoru/src/api/userInfo.dart';
import 'package:whoru/src/models/search_model.dart';
import 'package:whoru/src/pages/profile/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:whoru/src/pages/search/widget/screen_results.dart';

class CustomSearch extends SearchDelegate {
  var currentIndex = 0;
  bool showBottomNavigationBar = false;
  late List<SearchModel> matchQuery;

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
    showBottomNavigationBar = false;

    return FutureBuilder<http.Response>(
        future: getInfoUserByName(query),
        builder: (contextFutureBuilder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).dividerColor,
                    color: Colors.black,
                  ),
                ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<SearchModel> matchQuery = [];
            if (query.isEmpty) {
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    'Enter information',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              );
            }
            if (snapshot.data != null && snapshot.data!.statusCode == 200) {
              List<dynamic> jsonList = jsonDecode(snapshot.data!.body);
              matchQuery =
                  jsonList.map((item) => SearchModel.fromJson(item)).toList();
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
                    'User not found',
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
                    }));
          }
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    showBottomNavigationBar = true;

    return FutureBuilder<http.Response>(
      future: getInfoUserByName(query),
      builder: (contextFutureBuilder, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).dividerColor,
                  color: Colors.black,
                ),
              ));
        } else if (snapshot.hasError) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        } else {
          List<SearchModel> matchQuery = [];

          if (query.isEmpty) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  'Enter information',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          } else if (snapshot.data != null &&
              snapshot.data!.statusCode == 200) {
            List<dynamic> jsonList = jsonDecode(snapshot.data!.body);
            matchQuery =
                jsonList.map((item) => SearchModel.fromJson(item)).toList();
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
          List<Widget> tabs = [
            AllResults(matchQuery: matchQuery),
            AllResults(matchQuery: matchQuery),
          ];
          return tabs[currentIndex];
        }
      },
    );
  }

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    if (showBottomNavigationBar) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: StatefulBuilder(
          builder: (context, setState) => DefaultTabController(
            initialIndex: currentIndex,
            length: 3,
            child: TabBar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              indicatorColor: Colors.red,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "All",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Users",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Feed",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return PreferredSize(
        preferredSize: Size.zero,
        child: Container(),
      );
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData(
        appBarTheme: AppBarTheme(
          color: theme.scaffoldBackgroundColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
            ));
  }
}
