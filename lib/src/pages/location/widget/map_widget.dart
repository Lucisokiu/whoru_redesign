import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:whoru/src/model/User.dart';
import 'package:whoru/src/pages/location/widget/customize_marker.dart';
import 'package:whoru/src/service/location_service.dart';

class MapWidget extends StatefulWidget {
  final String? typeMap; // Sử dụng nullable type

  const MapWidget({Key? key, this.typeMap}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

  UserModel user = UserModel(
    id: 1,
    fullName: 'LuciSoKiu',
    avt: 'https://avatars.githubusercontent.com/u/95356357?v=4',
    background: 'https://avatars.githubusercontent.com/u/95356357?v=4',
    description: 'A software developer',
    work: 'Software Company',
    study: 'University XYZ',
  );
class _MapWidgetState extends State<MapWidget> {
  LocationData? _userLocation;
  LocationService? locationService;
  late LocationData userLocation;
  void CurrentLocation() async {
    await locationService!.getLocation().then((value) {
      if (mounted) {
        setState(() {
          _userLocation = value;
        });
      } else {
        _userLocation = value;
      }
    });
    locationService!.location.onLocationChanged.listen((event) {
      if (mounted) {
        setState(() {
          _userLocation = event;
        });
      } else {
        _userLocation = event;
      }
    });
  }

  @override
  void initState() {
    locationService = LocationService();
    CurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _userLocation == null
          ? Center(
              child: Text("Loading"),
            )
          : FlutterMap(
              options: MapOptions(
                maxZoom: 18,
                                minZoom: 16.0,

                  center: LatLng(
                      _userLocation!.latitude!, _userLocation!.longitude!),
                  zoom: 17.0),
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
                CustomizeMarker(
                  latLng: const LatLng(10.849577683349953, 106.77095389939772),
                  user: user,
                ),
                CustomizeMarker(
                  latLng: const LatLng(10.851011968630182, 106.76874281365166),
                  user: user,
                ),
                CustomizeMarker(
                  latLng: LatLng(
                      _userLocation!.latitude!, _userLocation!.longitude!),
                  user: user,
                ),
              ],
            ),
    );
  }
}
