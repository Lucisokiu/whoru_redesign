import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whoru/src/model/locationModels.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:whoru/src/model/locationModels.dart';
import 'package:whoru/src/pages/location/widget/markdown_map.dart';
import 'package:whoru/src/service/location_service.dart';

class MapStateWidgetState extends StatefulWidget {
  // const _MapStateWidgetState({this._userLocation});
  const MapStateWidgetState({super.key});

  @override
  State<MapStateWidgetState> createState() => MapStateWidgetStateState();
}

class MapStateWidgetStateState extends State<MapStateWidgetState> {
  @override
  Widget build(BuildContext context) {
    var locationService = LocationService();
    // print(getLocation);
    return Container(
      child: StreamProvider<UserLocation>(
        create: (context) => locationService.locationStream,
        initialData:  UserLocation(),
        child: MarkDownMapState(),
      ),
    );
  }
}

