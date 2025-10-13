import 'package:get/get.dart';
import 'package:sireenshaban/core/utils/constants/enums.dart';

class HomeController extends GetxController {
  RxBool isAdditionalServicesClose = false.obs;
  RxInt carouselCurrentIndex = 1.obs;

  List<DealsAndPromotionModel> dealsAndPromotion = [
    DealsAndPromotionModel(
      image: "https://lesroches.edu/wp-content/uploads/2022/08/Restaurant_business_plan_main.jpg",
      shopTitle: 'Marco\'s Kitchen',
      discount: '15% off',
      subtitle: 'Dinner for two',
      validityDate: 'Valid until Feb 20',
      role: 'restaurant',
      group: ServicesGroup.businessAndCreativeServices,
    ),

    DealsAndPromotionModel(
      image: "https://media.istockphoto.com/id/1497806504/photo/hair-styling-in-beauty-salon-woman-does-her-hair-in-modern-beauty-salon-woman-stylist-dries.jpg?s=612x612&w=0&k=20&c=3dO_HWS8WvSGNbGmxTsqK70vZMGqM2REnbVJG09YnmI=",
      shopTitle: 'Bella vista Salon',
      discount: '15% off',
      subtitle: 'First haircut & styling',
      validityDate: 'Valid until Feb 20',
      role: 'salon',
      group: ServicesGroup.personalCareAndEducation,
    ),

    DealsAndPromotionModel(
      image: "https://img.freepik.com/free-photo/woman-sportswear-lifting-dumbbell_23-2147688028.jpg?semt=ais_hybrid&w=740&q=80",
      shopTitle: 'FitLife Gym',
      discount: '15% off',
      subtitle: 'Trial membership',
      validityDate: 'Valid until Feb 20',
      role: 'gym',
      group: ServicesGroup.personalCareAndEducation,
    ),
  ];

  List<CommunityEventModel> communityEvents = [
    CommunityEventModel(
      image:
          "https://www.skylakes.org/wp-content/uploads/2023/12/healthfair2023-scaled.jpg",
      title: "Community Health Fair",
      date: "15 March,2025",
      location: "Near you",
    ),

    CommunityEventModel(
      image:  "https://bestinteriordesign.com.bd/wp-content/uploads/2022/08/software-company-inteiror-deisgn.png",
      title: "Local Business Expo",
      date: "15 March,2025",
      location: "Near you",
    ),
  ];

  List<TrendingNearbyModel> trendingNearby = [
    TrendingNearbyModel(
      image:
      "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/7e/c1/88/cafeteria-armenia.jpg?w=500&h=-1&s=1",
      title: "Artisan Coffee",
      status: "Popular",
      group: ServicesGroup.businessAndCreativeServices,
    ),

    TrendingNearbyModel(
      image:
      "https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=M3wyNDE0NjF8MHwxfHNlYXJjaHw2fHxCYXJiZXJ8ZW58MHx8fHwxNjk1MzMwNzk5fDA&ixlib=rb-4.0.3&w=800&h=800",
      title: "Fresh Cuts Barbershop",
      status: "Popular",
      group: ServicesGroup.personalCareAndEducation
    ),

    TrendingNearbyModel(
        image:
        "https://st4.depositphotos.com/21395724/23687/i/450/depositphotos_236876324-stock-photo-repair-home-appliances-service-center.jpg",
        title: "Appliance Repair Service",
        status: "Popular",
        group: ServicesGroup.homeAndMaintenanceServices
    )
  ];

  void changeIsAdditionalServicesClose({required bool value}) {
    isAdditionalServicesClose.value = value;
  }

  void changeCarouselCurrentIndex({required int value}) {
    carouselCurrentIndex.value = value;
  }
}

class DealsAndPromotionModel {
  DealsAndPromotionModel({
    required this.image,
    required this.shopTitle,
    required this.discount,
    required this.subtitle,
    required this.validityDate,
    required this.role,
    required this.group,
  });

  final String image;
  final String shopTitle;
  final String discount;
  final String subtitle;
  final String validityDate;
  final String role;
  final ServicesGroup group;
}

class CommunityEventModel {
  CommunityEventModel({
    required this.image,
    required this.title,
    required this.date,
    required this.location,
  });

  final String image;
  final String title;
  final String date;
  final String location;
}

class TrendingNearbyModel {

  TrendingNearbyModel({
    required this.image,
    required this.title,
    required this.status,
    required this.group,
  });

  final String image;
  final String title;
  final String status;
  final ServicesGroup group;
}
