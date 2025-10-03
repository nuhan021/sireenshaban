import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/constants/icon_path.dart';

import '../../../core/utils/constants/image_path.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.onboardingImage),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'The Community list',
              style: getTextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
            ),

            SizedBox(
              height: 13.h,
            ),

            Text(
              'Connecting you with trusted local business for seamless booking',
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ).paddingSymmetric(horizontal: 50.w),

            SizedBox(
              height: 40.h,
            ),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [

               Container(
                 height: 44.h,
                 width: 44.w,
                 padding: EdgeInsets.all(7.w),
                 decoration: BoxDecoration(
                     color: AppColors.primaryDeepBlue.withOpacity(0.2),
                     borderRadius: BorderRadius.circular(100.r)
                 ),
                 child: Image.asset(IconPath.distance),
               ),

               SizedBox(width: 31.w,),

               Container(
                 height: 44.h,
                 width: 44.w,
                 padding: EdgeInsets.all(7.w),
                 decoration: BoxDecoration(
                     color: AppColors.primaryDeepBlue.withOpacity(0.2),
                     borderRadius: BorderRadius.circular(100.r)
                 ),
                 child: Image.asset(IconPath.calenderToday),
               ),

               SizedBox(width: 31.w,),

               Container(
                 height: 44.h,
                 width: 44.w,
                 padding: EdgeInsets.all(7.w),
                 decoration: BoxDecoration(
                     color: AppColors.primaryDeepBlue.withOpacity(0.2),
                     borderRadius: BorderRadius.circular(100.r)
                 ),
                 child: Image.asset(IconPath.star),
               )
             ],
           ),

            SizedBox(
              height: 40.h,
            ),

            Text(
              'Discover Local',
              style: getTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),
            Text(
              'Find trusted businesses',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),
            ),

            SizedBox(height: 20.h,),

            Text(
              'Book Instantly',
              style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),

            Text(
              'Schedule with ease',
              style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),



            SizedBox(height: 20.h,),

            Text(
              'Build Trust',
              style: getTextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),

            Text(
              'Read reviews & connect',
              style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ]
        ),
      )
    );
  }
}
