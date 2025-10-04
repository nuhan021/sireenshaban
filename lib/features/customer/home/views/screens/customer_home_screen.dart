import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';
import 'package:sireenshaban/core/utils/constants/image_path.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../core/utils/constants/colors.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              36.verticalSpace,
          
              // search bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 47.h,
                      decoration: BoxDecoration(
                        color: AppColors.softGray,
                        border: Border.all(color: AppColors.deepBlueLight),
                        borderRadius: BorderRadius.circular(8.r),
          
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromRGBO(13, 10, 44, 0.06),
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          controller: searchController,
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          cursorColor: AppColors.primaryDeepBlueNormal,
                          decoration: InputDecoration(
                            hintText: "Search venues & services... ",
                            hintStyle: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryInfoMediumGray
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.mic_none_outlined,
                              color: AppColors.secondaryInfoMediumGray,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          
                  10.horizontalSpace,
          
                  Container(
                    height: 47.h,
                    width: 47.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepBlueNormal,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(IconPath.sliders, height: 20.h),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20.w),
          
              40.verticalSpace,
          
              // banner
              SizedBox(
                height: 230.h,
                width: double.maxFinite,
                child: Image.asset(ImagePath.bannerImg, fit: BoxFit.cover,),
              ),

              40.verticalSpace,

              // services
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Additional Services',
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryInfoMediumGrayDarker
                    ),
                  ),


                  Row(
                    children: [
                      Text(
                        'Explore All',
                        style: getTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryDeepBlueNormal
                        ),
                      ),

                      8.horizontalSpace,

                      Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryDeepBlueNormal,)
                    ],
                  )
                ],
              ).paddingSymmetric(horizontal: 20.w),

              26.verticalSpace,

              // additional services
              Container(
                color: Colors.red,
                height: 220.h,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // 1st row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 85.h,
                                width: 104.w,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF), // Card Background Soft Gray
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFE9EAEC), // Secondary Info Medium Gray Light Hover
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(0, 3),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(ImagePath.doctorImg),
                              ),
                              7.horizontalSpace,
                              Text(
                                  'Doctors',
                                  style: getTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryInfoMediumGrayDarker
                                  )
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 85.h,
                                width: 104.w,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF), // Card Background Soft Gray
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFE9EAEC), // Secondary Info Medium Gray Light Hover
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(0, 3),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(ImagePath.salonImg),
                              ),
                              7.horizontalSpace,
                              Text(
                                  'Salon',
                                  style: getTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryInfoMediumGrayDarker
                                  )
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 85.h,
                                width: 104.w,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF), // Card Background Soft Gray
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFE9EAEC), // Secondary Info Medium Gray Light Hover
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.06),
                                      offset: const Offset(0, 3),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: Image.asset(ImagePath.restaurantImg),
                              ),
                              7.horizontalSpace,
                              Text(
                                  'Restaurants',
                                  style: getTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryInfoMediumGrayDarker
                                  )
                              )
                            ],
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 20.w),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
