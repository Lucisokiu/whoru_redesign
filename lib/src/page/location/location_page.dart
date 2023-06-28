import 'package:flutter/material.dart';
import 'package:whoru/src/page/appbar/appbar.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      appBar: MyAppBar(),
        body: Center(
        child: Text(
          'This is the Location page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      
    );
  }

}

