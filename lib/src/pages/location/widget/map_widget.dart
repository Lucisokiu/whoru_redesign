import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:whoru/src/api/user_info.dart';
import 'package:whoru/src/pages/app.dart';
import 'package:whoru/src/pages/location/widget/customize_marker.dart';
import 'package:whoru/src/services/location_service.dart';
import 'package:whoru/src/utils/shared_pref/iduser.dart';

import '../../../models/user_model.dart';
import 'card_user.dart';

class MapWidget extends StatefulWidget {
  final String? typeMap; // Sử dụng nullable type

  const MapWidget({Key? key, this.typeMap}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // UserModel user = UserModel(
  //   id: 1,
  //   fullName: 'LuciSoKiu',
  //   avt: 'https://avatars.githubusercontent.com/u/95356357?v=4',
  //   background: 'https://avatars.githubusercontent.com/u/95356357?v=4',
  //   description: 'A software developer',
  //   work: 'Software Company',
  //   study: 'University XYZ',
  //   followerCount: 1,
  //   followingCount: 1,
  //   isFollow: true,
  // );
  LocationData? _userLocation;
  LocationService locationService = LocationService();
  UserModel? user;

  void getUser() async {
    int? id = await getIdUser();
    user = await getInfoUserById(id!);
  }

  void currentLocation() async {
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
    locationService.receivedLocation();
    currentLocation();
    getUser();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
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
                      center: LatLng(
                          _userLocation!.latitude!, _userLocation!.longitude!),
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
                    // CustomizeMarker(
                    //   latLng:
                    //       const LatLng(10.849577683349953, 106.77095389939772),
                    //   user: user!,
                    // ),
                    // CustomizeMarker(
                    //   latLng:
                    //       const LatLng(10.851011968630182, 106.76874281365166),
                    //   user: user!,
                    // ),
                    GestureDetector(
                      onTap: () {
                        cardUser(context, localUser);
                      },
                      child: CustomizeMarker(
                        latLng: LatLng(_userLocation!.latitude!,
                            _userLocation!.longitude!),
                        user: localUser,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
