import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/screens/confirm_booking_screen.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:sireenshaban/features/customer/home/model/packages_model.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/booking_app_bar.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/location_card.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/reviews.dart';
import 'package:sireenshaban/features/customer/package_booking/views/widgets/thumbnail_image.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../business_and_creative_services/views/screens/business_and_creative_services_screens.dart';
import '../../../home_and_maintenance_services/views/screens/home_and_maintenance_services_screens.dart';
import '../../../personal_care_and_education/views/screens/personal_care_and_education_screens.dart';

class PackageBookingPage extends StatefulWidget {
  const PackageBookingPage({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.group,
    required this.controller,
    this.isFromVendorScreen = false,
  });

  final int id;
  final String image;
  final String title;
  final HomeController controller;
  final ServicesGroup group;
  final bool isFromVendorScreen;

  @override
  State<PackageBookingPage> createState() => _PackageBookingPageState();
}

class _PackageBookingPageState extends State<PackageBookingPage> {

  final HomeController _homeController = Get.find<HomeController>();

  late Datum data;

  @override
  void initState() {
    super.initState();
    data = _homeController.packages.value!.data.firstWhere((e) {
      return e.id == widget.id;
    });
  }

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
            ThumbnailImage(image: data.image ?? '', rating: data.reviewsSumRating, reviews: data.reviews.length),

            30.verticalSpace,

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          switch (widget.group) {
                            case ServicesGroup.businessAndCreativeServices:
                              AppHelperFunctions.navigateToScreen(
                                context,
                                BusinessAndCreativeServicesScreens(
                                  image: widget.image,
                                  title: widget.title,
                                  controller: widget.controller,
                                  vendorId: data.vendorId,
                                  latitude: data.vendor.latitude is num
                                      ? (data.vendor.latitude as num).toDouble()
                                      : null,
                                  longitude: data.vendor.longitude is num
                                      ? (data.vendor.longitude as num)
                                          .toDouble()
                                      : null,
                                ),
                              );
                              break;
                            case ServicesGroup.personalCareAndEducation:
                              AppHelperFunctions.navigateToScreen(
                                context,
                                PersonalCareAndEducationScreens(
                                  image: widget.image,
                                  title: widget.title,
                                  controller: widget.controller,
                                ),
                              );

                            default:
                              AppHelperFunctions.navigateToScreen(
                                context,
                                HomeAndMaintenanceServicesScreens(
                                  image: widget.image,
                                  title: widget.title,
                                  controller: widget.controller,
                                ),
                              );
                          }
                        },
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bodyDarkGray,
                          ),
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
                        "${data.pricePerEvent}/per event",
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
                  data.description ?? '',
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
                Reviews(review: data.reviews,),

                40.verticalSpace,

                // book now button
                widget.isFromVendorScreen
                    ? SizedBox()
                    : CustomPrimaryButton(
                        text: 'Book Now',
                        color: AppColors.primaryDeepBlueNormal,
                        onPressed: () => AppHelperFunctions.navigateToScreen(
                          context,
                          ConfirmBookingScreen(data: data,),
                        ),
                      ),

                widget.isFromVendorScreen ? 0.verticalSpace : 20.verticalSpace,
              ],
            ).paddingSymmetric(horizontal: 20.w),
          ],
        ),
      ),
    );
  }
}
