import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/features/stripe/controller/stripe_controller.dart';
import 'package:sireenshaban/features/subscription/views/widget/subscription_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  late PageController _pageController;
  final StripeController stripeController = Get.find<StripeController>();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.80,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
        title: Text(
          "Subscription Plan",
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (stripeController.isSubscriptionPlanLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final plansList =
              stripeController.subscriptionPlans.value?.plans ?? [];

          if (plansList.isEmpty) {
            return const Center(
              child: Text("No subscription plans available."),
            );
          }

          return Column(
            children: [
              20.verticalSpace,
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: plansList.length,
                  onPageChanged: (value) =>
                      setState(() => _currentPage = value),
                  itemBuilder: (context, index) {
                    double scale = _currentPage == index ? 1.0 : 0.88;
                    return SubscriptionCard(
                      plan: plansList[index],
                      scale: scale,
                    );
                  },
                ),
              ),
              30.verticalSpace,
            ],
          );
        }),
      ),
    );
  }
}
