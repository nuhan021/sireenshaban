import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/interest/controller/customer_interest_controller.dart';
import 'package:sireenshaban/features/customer/interest/views/widgets/customer_interest_card.dart';
import 'package:sireenshaban/routes/app_routes.dart';

import '../../../../../core/common/widgets/custom_primary_button.dart';

class CustomerInterestScreen extends StatelessWidget {
  CustomerInterestScreen({super.key});

  CustomerInterestController controller = Get.put(CustomerInterestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [

            30.verticalSpace,
            Text(
              "What’s on your self-care radar?",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDeepBlueNormal
              ),
            ),


            Text(
              "Select up to 5 categories you’re interested in, and we’ll show you personalized picks.",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyDarkGray
              ),
            ),

            40.verticalSpace,

            Expanded(
              child: GridView.builder(
                itemCount: controller.category.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 columns (3 items per row)
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: 0.9, // adjust height/width ratio
                ),

                itemBuilder: (context, index) {
                  final String image = controller.category[index].image;
                  final String role = controller.category[index].role;
                  return CustomerInterestCard(image: image, role: role, controller: controller,);
                },
              ),
            ),


            10.verticalSpace,


            CustomPrimaryButton(
              text: 'Continue',
              color: AppColors.primaryDeepBlueNormal,
              onPressed: () => Get.offNamed(AppRoute.customerBottomNavBar),
            ),

            20.verticalSpace,

          ],
        ).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
