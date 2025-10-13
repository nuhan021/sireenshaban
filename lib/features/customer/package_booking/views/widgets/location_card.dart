import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/package_booking/views/screens/map_screen.dart';
import '../../../../../core/utils/constants/colors.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  late GoogleMapController _mapController;
  final LatLng _shopLocation = const LatLng(40.74003379333115,-73.99088234777156);

  // @override
  // void initState() {
  //   super.initState();
  //   _getCurrentLocation();
  // }
  //
  // Future<void> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Check if GPS is enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return;
  //   }
  //
  //   // Check permission
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) return;
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     return;
  //   }
  //
  //   // Get location
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //   setState(() {
  //     _center = LatLng(position.latitude, position.longitude);
  //   });
  //
  //   // Move camera to current location
  //   _mapController.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(target: _center, zoom: 16),
  //     ),
  //   );
  // }
  //
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location",
          style: getTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.bodyDarkGray,
          ),
        ),
        12.verticalSpace,

        Row(
          children: [
            Icon(Icons.location_on_outlined,
                color: AppColors.secondaryTealNormal, size: 21.h),
            8.horizontalSpace,
            Text(
              'Current Location',
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryTealNormal,
              ),
            ),
          ],
        ),

        8.verticalSpace,
        Container(
          height: 200.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFD1D3D8)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _shopLocation, zoom: 12.0),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false, // remove + / - buttons
              compassEnabled: true,
              mapType: MapType.normal,
              // zoomGesturesEnabled: true, // allows pinch zoom
              // scrollGesturesEnabled: true, // allows moving map
              // rotateGesturesEnabled: true, // allows rotation
              // tiltGesturesEnabled: true, // allows tilt with two fingers
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
          ),
        ),

        TextButton(onPressed: () => AppHelperFunctions.navigateToScreen(context, MapScreen()), child: Text(
          'View Map',
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.accentNormal,
          ),
        ))
      ],
    );
  }
}
