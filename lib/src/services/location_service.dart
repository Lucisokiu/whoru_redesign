import 'dart:async';
import 'package:location/location.dart';
import 'package:whoru/src/models/location_models.dart';
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
              // webSocketService.sendMessageSocket("SendLocation",
              //     [idUser, locationData.longitude!, locationData.latitude!]);

              _locationController.add(
                UserLocation(
                  latitude: locationData.latitude!,
                  longitude: locationData.longitude!,
                  userId: idUser,
                ),
              );
            },
          );
          _timer = Timer.periodic(Duration(seconds: 5), (timer) {
            print("_timer ${_timer.toString()}");

            webSocketService.sendMessageSocket("getNearestUsers", [idUser]);
          });
        }
      },
    );
  }

  void receivedLocation() {
    List a = webSocketService.listenLocation(idUser!);
    print(a);
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
