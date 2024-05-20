import 'package:flutter/material.dart';
import 'package:whoru/src/pages/search/controller/search_bar.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: const Text("Search"),
        actions: [
          IconButton(
              onPressed: () => {
                    showSearch(
                      context: context,
                      delegate: CustomSearch(),
                    )
                  },
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ))
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child:  const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MyAppBar(),

              Center(
                child: Text(
                  "enter information",
                  style: TextStyle(
                    fontSize: 25, // Điều chỉnh kích thước chữ ở đây
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
