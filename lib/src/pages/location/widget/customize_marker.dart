import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:whoru/src/model/user.dart';

class CustomizeMarker extends StatelessWidget {
  LatLng latLng;
  CustomizeMarker({super.key, required this.latLng});

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: latLng,
          width: 80,
          height: 80,
          builder: (context) {
            return Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.location_history,
                    size: 50,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 33,
                    width: 33,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: Image.network(
                        user.avt,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}