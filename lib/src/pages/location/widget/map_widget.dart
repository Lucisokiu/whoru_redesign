import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:whoru/src/pages/location/widget/customize_marker.dart';
import 'package:whoru/src/service/location_service.dart';

class MapWidget extends StatefulWidget {
  final String? typeMap; // Sử dụng nullable type

  const MapWidget({Key? key, this.typeMap}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LocationData? _userLocation;
  LocationService locationService = LocationService();
  late LocationData userLocation;

  Future<LocationData> getLocation() async {
    return await Location().getLocation();
  }

  void CurrentLocation() async {
    await locationService.getLocation().then((value) {
      if (mounted) {
        setState(() {
          _userLocation = value;
        });
      } else {
        _userLocation = value;
      }
    });
    if (mounted) {
      locationService.location.onLocationChanged.listen((event) {
        setState(() {
          _userLocation = event;
        });
      });
    }
  }

  @override
  void initState() {
    CurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.typeMap);
    print('latitude: $_userLocation');
    print('longitude: $_userLocation');

    return Container(
      child: _userLocation == null
          ? Center(
              child: Text("Loading"),
            )
          : FlutterMap(
              options: MapOptions(
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
                CustomizeMarker(
                  latLng: LatLng(
                      _userLocation!.latitude!, _userLocation!.longitude!),
                ),
                CustomizeMarker(
                    latLng:
                        const LatLng(10.845128535877942, 106.79611632216462)),
                CustomizeMarker(
                    latLng:
                        const LatLng(10.851011968630182, 106.76874281365166)),
              ],
            ),
    );
  }
}
