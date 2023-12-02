import 'package:flutter/material.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/location/widget/map_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(typeMap: typeMap),
          Column(
            children: [
              const MyAppBar(),
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
      ),
    );
  }
}
