import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/booking_app_bar.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/thumbnail_image.dart';

class PackageBookingPage extends StatelessWidget {
  const PackageBookingPage({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: BookingAppBar(),
      ),

      body: Column(
        children: [
          // thumbnail image
          ThumbnailImage(image: image,),

          40.verticalSpace,


        ],
      ),
    );
  }
}
