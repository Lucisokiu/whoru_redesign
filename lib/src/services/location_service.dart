import 'dart:async';
import 'package:location/location.dart';
import 'package:whoru/src/models/location_models.dart';
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/utils/shared_pref/iduser.dart';

import '../socket/web_socket_service.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  LocationService._internal();

  late LocationData _userLocation;
  var location = Location();
  WebSocketService webSocketService = WebSocketService();

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;
  int? idUser;
  Timer? _timer;
  void handleLocationService() {}

  void sendLocation() {
    location.requestPermission().then(
      (permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          location.onLocationChanged.listen(
            (locationData) {
              _locationController.add(
                UserLocation(
                    latitude: locationData.latitude!,
                    longitude: locationData.longitude!,
                    userId: localIdUser,
                    avt: localUser.avt,
                    name: localUser.fullName),
              );
            },
          );
          if (_timer == null || !_timer!.isActive) {
            _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
              webSocketService.sendMessageSocket("getNearestUsers", [idUser]);
            });
          }
        }
      },
    );
  }

  List<UserLocation> receivedListLocation() {
    return webSocketService.listenLocation();
  }

  getID() async {
    idUser = await getIdUser();
    print(idUser);
  }

  Future<LocationData> getLocation() async {
    try {
      _userLocation = await location.getLocation();
    } catch (e) {
      print('Could not to get Location: $e');
    }
    return _userLocation;
  }

  void closeLocation() {
    print("closeLocation");
    _timer?.cancel();
    _timer = null;
  }
}
