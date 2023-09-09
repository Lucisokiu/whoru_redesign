import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:whoru/src/model/locationModels.dart';

class MarkDownMapState extends StatefulWidget {
    final UserLocation? userLocation;

  const MarkDownMapState({super.key, this.userLocation});

  @override
  State<MarkDownMapState> createState() => MarkDownMapStateState();
}

class MarkDownMapStateState extends State<MarkDownMapState> {

  void map_launcher(latitude,longitude) async {
    final availableMap = await MapLauncher.installedMaps;
    availableMap.forEach((element) {
      print(element.icon);
      print(element.mapName);
      print(element.mapType);
    });
    print('latitude: ${latitude}');
    print('longitude: ${longitude}'); 
    if(latitude != null && longitude != null ){
      await availableMap.first.showMarker(
        coords: Coords(latitude, longitude),
        title: 'title',
      );
    };

    }



  @override
  Widget build(BuildContext context) {
      var userLocation = Provider.of<UserLocation>(context);
    map_launcher(userLocation.latitude, userLocation.longitude);


    return Container();

    
  }
}
