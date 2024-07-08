import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:whoru/src/models/user_model.dart';

import '../../../api/user_info.dart';
import '../../../models/search_model.dart';
import '../../../utils/shared_pref/iduser.dart';
import 'package:http/http.dart' as http;

import '../../profile/profile_screen.dart';

class UserResults extends StatefulWidget {
  const UserResults(
      {super.key, required this.query, required this.parentContext});
  final String query;
  final BuildContext parentContext;
  @override
  State<UserResults> createState() => _UserResultsState();
}

class _UserResultsState extends State<UserResults> {
  List<SearchModel> items = [];
  int? currentUser;
  int page = 0;
  bool isLoading = true;
  bool isNoResults = false;
  void getCurentUser() async {
    int? id = await getIdUser();
    if (mounted) {
      setState(() {
        currentUser = id;
      });
    }
  }

  void getResult(query) async {
      isLoading = true;
          print("page $page");

      Response results = await getInfoUserByName(query, ++page);
      print(results.body);
      List<dynamic> jsonList = jsonDecode(results.body);

      final result =
          jsonList.map((item) => SearchModel.fromJson(item)).toList();

      items.addAll(result);
      setState(() {
        isLoading = false;
        if (result.isEmpty) {
          isNoResults = true;
        }
      });
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
        },
      ),
    );
  }
}
