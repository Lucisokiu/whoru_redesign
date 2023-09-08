import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whoru/src/model/locationModels.dart';
import 'package:whoru/src/pages/appbar/appbar.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
      var userLocation = Provider.of<UserLocation>(context);

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
                "Find Current Location: ${userLocation.latitude} and ${userLocation.longitude}" ,
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {

              },
            )
          ],
        ),
      ),
    );
  }
}

