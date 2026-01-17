import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/stripe/controller/stripe_controller.dart';
import 'package:sireenshaban/features/subscription/model/subscription_plans_model.dart';

class SubscriptionCard extends StatelessWidget {
  final Plan plan;
  final double scale;

  SubscriptionCard({super.key, required this.plan, required this.scale});

  final StripeController stripeController = Get.find<StripeController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      transform: Matrix4.identity()..scale(scale),
      alignment: Alignment.center,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: plan.isPopular
                ? AppColors.primaryDeepBlueNormal
                : const Color(0xFFE9EBF3),
            width: plan.isPopular ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 12),
              blurRadius: 24,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    plan.title,
                    style: getTextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDeepBlueNormal,
                    ),
                  ),
                ),
                if (plan.isPopular)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDeepBlueNormal,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "Popular",
                      style: getTextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            10.verticalSpace,
            Text(
              plan.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyDarkGray,
              ),
            ),
            24.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${plan.price}',
                  style: getTextStyle(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentNormal,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 4.w),
                  child: Text(
                    '/${plan.durationType}',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ),
              ],
            ),
            30.verticalSpace,
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: plan.features.length,
                separatorBuilder: (context, index) => 12.verticalSpace,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Icon(
                          Icons.check_circle,
                          color: const Color(0xFF27C840),
                          size: 20.sp,
                        ),
                      ),
                      12.horizontalSpace,
                      Expanded(
                        child: Text(
                          plan.features[index],
                          style: getTextStyle(
                            fontSize: 14.sp,
                            color: AppColors.bodyDarkGray,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            20.verticalSpace,
            Obx(() {
              final isProcessing = stripeController.isPaymentProcessing.value;
              if (isProcessing) {
                return const Center(child: CustomLoading());
              }
              return SizedBox(
                width: double.maxFinite,
                child: CustomPrimaryButton(
                  text: "Get Started",
                  color: AppColors.primaryDeepBlueNormal,
                  onPressed: () => stripeController.makePayment(plan.id),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
