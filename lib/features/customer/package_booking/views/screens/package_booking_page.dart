import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/booking_app_bar.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/location_card.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/reviews.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/thumbnail_image.dart';

import '../../../../../core/utils/constants/colors.dart';

class PackageBookingPage extends StatelessWidget {
  const PackageBookingPage({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        
            // title and price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 7.w),
                      decoration: BoxDecoration(
                          color: Color(0xFFDDE1ED),
                          borderRadius: BorderRadius.circular(12.r)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "120/per event",
                        style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDeepBlueNormal
                        ),
                      ),
                    )
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

                // reviews
                Reviews(),
                
                40.verticalSpace,
                
                // book now button
                CustomPrimaryButton(text: 'Book Now', color: AppColors.primaryDeepBlueNormal, onPressed: (){},),

                20.verticalSpace,

              ],
            ).paddingSymmetric(horizontal: 20.w)
          ],
        ),
      ),
    );
  }
}
