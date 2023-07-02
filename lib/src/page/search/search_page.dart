import 'package:flutter/material.dart';
import 'package:whoru/src/page/appbar/appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const MyAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const MyAppBar(),
            Text(
              "Search Page",
            )
          ],
        ),
      ),
    );
  }
}
