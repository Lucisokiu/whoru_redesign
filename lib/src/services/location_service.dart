import 'dart:async';
import 'package:location/location.dart';
import 'package:whoru/src/models/location_models.dart';
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/utils/shared_pref/iduser.dart';

import '../socket/web_socket_service.dart';

class LocationService {
  late LocationData _userLocation;
  var location = Location();
  WebSocketService webSocketService = WebSocketService();

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();
  Stream<UserLocation> get locationStream => _locationController.stream;
  int? idUser;
  LocationService();
  late Timer _timer;
  void handleLocationService() {}

  void sendLocation() {
    location.requestPermission().then(
      (permissionStatus) {
        if (permissionStatus == PermissionStatus.granted) {
          location.onLocationChanged.listen(
            (locationData) {
              webSocketService.sendMessageSocket("SendLocation",
                  [idUser, locationData.longitude!, locationData.latitude!]);

              _locationController.add(
                UserLocation(
                  latitude: locationData.latitude!,
                  longitude: locationData.longitude!,
                  userId: localIdUser,
                  avt: localUser.avt,
                    name: localUser.fullName
                ),
              );
            },
          );
          _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
            webSocketService.sendMessageSocket("getNearestUsers", [idUser]);
          });
        }
      },
    );
  }

  List<UserLocation> receivedListLocation() {
    final a =webSocketService.listenLocation();
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
    _timer.cancel();
  }
}
