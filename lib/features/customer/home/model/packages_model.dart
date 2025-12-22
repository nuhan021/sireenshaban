// To parse this JSON data, do
//
//     final packagesModel = packagesModelFromJson(jsonString);

import 'dart:convert';

PackagesModel packagesModelFromJson(String str) => PackagesModel.fromJson(json.decode(str));

String packagesModelToJson(PackagesModel data) => json.encode(data.toJson());

class PackagesModel {
  bool success;
  List<Datum> data;

  PackagesModel({
    required this.success,
    required this.data,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int vendorId;
  int categoryId;
  String title;
  String slug;
  String description;
  String serviceGroup;
  DateTime? validUntil;
  String? subtitle;
  String pricePerEvent;
  int capacity;
  String venueType;
  String location;
  dynamic availableSlots;
  dynamic image;
  int isActive;
  dynamic categorySubtype;
  dynamic tags;
  int duration;
  int isFeatured;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int reviewsSumRating;
  List<AvailableDate> availableDates;
  Vendor vendor;
  Category category;
  List<Review> reviews;

  Datum({
    required this.id,
    required this.vendorId,
    required this.categoryId,
    required this.title,
    required this.slug,
    required this.description,
    required this.serviceGroup,
    required this.validUntil,
    required this.subtitle,
    required this.pricePerEvent,
    required this.capacity,
    required this.venueType,
    required this.location,
    required this.availableSlots,
    required this.image,
    required this.isActive,
    required this.categorySubtype,
    required this.tags,
    required this.duration,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.reviewsSumRating,
    required this.availableDates,
    required this.vendor,
    required this.category,
    required this.reviews,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    vendorId: json["vendor_id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    serviceGroup: json["service_group"],
    validUntil: json["valid_until"] == null ? null : DateTime.parse(json["valid_until"]),
    subtitle: json["subtitle"],
    pricePerEvent: json["price_per_event"],
    capacity: json["capacity"],
    venueType: json["venue_type"],
    location: json["location"],
    availableSlots: json["available_slots"],
    image: json["image"],
    isActive: json["is_active"],
    categorySubtype: json["category_subtype"],
    tags: json["tags"],
    duration: json["duration"],
    isFeatured: json["is_featured"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    reviewsSumRating: json["reviews_sum_rating"],
    availableDates: List<AvailableDate>.from(json["available_dates"].map((x) => AvailableDate.fromJson(x))),
    vendor: Vendor.fromJson(json["vendor"]),
    category: Category.fromJson(json["category"]),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
    "description": description,
    "service_group": serviceGroup,
    "valid_until": validUntil != null ? "${validUntil!.year.toString().padLeft(4, '0')}-${validUntil!.month.toString().padLeft(2, '0')}-${validUntil!.day.toString().padLeft(2, '0')}" : null,
    "subtitle": subtitle,
    "price_per_event": pricePerEvent,
    "capacity": capacity,
    "venue_type": venueType,
    "location": location,
    "available_slots": availableSlots,
    "image": image,
    "is_active": isActive,
    "category_subtype": categorySubtype,
    "tags": tags,
    "duration": duration,
    "is_featured": isFeatured,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "reviews_sum_rating": reviewsSumRating,
    "available_dates": List<dynamic>.from(availableDates.map((x) => x.toJson())),
    "vendor": vendor.toJson(),
    "category": category.toJson(),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
  };
}

class AvailableDate {
  int id;
  int packageId;
  dynamic eventId;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  List<TimeSlot> timeSlots;

  AvailableDate({
    required this.id,
    required this.packageId,
    required this.eventId,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.timeSlots,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) => AvailableDate(
    id: json["id"],
    packageId: json["package_id"],
    eventId: json["event_id"],
    date: DateTime.parse(json["date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    timeSlots: List<TimeSlot>.from(json["time_slots"].map((x) => TimeSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_id": packageId,
    "event_id": eventId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "time_slots": List<dynamic>.from(timeSlots.map((x) => x.toJson())),
  };
}

class TimeSlot {
  int id;
  int dateId;
  String time;
  String period;
  int isBooked;
  DateTime createdAt;
  DateTime updatedAt;

  TimeSlot({
    required this.id,
    required this.dateId,
    required this.time,
    required this.period,
    required this.isBooked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    id: json["id"],
    dateId: json["date_id"],
    time: json["time"],
    period: json["period"],
    isBooked: json["is_booked"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_id": dateId,
    "time": time,
    "period": period,
    "is_booked": isBooked,
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

class Review {
  int id;
  int bookingId;
  int userId;
  int rating;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  int laravelThroughKey;

  Review({
    required this.id,
    required this.bookingId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.laravelThroughKey,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    bookingId: json["booking_id"],
    userId: json["user_id"],
    rating: json["rating"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    laravelThroughKey: json["laravel_through_key"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "user_id": userId,
    "rating": rating,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "laravel_through_key": laravelThroughKey,
  };
}

class Vendor {
  int id;
  int userId;
  String businessName;
  int categoryId;
  String accountBalance;
  dynamic latitude;
  dynamic longitude;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Vendor({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.categoryId,
    required this.accountBalance,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    userId: json["user_id"],
    businessName: json["business_name"],
    categoryId: json["category_id"],
    accountBalance: json["account_balance"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "business_name": businessName,
    "category_id": categoryId,
    "account_balance": accountBalance,
    "latitude": latitude,
    "longitude": longitude,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
