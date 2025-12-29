// To parse this JSON data, do
//
//     final vendorUserModel = vendorUserModelFromJson(jsonString);

import 'dart:convert';

VendorUserModel vendorUserModelFromJson(String str) => VendorUserModel.fromJson(json.decode(str));

String vendorUserModelToJson(VendorUserModel data) => json.encode(data.toJson());

class VendorUserModel {
  bool success;
  Vendor vendor;

  VendorUserModel({
    required this.success,
    required this.vendor,
  });

  factory VendorUserModel.fromJson(Map<String, dynamic> json) => VendorUserModel(
    success: json["success"],
    vendor: Vendor.fromJson(json["vendor"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "vendor": vendor.toJson(),
  };
}

class Vendor {
  int id;
  int userId;
  String businessName;
  int categoryId;
  String accountBalance;
  String latitude;
  String longitude;
  String? servicesGroup;
  dynamic paymentInformation;
  dynamic paymentType;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String categoryName;
  User user;
  Category category;
  Settings settings;
  List<dynamic> vendorEarning;
  List<BusinessHour> businessHours;

  Vendor({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.categoryId,
    required this.accountBalance,
    required this.latitude,
    required this.longitude,
    this.servicesGroup,
    required this.paymentInformation,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.categoryName,
    required this.user,
    required this.category,
    required this.settings,
    required this.vendorEarning,
    required this.businessHours,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    userId: json["user_id"],
    businessName: json["business_name"],
    categoryId: json["category_id"],
    accountBalance: json["account_balance"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    servicesGroup: json["services_group"],
    paymentInformation: json["payment_information"],
    paymentType: json["payment_type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    categoryName: json["category_name"],
    user: User.fromJson(json["user"]),
    category: Category.fromJson(json["category"]),
    settings: Settings.fromJson(json["settings"]),
    vendorEarning: List<dynamic>.from(json["vendor_earning"].map((x) => x)),
    businessHours: List<BusinessHour>.from(json["business_hours"].map((x) => BusinessHour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "business_name": businessName,
    "category_id": categoryId,
    "account_balance": accountBalance,
    "latitude": latitude,
    "longitude": longitude,
    "services_group": servicesGroup,
    "payment_information": paymentInformation,
    "payment_type": paymentType,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "category_name": categoryName,
    "user": user.toJson(),
    "category": category.toJson(),
    "settings": settings.toJson(),
    "vendor_earning": List<dynamic>.from(vendorEarning.map((x) => x)),
    "business_hours": List<dynamic>.from(businessHours.map((x) => x.toJson())),
  };
}

class BusinessHour {
  int id;
  int vendorId;
  String day;
  int isClosed;
  String openTime;
  String closeTime;
  DateTime createdAt;
  DateTime updatedAt;

  BusinessHour({
    required this.id,
    required this.vendorId,
    required this.day,
    required this.isClosed,
    required this.openTime,
    required this.closeTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessHour.fromJson(Map<String, dynamic> json) => BusinessHour(
    id: json["id"],
    vendorId: json["vendor_id"],
    day: json["day"],
    isClosed: json["is_closed"],
    openTime: json["open_time"],
    closeTime: json["close_time"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "day": day,
    "is_closed": isClosed,
    "open_time": openTime,
    "close_time": closeTime,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Category {
  int id;
  String name;
  String slug;
  dynamic image;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class Settings {
  int id;
  int vendorId;
  List<String> serviceType;
  bool offersVirtual;
  List<String> teamSize;
  String maxTravelDistance;
  String travelPolicy;
  String paymentMethod;
  DateTime createdAt;
  DateTime updatedAt;

  Settings({
    required this.id,
    required this.vendorId,
    required this.serviceType,
    required this.offersVirtual,
    required this.teamSize,
    required this.maxTravelDistance,
    required this.travelPolicy,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    id: json["id"],
    vendorId: json["vendor_id"],
    serviceType: List<String>.from(json["service_type"].map((x) => x)),
    offersVirtual: json["offers_virtual"],
    teamSize: List<String>.from(json["team_size"].map((x) => x)),
    maxTravelDistance: json["max_travel_distance"],
    travelPolicy: json["travel_policy"],
    paymentMethod: json["payment_method"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "service_type": List<dynamic>.from(serviceType.map((x) => x)),
    "offers_virtual": offersVirtual,
    "team_size": List<dynamic>.from(teamSize.map((x) => x)),
    "max_travel_distance": maxTravelDistance,
    "travel_policy": travelPolicy,
    "payment_method": paymentMethod,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  DateTime emailVerifiedAt;
  String image;
  String backgroundImage;
  String country;
  String city;
  String? address;
  dynamic subscriptionPlanId;
  bool isFirstTime;
  dynamic otp;
  dynamic otpExpireAt;
  DateTime lastSeen;
  dynamic fcmToken;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.emailVerifiedAt,
    required this.image,
    required this.backgroundImage,
    required this.country,
    required this.city,
    required this.address,
    required this.subscriptionPlanId,
    required this.isFirstTime,
    required this.otp,
    required this.otpExpireAt,
    required this.lastSeen,
    required this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    image: json["image"],
    backgroundImage: json["background_image"],
    country: json["country"],
    city: json["city"],
    address: json["address"],
    subscriptionPlanId: json["subscription_plan_id"],
    isFirstTime: json["is_first_time"],
    otp: json["otp"],
    otpExpireAt: json["otp_expire_at"],
    lastSeen: DateTime.parse(json["last_seen"]),
    fcmToken: json["fcm_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "image": image,
    "background_image": backgroundImage,
    "country": country,
    "city": city,
    "address": address,
    "subscription_plan_id": subscriptionPlanId,
    "is_first_time": isFirstTime,
    "otp": otp,
    "otp_expire_at": otpExpireAt,
    "last_seen": lastSeen.toIso8601String(),
    "fcm_token": fcmToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
