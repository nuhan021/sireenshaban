import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:sireenshaban/features/vendor/vendor_setup/controller/vendor_setup_screen_controller.dart';


class VendorProfileInfoMapController extends GetxController {
  final String googleApiKey = "AIzaSyA22IxMllRCaf9DcNTmyjKPcHpY5okWfhc";

  late GoogleMapController mapController;

  RxSet<Marker> markers = <Marker>{}.obs;

  LatLng? selectedPosition;

  final LatLng shopLocation = const LatLng(
    40.74003379333115,
    -73.99088234777156,
  );

  void onMapCreated(GoogleMapController googleMapController) {
    mapController = googleMapController;
  }

  void handleTap(LatLng tappedPoint) async {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("tapped_location"),
        position: tappedPoint,
        infoWindow: InfoWindow(
          title: "Selected Location",
          snippet: "${tappedPoint.latitude}, ${tappedPoint.longitude}",
        ),
      ),
    );
    await getLocationName(tappedPoint);
    selectedPosition = tappedPoint;
  }

  Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) async {
    if (input.isEmpty) return [];

    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List;
      return predictions
          .map(
            (p) => {'description': p['description'], 'place_id': p['place_id']},
          )
          .toList();
    } else {
      throw Exception("Failed to fetch suggestions");
    }
  }

  Future<void> getLocationName(LatLng position) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Get.snackbar("error", "Failed to fetch address");
    }

    final data = json.decode(response.body);
    final results = data["results"] as List;

    final components = results.first["address_components"] as List;

    String getComponent(String type) {
      final comp = components.firstWhere(
        (c) => (c["types"] as List).contains(type),
        orElse: () => null,
      );
      return comp != null ? comp["long_name"] : "";
    }

    final address = {
      "country": getComponent("country"),
      "city": getComponent("locality").isNotEmpty
          ? getComponent("locality")
          : getComponent("administrative_area_level_2"),
      "road": getComponent("route"),
    };

    final VendorSetupScreenController vendorSetupScreenController1st =
        Get.find<VendorSetupScreenController>();
    vendorSetupScreenController1st.addLocation(
      address['country']!,
      address['city']!,
      address['road']!,
    );
    vendorSetupScreenController1st.shopLocation = LatLng(
      position.latitude,
      position.longitude,
    );
  }

  Future<LatLng> getPlaceLatLng(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      await getLocationName(LatLng(location['lat'], location['lng']));
      return LatLng(location['lat'], location['lng']);
    } else {
      throw Exception("Failed to fetch place details");
    }
  }

  void addMarker(LatLng position, {String? title}) {
    markers.clear();
    markers.add(
      Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: title ?? "Custom Marker"),
      ),
    );

    selectedPosition = position;
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'Location Services Disabled',
        'Please enable location services to use this feature.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return Future.error('Location services are disabled.');
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          'Location Permission Denied',
          'Please grant location permission to use this feature.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Location Permission permanently Denied',
        'Location permissions are permanently denied, cannot request.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return Future.error(
        'Location permissions are permanently denied, cannot request.',
      );
    }

    // Get the current location
    final myPosition = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy:
            LocationAccuracy.bestForNavigation, // you can use .high or .medium
        distanceFilter:
            5, // optional: minimum distance (in meters) before update
      ),
    );

    selectedPosition = LatLng(myPosition.latitude, myPosition.longitude);
    await getLocationName(selectedPosition!);
    markers.clear();
    addMarker(selectedPosition!);

    // ✅ Move map to current position
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(selectedPosition!, 15),
    );

    print(
      "📍 Current Location: ${selectedPosition!.latitude}, ${selectedPosition!.longitude}",
    );
  }
}
