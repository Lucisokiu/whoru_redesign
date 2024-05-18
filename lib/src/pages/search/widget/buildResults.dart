import 'package:flutter/material.dart';
import 'package:whoru/src/pages/search/widget/user_results.dart';

import 'all_results.dart';
import 'feed_results.dart';

class BuildResultsWidget extends StatefulWidget {
  BuildResultsWidget(
      {super.key, required this.query, required this.parentContext});
  String query;
  final BuildContext parentContext;

  @override
  State<BuildResultsWidget> createState() => _BuildResultsWidgetState();
}

class _BuildResultsWidgetState extends State<BuildResultsWidget> {
  int currentIndex = 0;
  final showBottomNavigationBar = true;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      AllResults(query: widget.query, parentContext: widget.parentContext,),
      UserResults(query: widget.query, parentContext: widget.parentContext,),
      FeedResults(query: widget.query, parentContext: widget.parentContext,),
    ];
    return DefaultTabController(
      initialIndex: currentIndex,
      length: 3,
      child: Container(
        color: Theme.of(widget.parentContext).scaffoldBackgroundColor,
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              indicatorColor: Colors.blueAccent,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("All",
                      style: TextStyle(
                        color: Theme.of(widget.parentContext).textTheme.bodyMedium!.color,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Users",
                      style: TextStyle(
                        color: Theme.of(widget.parentContext).textTheme.bodyMedium!.color,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Feed",
                      style: TextStyle(
                        color: Theme.of(widget.parentContext).textTheme.bodyMedium!.color,
                      )),
                ),
              ],
            ),
            Expanded(child: tabs[currentIndex]),
          ],
        ),
      ),
    );
  }
}
