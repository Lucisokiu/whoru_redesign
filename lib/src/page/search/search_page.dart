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
    return const Scaffold(

      appBar: MyAppBar(),
        body: Center(
        child: Text(
          'This is the Search page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }

}