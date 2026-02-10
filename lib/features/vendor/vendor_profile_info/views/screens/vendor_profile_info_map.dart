import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/vendor/vendor_profile_info/views/controller/vendor_profile_info_map_controller.dart';

// ignore: must_be_immutable
class VendorProfileInfoMap extends StatefulWidget {
  VendorProfileInfoMap({super.key});

  VendorProfileInfoMapController controller = Get.put(
    VendorProfileInfoMapController(),
  );

  @override
  State<VendorProfileInfoMap> createState() => _VendorProfileInfoMapState();
}

class _VendorProfileInfoMapState extends State<VendorProfileInfoMap> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              onMapCreated: widget.controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target:
                    widget.controller.selectedPosition ??
                    widget.controller.shopLocation,
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
              markers: widget.controller.markers.toSet(),
              onLongPress: widget.controller.handleTap,
            );
          }),

          SafeArea(
            child: TypeAheadField(
              controller: _searchController,
              builder: (context, controller, focusNode) {
                return Row(
                  children: [
                    10.horizontalSpace,
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              offset: const Offset(0, 0),
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
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
                              color: AppColors.bodyDarkGray,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) =>
                              widget.controller.getPlaceSuggestions(value),
                        ),
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 15.w, vertical: 10.h);
              },
              suggestionsCallback: (pattern) async {
                return await widget.controller.getPlaceSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(suggestion['description']),
                );
              },
              onSelected: (suggestion) async {
                _searchController.text = suggestion['description'];
                LatLng pos = await widget.controller.getPlaceLatLng(
                  suggestion['place_id'],
                );

                widget.controller.mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(pos, 15),
                );
                widget.controller.addMarker(
                  pos,
                  title: suggestion['description'],
                );
              },
            ),
          ),

          Positioned(
            bottom: 40.h,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Color(0xFF1973E8),
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    offset: const Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
              // alignment: Alignment.center ,
              child: IconButton(
                onPressed: () => widget.controller.getCurrentLocation(),
                icon: Icon(Icons.my_location, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            bottom: 110.h,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Color(0xFF1973E8),
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    offset: const Offset(0, 0),
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
              // alignment: Alignment.center ,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.check, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
