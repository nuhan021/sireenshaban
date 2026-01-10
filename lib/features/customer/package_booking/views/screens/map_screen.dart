import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.position});

  final LatLng position;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late final LatLng _shopLocation = widget.position;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _shopLocation,
          zoom: 12.0,
        ),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false, // remove + / - buttons
        compassEnabled: true,
        mapType: MapType.hybrid,
        zoomGesturesEnabled: true, // allows pinch zoom
        scrollGesturesEnabled: true, // allows moving map
        rotateGesturesEnabled: true, // allows rotation
        tiltGesturesEnabled: true, // allows tilt with two fingers
        markers: {
          Marker(
            markerId: const MarkerId("shop_marker"),
            position: _shopLocation,
            infoWindow: const InfoWindow(
              title: "My Shop",
              snippet: "123 Broadway, New York",
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed, // Optional: change color
            ),
          ),
        },
      ),
    );
  }
}
