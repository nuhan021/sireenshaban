// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  bool success;
  List<Datum> data;

  EventModel({
    required this.success,
    required this.data,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
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
  DateTime eventDate;
  String eventTime;
  String venueType;
  String location;
  dynamic image;
  int duration;
  String ticketPrice;
  int maxAttendees;
  String organizerContact;
  int isPublic;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  Vendor vendor;
  Category category;

  Datum({
    required this.id,
    required this.vendorId,
    required this.categoryId,
    required this.title,
    required this.slug,
    required this.description,
    required this.eventDate,
    required this.eventTime,
    required this.venueType,
    required this.location,
    required this.image,
    required this.duration,
    required this.ticketPrice,
    required this.maxAttendees,
    required this.organizerContact,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.vendor,
    required this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    vendorId: json["vendor_id"],
    categoryId: json["category_id"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    eventDate: DateTime.parse(json["event_date"]),
    eventTime: json["event_time"],
    venueType: json["venue_type"],
    location: json["location"],
    image: json["image"],
    duration: json["duration"],
    ticketPrice: json["ticket_price"],
    maxAttendees: json["max_attendees"],
    organizerContact: json["organizer_contact"],
    isPublic: json["is_public"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    vendor: Vendor.fromJson(json["vendor"]),
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "category_id": categoryId,
    "title": title,
    "slug": slug,
    "description": description,
    "event_date": "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
    "event_time": eventTime,
    "venue_type": venueType,
    "location": location,
    "image": image,
    "duration": duration,
    "ticket_price": ticketPrice,
    "max_attendees": maxAttendees,
    "organizer_contact": organizerContact,
    "is_public": isPublic,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "vendor": vendor.toJson(),
    "category": category.toJson(),
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
