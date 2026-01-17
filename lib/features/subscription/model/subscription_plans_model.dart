// To parse this JSON data, do
//
//     final subscriptionPlansModel = subscriptionPlansModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPlansModel subscriptionPlansModelFromJson(String str) =>
    SubscriptionPlansModel.fromJson(json.decode(str));

String subscriptionPlansModelToJson(SubscriptionPlansModel data) =>
    json.encode(data.toJson());

class SubscriptionPlansModel {
  bool success;
  List<Plan> plans;

  SubscriptionPlansModel({required this.success, required this.plans});

  factory SubscriptionPlansModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPlansModel(
        success: json["success"],
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
  };
}

class Plan {
  int id;
  String title;
  String description;
  int price;
  List<String> features;
  String durationType;
  int durationValue;
  bool isPopular;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Plan({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.features,
    required this.durationType,
    required this.durationValue,
    required this.isPopular,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    features: List<String>.from(json["features"].map((x) => x)),
    durationType: json["duration_type"],
    durationValue: json["duration_value"],
    isPopular: json["is_popular"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "features": List<dynamic>.from(features.map((x) => x)),
    "duration_type": durationType,
    "duration_value": durationValue,
    "is_popular": isPopular,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
