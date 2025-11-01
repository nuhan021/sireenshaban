import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class VendorProfileInfoMap extends StatefulWidget {
  const VendorProfileInfoMap({super.key});

  @override
  State<VendorProfileInfoMap> createState() => _VendorProfileInfoMapState();
}

class _VendorProfileInfoMapState extends State<VendorProfileInfoMap> {
  final TextEditingController _searchController = TextEditingController();
  final String _googleApiKey = "AIzaSyA22IxMllRCaf9DcNTmyjKPcHpY5okWfhc";

  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLng? _selectedPosition;
  final LatLng _shopLocation = const LatLng(
    40.74003379333115,
    -73.99088234777156,
  );

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("tapped_location"),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: "Selected Location",
            snippet: "${tappedPoint.latitude}, ${tappedPoint.longitude}",
          ),
        ),
      );
      _selectedPosition = tappedPoint;
    });
  }

  Future<List<Map<String, dynamic>>> _getPlaceSuggestions(String input) async {
    if (input.isEmpty) return [];

    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_googleApiKey&components=country:bd";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List;
      return predictions
          .map((p) => {
        'description': p['description'],
        'place_id': p['place_id'],
      })
          .toList();
    } else {
      throw Exception("Failed to fetch suggestions");
    }
  }

  Future<LatLng> _getPlaceLatLng(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception("Failed to fetch place details");
    }
  }

  void _addMarker(LatLng position, {String? title}) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: title ?? "Custom Marker"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _shopLocation,
              zoom: 12.0,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false, // remove + / - buttons
            compassEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true, // allows pinch zoom
            scrollGesturesEnabled: true, // allows moving map
            rotateGesturesEnabled: true, // allows rotation
            tiltGesturesEnabled: true, // allows tilt with two fingers
            markers: _markers,
            onLongPress: _handleTap,
          ),

          SafeArea(
            child: TypeAheadField(
              controller: _searchController,
            builder: (context, controller, focusNode) {
              return Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search location",
                        hintStyle: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.bodyDarkGray
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryInfoMediumGray,
                            width: 1
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.secondaryInfoMediumGray,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.secondaryInfoMediumGray,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) => _getPlaceSuggestions(value),
                    ).paddingOnly(right: 20.w),
                  )
                ],
              );
            },
              suggestionsCallback: (pattern) async {
                return await _getPlaceSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(suggestion['description']),
                );
              },
              onSelected: (suggestion) async {
                _searchController.text = suggestion['description'];
                LatLng pos = await _getPlaceLatLng(suggestion['place_id']);
                _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(pos, 15),
                );
                _addMarker(pos, title: suggestion['description']);
              },
            ),
          ),
        ],
      ),
    );
  }
}
