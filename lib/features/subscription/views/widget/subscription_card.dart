import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

import '../../../controller/stripe_controller.dart';
import '../../controller/subscription_controller.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final double scale; // স্কেলিং এর জন্য

  SubscriptionCard({super.key, required this.plan, required this.scale});

  final StripeController stripeController = Get.find<StripeController>();

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale, // এখানে স্কেলিং ইফেক্ট হবে
      child: Container(
        height: 525.h,
        width: double.maxFinite,
        child: Container(
          height: 500.h,
          width: double.maxFinite,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: const Color(0xFFE9EBF3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 10),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.title,
                style: getTextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDeepBlueNormal,
                ),
              ),
              8.verticalSpace,
              Text(
                plan.subtitle,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.bodyDarkGray,
                ),
              ),
              20.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${plan.price}',
                    style: getTextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentNormal,
                    ),
                  ),
                  Text(
                    '/month',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ],
              ),
              25.verticalSpace,
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plan.features.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF27C840),
                            size: 20,
                          ),
                          10.horizontalSpace,
                          Text(
                            plan.features[index],
                            style: getTextStyle(
                              fontSize: 13.sp,
                              color: AppColors.bodyDarkGray,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Obx(() {
                if (stripeController.isLoading.value) {
                  return CustomLoading();
                }
                return CustomPrimaryButton(
                  text: "Get Started",
                  color: AppColors.primaryDeepBlueNormal,
                  onPressed: () {
                    stripeController.makePayment(
                      amount: 100.00,
                      currency: 'usd',
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
