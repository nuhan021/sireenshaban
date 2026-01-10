import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/community_event_booking/controller/event_controller.dart';
import 'package:sireenshaban/features/customer/community_event_booking/views/widgets/event_schedul.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/location_card_2.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/custom_primary_button.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/constants/image_path.dart';
import '../../../confirm_booking/views/widgets/booking_summary.dart';
import '../../../confirm_booking/views/widgets/package_booking_payment_method.dart';
import '../../../home/model/eventModel.dart';
import '../../../package_booking/views/widgets/booking_app_bar.dart';
import '../../../package_booking/views/widgets/thumbnail_image.dart';

class CommunityEventBookingScreen extends StatefulWidget {
  CommunityEventBookingScreen({
    super.key,
    required this.image,
    required this.title,
    required this.id,
    this.isFromVendor = false,
  });

  final int id;
  final String image;
  final String title;
  final bool? isFromVendor;

  final HomeController homeController = Get.find<HomeController>();
  final EventController eventController = Get.put(EventController());

  @override
  State<CommunityEventBookingScreen> createState() =>
      _CommunityEventBookingScreenState();
}

class _CommunityEventBookingScreenState
    extends State<CommunityEventBookingScreen> {
  late Datum data;

  String? role = StorageService.role;

  @override
  void initState() {
    super.initState();
    data = widget.homeController.communityEvents.value!.data.firstWhere(
      (element) => element.id == widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLoggerHelper.info("The is from vendor: ${widget.isFromVendor}");
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
            ThumbnailImage(image: widget.image, rating: 5, reviews: 5),

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
                        data.title,
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
                        "${data.ticketPrice}/per event",
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
                  data.description,
                  textAlign: TextAlign.justify,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryInfoMediumGrayNormal,
                  ),
                ),

                20.verticalSpace,

                // location
                LocationCard2(data: data),

                20.verticalSpace,

                // event schedul
                EventSchedul(
                  date: data.eventDate,
                  time: data.eventTime,
                  price: data.ticketPrice,
                  isFromVendor: role == Vendor ? true : false,
                ),

                20.verticalSpace,

                // contact info
                if (widget.isFromVendor == false)
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
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Image.asset(IconPath.call, height: 24.h),
                          // ),
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
                Obx(() {
                  return BookingSummary(
                    price: widget.eventController.stringPrice.value,
                  );
                }),

                30.verticalSpace,

                // confirm booking button
                if (widget.isFromVendor == false)
                  Obx(() {
                    if (widget.eventController.isEventLoading.value) {
                      return CustomLoading();
                    }
                    return CustomPrimaryButton(
                      text: "Confirm Booking & Pay",
                      textColor: AppColors.cardBackgroundSoftGray,
                      color: AppColors.primaryDeepBlueNormal,
                      onPressed: () {
                        widget.eventController.confirmBooking(data);
                      },
                    );
                  }),

                20.verticalSpace,

                if (widget.isFromVendor == false)
                  // cancel button
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentNormal,
                        ),
                      ),
                    ),
                  ),

                20.verticalSpace,
              ],
            ).paddingSymmetric(horizontal: 20.w),
          ],
        ),
      ),
    );
  }
}
