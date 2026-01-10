import 'package:get/get.dart';

class SubscriptionController extends GetxController {}

class SubscriptionPlan {
  final String title;
  final String subtitle;
  final String price;
  final List<String> features;
  final bool isPopular;

  SubscriptionPlan({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.features,
    this.isPopular = false,
  });
}
