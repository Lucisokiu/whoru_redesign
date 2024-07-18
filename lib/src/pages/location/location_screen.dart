import 'package:flutter/material.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/location/widget/map_widget.dart';

import '../../services/location_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? typeMap;
  @override
  void initState() {
    typeMap = 'Street Map';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: const MyAppBar()),
          Expanded(
              child: Stack(
            children: [
              MapWidget(typeMap: typeMap),
              Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, // Màu văn bản
                            backgroundColor: Colors.blue, // Màu nền
                          ),
                          onPressed: () {
                            setState(() {
                              typeMap = 'Street Map';
                            });
                          },
                          child: const Text('Street Map'))),
                  Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, // Màu văn bản
                            backgroundColor: Colors.blue, // Màu nền
                          ),
                          onPressed: () {
                            setState(() {
                              typeMap = 'Real Map';
                            });
                          },
                          child: const Text('Real Map'))),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
