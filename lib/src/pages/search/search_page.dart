import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/search/page/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        elevation: 0.0,
        title: Text("Search"),
        actions: [
          IconButton(
              onPressed: () => {
                    showSearch(
                      context: context,
                      delegate: CustomSearch(),
                    )
                  },
              icon: Icon(
                Icons.search,
                size: 30.0,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MyAppBar(),

            Center(
              child: Text(
                "enter information",
                style: TextStyle(
                  fontSize: 20, // Điều chỉnh kích thước chữ ở đây
                  // fontWeight: FontWeight.bold, // Tô đậm văn bản
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
