import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whoru/src/pages/chat/screens/individual_page.dart';
import 'package:whoru/src/pages/splash/splash.dart';

import '../../../api/user_info.dart';
import '../../../models/search_model.dart';
import '../../../models/user_chat.dart';
import '../../profile/profile_screen.dart';
import 'package:http/http.dart' as http;

class BuildSearchWidget extends StatefulWidget {
  final String query;
  final BuildContext parentContext;

  const BuildSearchWidget(
      {super.key, required this.query, required this.parentContext});

  @override
  State<BuildSearchWidget> createState() => _BuildSearchWidgetState();
}

class _BuildSearchWidgetState extends State<BuildSearchWidget> {
  List<SearchModel> matchQuery = [];
  void matchResults(body) {
    List<dynamic> jsonList = jsonDecode(body);
    matchQuery = jsonList.map((item) => SearchModel.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: getInfoUserByName(widget.query, 1),
        builder: (contextFutureBuilder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor:
                        Theme.of(widget.parentContext).dividerColor,
                    color: Colors.black,
                  ),
                ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
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
            }
            if (snapshot.data != null && snapshot.data!.statusCode == 200) {
              matchResults(snapshot.data!.body);
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
            if (matchQuery.isEmpty) {
              return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
                child: Center(
                  child: Text(
                    'User not found',
                    style: Theme.of(widget.parentContext).textTheme.bodyMedium,
                  ),
                ),
              );
            }

            return Container(
                color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
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
                          style: Theme.of(widget.parentContext)
                              .textTheme
                              .bodyMedium,
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndividualPage(
                                        user: UserChat.fromSearchModel(result),
                                        currentId: localIdUser,
                                      )));
                        },
                      );
                    }));
          }
        });
  }
}
