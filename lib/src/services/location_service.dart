
import 'dart:async';
import 'package:location/location.dart';
import 'package:whoru/src/models/location_models.dart';

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
        });
      }
    });
  }

  Future<LocationData> getLocation() async {
    try {
      _userLocation = await location.getLocation();
    } catch (e) {
      print('Could not to get Location: $e');
    }
    return _userLocation;
  }
}
