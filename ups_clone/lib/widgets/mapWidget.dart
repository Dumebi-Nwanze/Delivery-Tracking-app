import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  MapWidget({
    Key? key,
    required this.lat,
    required this.long,
    required this.address,
    required this.size,
  }) : super(key: key);
  double lat;
  double long;
  String address;
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(lat, long),
            zoom: 16.0,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: address,
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ),
            MarkerLayerWidget(
                options: MarkerLayerOptions(markers: [
              Marker(
                point: LatLng(lat, long),
                builder: (context) => const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30.0,
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
