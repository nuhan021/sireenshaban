// To parse this JSON data, do
//
//     final trendingModel = trendingModelFromJson(jsonString);

import 'dart:convert';

TrendingModel trendingModelFromJson(String str) => TrendingModel.fromJson(json.decode(str));

String trendingModelToJson(TrendingModel data) => json.encode(data.toJson());

class TrendingModel {
  bool success;
  String message;
  List<Datum> data;
  Meta meta;

  TrendingModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory TrendingModel.fromJson(Map<String, dynamic> json) => TrendingModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Datum {
  int id;
  String businessName;
  dynamic image;
  dynamic backgroundImage;
  int rating;
  int bookings;

  Datum({
    required this.id,
    required this.businessName,
    required this.image,
    required this.backgroundImage,
    required this.rating,
    required this.bookings,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    businessName: json["business_name"],
    image: json["image"],
    backgroundImage: json["background_image"],
    rating: json["rating"],
    bookings: json["bookings"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
    "image": image,
    "background_image": backgroundImage,
    "rating": rating,
    "bookings": bookings,
  };
}

class Meta {
  int currentPage;
  int lastPage;
  int perPage;
  int total;

  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}
