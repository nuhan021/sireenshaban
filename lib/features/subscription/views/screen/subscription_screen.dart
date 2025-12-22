import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/controller/stripe_controller.dart';
import 'package:sireenshaban/features/subscription/views/widget/subscription_card.dart';

import '../../controller/subscription_controller.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late PageController _pageController;
  final StripeController stripeController = Get.put(StripeController());
  int _currentPage = 1; // ডিফল্টভাবে মাঝখানের কার্ড সিলেক্টেড

  final List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      title: "Basic",
      subtitle: "Good for beginners",
      price: "0",
      features: ["1 Listing", "Basic Support", "Limited Photos"],
    ),
    SubscriptionPlan(
      title: "Premium",
      subtitle: "Most popular for business",
      price: "29",
      features: ["Unlimited Listings", "Priority Support", "Featured Tag"],
      isPopular: true,
    ),
    SubscriptionPlan(
      title: "Enterprise",
      subtitle: "For large companies",
      price: "99",
      features: ["Full API Access", "Account Manager", "Custom Branding"],
    ),
  ];

  @override
  void initState() {
    super.initState();
    // viewportFraction 0.8 দিলে পাশের কার্ডগুলো কিছুটা দেখা যাবে
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            40.verticalSpace,
            Text(
              "Choose the Plan That's Right for You",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryDeepBlueNormal,
              ),
            ).paddingSymmetric(horizontal: 40.w),
            15.verticalSpace,
            Text(
              "All paid plans start with a 1-month free trial.",
              textAlign: TextAlign.center,
              style: getTextStyle(
                fontSize: 14.sp,
                color: AppColors.bodyDarkGray,
              ),
            ).paddingSymmetric(horizontal: 50.w),

            40.verticalSpace,

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: plans.length,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemBuilder: (context, index) {
                  // স্কেলিং লজিক
                  double scale = _currentPage == index ? 1.0 : 0.85;
                  return SubscriptionCard(plan: plans[index], scale: scale);
                },
              ),
            ),

            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
