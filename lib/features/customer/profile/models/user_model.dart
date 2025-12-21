class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String? country;
  final String? city;
  final String? address;
  final String? image;
  final String? backgroundImage;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.country,
    required this.city,
    required this.address,
    required this.image,
    required this.backgroundImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        email: json["email"] ?? "",
        country: json["country"],
        city: json["city"],
        address: json["address"],
        image: json["image"],
        backgroundImage: json["background_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "country": country,
        "city": city,
        "address": address,
        "image": image,
        "background_image": backgroundImage,
      };
}
