import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';

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
                _displayCurrentLocation();
              },
            )
          ],
        ),
      ),
    );
  }
}

void _displayCurrentLocation() async {
  // final _location = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

}
