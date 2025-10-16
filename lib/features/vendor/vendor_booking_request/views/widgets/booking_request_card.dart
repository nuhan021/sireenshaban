import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/screens/vendor_booking_request_details_screen.dart';

class BookingRequestCard extends StatelessWidget {
  const BookingRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => AppHelperFunctions.navigateToScreen(context, VendorBookingRequestDetailsScreen()),
      tileColor: AppColors.cardBackgroundSoftGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),

      ),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 25.r,
        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5Bxsx92a-2hFCDdkVGybmsqN3S6MzMvNRc_qhM_ZoHIZN9Zj-msVenZkbFj369ZVYxPU&usqp=CAU'),
      ),

      title: Text(
        "Jain Fozi",
        style: getTextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.bodyDarkGray
        ),
      ),

      subtitle: Text(
        "15-12-2024\nAt - 07.50pm",
        style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.bodyDarkGray
        ),
      ),
      
      trailing: Container(
        height: 40.h,
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.primaryDeepBlueNormal,
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: AlignmentGeometry.center,
        child: Text(
          'View details',
          style: getTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.cardBackgroundSoftGray
          ),
        ),
      )
    );
  }
}
