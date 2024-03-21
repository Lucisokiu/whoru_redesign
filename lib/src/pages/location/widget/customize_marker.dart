import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

import '../../../model/UserModel.dart';

class CustomizeMarker extends StatelessWidget {
  LatLng latLng;
  UserModel user;
  CustomizeMarker({super.key, required this.latLng, required this.user});

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: latLng,
          width: 10.h,
          height: 10.w,
          builder: (context) {
            return CircleAvatar(
              backgroundImage: NetworkImage(
                user.avt,
              ),
            );
          },
        ),
      ],
    );
  }
}
