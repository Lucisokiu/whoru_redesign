import 'package:flutter/material.dart';
import 'package:whoru/src/page/appbar/appbar.dart';
import 'package:whoru/src/page/home/widget/feed_cart.dart';
import 'package:whoru/src/page/home/widget/story_widget.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const MyAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const MyAppBar(),
            Text(
              "Location Page",
            )
          ],
        ),
      ),
    );
  }
}
