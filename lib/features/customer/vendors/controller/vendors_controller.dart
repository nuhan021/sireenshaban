import 'package:get/get.dart';

class VendorsController extends GetxController {
  var vendors = <MyVendor>[
    MyVendor(
      image:
          "https://img.freepik.com/premium-photo/portrait-young-woman-dressed-splendid-evening-makeup-perfect-dense-wavy-hairstyle-make-up-manicure-jewellery-purple-tints-hairdressing-art-hair-care-makeup_353119-186.jpg?semt=ais_hybrid&w=740&q=80",
      title: "Serenity Spa & Well",
      subtitle: "Beauty & Wellness",
      service: "parlour",
      date: "27 April,2025",
      location: "Near you",
      price: "\$185",
      role: "doctor",
    ),
    MyVendor(
      image:
          "https://img.freepik.com/free-photo/tender-african-woman-smiling-enjoying-massage-with-closed-eyes-spa-resort_176420-13956.jpg",
      title: "Serenity Spa & Well",
      subtitle: "Beauty & Wellness",
      service: "Deep Tissue Massage",
      date: "27 April,2025",
      location: "Near you",
      price: "\$85",
      role: "doctor",
    ),
    MyVendor(
      image:
          "https://img.freepik.com/premium-photo/sexy-girl-doing-yoga-home-kitchen_321831-2764.jpg",
      title: "Serenity Spa & Well",
      subtitle: "Beauty & Wellness",
      service: "Deep Tissue Massage",
      date: "15 March,2025",
      location: "Near you",
      price: "\$150",
      role: "spa",
    ),

    MyVendor(
      image:
          "https://img.freepik.com/free-photo/female-doctor-hospital_23-2148827760.jpg",
      title: "Dr. Sarah Johnson",
      subtitle: "Healthcare",
      service: "Consultation",
      date: "27 April,2025",
      location: "Near you",
      price: "\$100",
      role: "doctor",
    ),
    MyVendor(
      image:
          "https://www.shutterstock.com/image-photo/profile-photo-attractive-family-doc-600nw-1724693776.jpg",
      title: "Marco's Kitchen",
      subtitle: "Healthcare",
      service: "General Consultation",
      date: "27 April,2025",
      location: "Near you",
      price: "\$200",
      role: "doctor",
    ),

    MyVendor(
      image:
          "https://cdn.muscleandstrength.com/sites/default/files/styles/800x500/public/lean_woman_doing_dumbbell_row.jpg",
      title: "Sarah Johnson",
      subtitle: "Gym",
      service: "Gym",
      date: "27 April,2025",
      location: "Near you",
      price: "\$185",
      role: "doctor",
    ),
  ].obs;
}

class MyVendor {
  const MyVendor({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.service,
    required this.date,
    required this.location,
    required this.price,
    required this.role,
  });

  final String image;
  final String title;
  final String subtitle;
  final String service;
  final String date;
  final String location;
  final String price;
  final String role;
}
