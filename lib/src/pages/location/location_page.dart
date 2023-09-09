import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whoru/src/model/locationModels.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';
import 'package:whoru/src/pages/location/widget/map_widget.dart';
import 'package:whoru/src/service/location_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(),
            Text(
              "Location Page",
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors
                          .blueAccent; // Color when the button is pressed
                    }
                    return null; // Color for other states (default or focused, etc.)
                  },
                ),
              ),
              child: Text(
                "Find Current Location",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                // MapStateWidgetState();
              },
            ),
            MapStateWidgetState(),
          ],
        ),
      ),
    );
  }
}
