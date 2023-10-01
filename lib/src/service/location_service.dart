import 'dart:async';
import 'package:location/location.dart';
import 'package:whoru/src/model/locationModels.dart';

class LocationService {
  late LocationData _userLocation;
  var location = Location();
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          _locationController.add(UserLocation(
              latitude: locationData.longitude!,
              longitude: locationData.longitude!,
              userId: 1));
          print(
              'The users location is: ${locationData.latitude}, ${locationData.longitude}');
        });
      }
    });
  }

  Future<LocationData> getLocation() async {
    try {
      _userLocation = await location.getLocation();
      print('Location is: $_userLocation');
    } catch (e) {
      print('Could not to get Location: $e');
    }
    return _userLocation;
  }
}
