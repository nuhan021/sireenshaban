import 'package:get/get.dart';

class CustomerInterestController extends GetxController {
  List<InterestModel> category = [
    InterestModel(
      role: "doctor",
      image:
          "https://static.vecteezy.com/system/resources/thumbnails/026/375/249/small/ai-generative-portrait-of-confident-male-doctor-in-white-coat-and-stethoscope-standing-with-arms-crossed-and-looking-at-camera-photo.jpg",
    ),
    InterestModel(
      role: "saloon",
      image:
          "https://uploads-ssl.webflow.com/61f6bdf6622ca14c87d8dac1/6464022cd9a97ebd3de17cf3_SalonMainImage.jpg",
    ),
    InterestModel(
      role: "restaurant",
      image:
          "https://content.phocafe.co.uk/wp-content/uploads/2024/10/Baker-Street-scaled.jpg",
    ),
    InterestModel(
      role: "dj",
      image:
          "https://img.freepik.com/free-photo/cyberpunk-dj-illustration_23-2151656004.jpg?w=360",
    ),
    InterestModel(
      role: "photographer",
      image:
          "https://thumbs.dreamstime.com/b/woman-photographer-takes-images-dslr-camera-woman-professional-photographer-taking-landscape-images-dslr-camera-129532876.jpg",
    ),
    InterestModel(
      role: "painter",
      image:
          "https://thumbs.dreamstime.com/b/woman-photographer-takes-images-dslr-camera-woman-professional-photographer-taking-landscape-images-dslr-camera-129532876.jpg",
    ),
    InterestModel(
      role: "pet care",
      image:
          "https://www.offermaids.com/blog/wp-content/uploads/2022/09/o3.jpg",
    ),
    InterestModel(
      role: "electrician",
      image:
          "https://contractortrainingcenter.com/cdn/shop/articles/Untitled_design_1.png?v=1693506427&width=1100",
    ),
    InterestModel(
      role: "plumber",
      image:
          "https://img.freepik.com/free-vector/young-plumber-man-with-object-element-service_24797-1957.jpg?semt=ais_hybrid&w=740&q=80",
    ),
  ];

  RxList<String> selectedCategory = <String>[].obs;

  void addAndRemoveCategory({required String role}) {
    if (selectedCategory.contains(role)) {
      selectedCategory.remove(role);
    } else {
      if (selectedCategory.length < 5) selectedCategory.add(role);
    }
  }
}

class InterestModel {
  InterestModel({required this.role, required this.image});

  final String role;
  final String image;
}
