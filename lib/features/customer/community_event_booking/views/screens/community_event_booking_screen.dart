import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/features/customer/community_event_booking/views/widgets/event_schedul.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../booking_confirmed/views/screens/booking_confirmed_screen.dart';
import '../../../confirm_booking/views/widgets/booking_summary.dart';
import '../../../confirm_booking/views/widgets/package_booking_payment_method.dart';
import '../../../package_booking/views/widgets/booking_app_bar.dart';
import '../../../package_booking/views/widgets/location_card.dart';
import '../../../package_booking/views/widgets/thumbnail_image.dart';

class CommunityEventBookingScreen extends StatelessWidget {
  const CommunityEventBookingScreen({super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF4F4F4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: BookingAppBar(),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // thumbnail image
            ThumbnailImage(image: image),

            30.verticalSpace,

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: getTextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.bodyDarkGray,
                        ),
                      ),
                    ),

                    Container(
                      height: 40.h,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 7.w,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFDDE1ED),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "120/per event",
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDeepBlueNormal,
                        ),
                      ),
                    ),
                  ],
                ),

                20.verticalSpace,

                // description title
                Text(
                  "Description",
                  style: getTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyDarkGray,
                  ),
                ),

                10.verticalSpace,

                // description
                Text(
                  "Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam. Augue etiam ornare eu velit ultrices pharetra. Velit fringilla tellus justo sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis vel amet faucibus mattis parturient.",
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryInfoMediumGrayNormal,
                  ),
                ),

                20.verticalSpace,

                // location
                LocationCard(),

                20.verticalSpace,

                // event schedul
                EventSchedul(),

                20.verticalSpace,

                // contact info
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundSoftGray,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    leading: Image.asset(ImagePath.personImg, height: 40.h),
                    title: Text(
                      "Contact Host",
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    subtitle: Text(
                      "Restaurant Manager",
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bodyDarkGray,
                      ),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(IconPath.message, height: 24.h),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(IconPath.call, height: 24.h),
                        ),
                      ],
                    ),
                  ),
                ),

                30.verticalSpace,

                // payment methods
                Text(
                  "Payment Methods",
                  style: getTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bodyDarkGray,
                  ),
                ).paddingSymmetric(horizontal: 10.w),

                20.verticalSpace,

                PackageBookingPaymentMethod(),

                20.verticalSpace,

                // booking summary
                BookingSummary(),

                30.verticalSpace,

                // confirm booking button
                CustomPrimaryButton(
                  text: "Confirm Booking & Pay \$120.60",
                  textColor: AppColors.cardBackgroundSoftGray,
                  color: AppColors.primaryDeepBlueNormal,
                  onPressed: () => AppHelperFunctions.navigateToScreen(context, BookingConfirmedScreen()),
                ),

                20.verticalSpace,

                // cancel button

                Align(
                  alignment: AlignmentGeometry.center,
                  child: TextButton(onPressed: () => Navigator.pop(context), child: Text(
                    'Cancel',
                    style: getTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accentNormal,
                    ),
                  )),
                ),

                20.verticalSpace

              ],
            ).paddingSymmetric(horizontal: 20.w)
          ],
        ),
      ),
    );
  }
}
