import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/model/service_request_model.dart';
import 'package:sireenshaban/features/vendor/vendor_booking_request/views/screens/vendor_booking_request_details_screen.dart';

class BookingRequestCard extends StatelessWidget {
  const BookingRequestCard({super.key, this.request});

  final ServiceRequestListItem? request;

  @override
  Widget build(BuildContext context) {
    final DateTime? requestDate = request?.serviceDatetime;
    final String formattedDate = requestDate == null
        ? "-"
        : AppHelperFunctions.getFormattedDate(
            requestDate,
            format: "dd-MM-yyyy",
          );
    final String formattedTime = requestDate == null
        ? "-"
        : AppHelperFunctions.getFormattedDate(requestDate, format: "hh:mm a");

    final String? avatarUrl = request?.customer.image;

    return ListTile(
      onTap: () {
        if (request == null) {
          return;
        }
        AppHelperFunctions.navigateToScreen(
          context,
          VendorBookingRequestDetailsScreen(
            requestId: request!.serviceRequestId,
          ),
        );
      },
      tileColor: AppColors.cardBackgroundSoftGray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 25.r,
        backgroundImage: NetworkImage(
          avatarUrl?.isNotEmpty == true
              ? avatarUrl!
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5Bxsx92a-2hFCDdkVGybmsqN3S6MzMvNRc_qhM_ZoHIZN9Zj-msVenZkbFj369ZVYxPU&usqp=CAU',
        ),
      ),

      title: Text(
        request?.customer.firstName ?? "No Name",
        style: getTextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.bodyDarkGray,
        ),
      ),

      subtitle: Text(
        "$formattedDate\nAt - $formattedTime",
        style: getTextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.bodyDarkGray,
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
            color: AppColors.cardBackgroundSoftGray,
          ),
        ),
      ),
    );
  }
}
