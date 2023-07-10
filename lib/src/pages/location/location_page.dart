import 'package:flutter/material.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(),
            Text(
              "Location Page",
            )
          ],
        ),
      ),
    );
  }
}
