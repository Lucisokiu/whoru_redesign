import 'package:flutter/material.dart';

import '../../../models/search_model.dart';
import '../../profile/profile_screen.dart';

class AllResults extends StatefulWidget {
  AllResults({super.key, required this.matchQuery});
  List<SearchModel> matchQuery;

  @override
  State<AllResults> createState() => _AllResultsState();
}

class _AllResultsState extends State<AllResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.builder(
          itemCount: widget.matchQuery.length,
          itemBuilder: (context, index) {
            SearchModel result = widget.matchQuery[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(result.avatar),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    result.fullName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Icon(Icons.account_circle,
                      color: Theme.of(context).textTheme.bodyMedium!.color)
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
      ),
    );
  }
}
