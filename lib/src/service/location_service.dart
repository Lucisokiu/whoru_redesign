import 'dart:async';
import 'dart:ui';
import 'package:location/location.dart';
import 'package:whoru/src/model/locationModels.dart';

class LocationService {
  late UserLocation _userLocation;
  var location = Location();
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null)
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

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _userLocation = UserLocation(
          latitude: userLocation.latitude!,
          longitude: userLocation.longitude!,
          userId: 1);
      print('Location is: $_userLocation');
    } catch (e) {
      print('Could not to get Location: $e');
    }
    return _userLocation;
  }
}
