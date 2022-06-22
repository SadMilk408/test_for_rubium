import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_for_rubium/data/models/random_api_model.dart';

class GeoMap extends StatefulWidget {
  final Coordinates coordinates;

  const GeoMap({Key? key, required this.coordinates}) : super(key: key);

  @override
  State<GeoMap> createState() => _GeoMapState();
}

class _GeoMapState extends State<GeoMap> {
  late MapController controller;

  @override
  void initState() {
    controller = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(double.parse(widget.coordinates.latitude!),
                        double.parse(widget.coordinates.longitude!)),
                    controller: controller,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                            width: 40.0,
                            height: 40.0,
                            point: LatLng(
                                double.parse(widget.coordinates.latitude!),
                                double.parse(widget.coordinates.longitude!)),
                            builder: (ctx) => const Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                  size: 36,
                                )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
