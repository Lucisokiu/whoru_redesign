import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/pages/location/widget/customize_marker.dart';
import 'package:whoru/src/pages/splash/splash.dart';
import 'package:whoru/src/services/location_service.dart';
import 'package:whoru/src/utils/shared_pref/iduser.dart';

import '../../../models/location_models.dart';
import '../../../models/user_model.dart';
import '../../../socket/web_socket_service.dart';
import 'card_user.dart';

class MapWidget extends StatefulWidget {
  final String? typeMap; // Sử dụng nullable type

  const MapWidget({Key? key, this.typeMap}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LocationData? _userLocation;
  LocationService locationService = LocationService();
  UserModel? user;
  List<UserLocation> listLocation = [];
  late StreamSubscription<dynamic> messageSubscription;
  WebSocketService webSocketService = WebSocketService();
  String? note;

  Future<void> getUser() async {
    int? id = await getIdUser();
    user = await getInfoUserById(id!);
  }

  Future<void> currentLocation() async {
    await locationService.getLocation().then((value) {
      if (mounted) {
        setState(() {
          _userLocation = value;
        });
      } else {
        _userLocation = value;
      }
    });
    locationService.location.onLocationChanged.listen((event) {
      if (mounted) {
        setState(() {
          _userLocation = event;
        });
      } else {
        _userLocation = event;
      }
    });
  }

  void initialize() async {
    await locationService.getID();
    locationService.sendLocation();
    await currentLocation();
    await getUser();
    getListUser();
    note = await _loadNote();
    print(note);
    setState(() {});
  }

  getListUser() {
    messageSubscription = webSocketService.onMessage.listen((message) {
      if (message['type'] == 1 && message['target'] == 'Return_List_User') {
        List<dynamic> arguments = message['arguments'];
        listLocation.clear();
        if (arguments[0] == null) {
          return;
        } else {
          List<dynamic> argument = arguments[0];
          for (var arg in argument) {
            print(arg);
            UserLocation location = UserLocation.fromJson(arg);
            if (mounted) {
              setState(() {
                listLocation.add(location);
              });
            }
          }
        }
      }
    });
  }

  Future<String?> _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('note');
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    locationService.closeLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _userLocation == null && user == null
          ? const Center(
              child: Text("Loading"),
            )
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                      maxZoom: 18,
                      minZoom: 16,
                      center: LatLng(_userLocation?.latitude! ?? 0.0,
                          _userLocation?.longitude! ?? 0.0),
                      zoom: 17),
                  children: [
                    TileLayer(
                      urlTemplate: widget.typeMap == 'Real Map'
                          ? 'https://api.mapbox.com/styles/v1/lucisokiu/clmq96xu4009401nshmsl3i66/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibHVjaXNva2l1IiwiYSI6ImNsbXE2bHIybzAwZHAyaXBvcWtlaDFhZWMifQ.HZcOtMw4vsavjJ9JS_aVfg'
                          : 'https://api.mapbox.com/styles/v1/lucisokiu/clmq796yz022n01pb29x72pjq/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibHVjaXNva2l1IiwiYSI6ImNsbXE2bHIybzAwZHAyaXBvcWtlaDFhZWMifQ.HZcOtMw4vsavjJ9JS_aVfg',
                      additionalOptions: const {
                        'accesstoken':
                            'pk.eyJ1IjoibHVjaXNva2l1IiwiYSI6ImNsbXE2bHIybzAwZHAyaXBvcWtlaDFhZWMifQ.HZcOtMw4vsavjJ9JS_aVfg',
                        'id': 'mapbox.satellite'
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        cardUser(context, localUser, null);
                      },
                      child: CustomizeMarker(
                        latLng: LatLng(_userLocation?.latitude! ?? 0.0,
                            _userLocation?.longitude! ?? 0.0),
                        userId: localUser.id,
                        avt: localUser.avt,
                        note: note ?? '',
                      ),
                    ),
                    for (var i in listLocation)
                      GestureDetector(
                        onTap: () {
                          cardUser(context, null, i);
                        },
                        child: CustomizeMarker(
                          latLng: LatLng(i.latitude, i.longitude),
                          userId: i.userId,
                          avt: i.avt,
                          note: i.note ?? '',
                        ),
                      ),
                  ],
                ),
              ],
            ),
    );
  }
}
