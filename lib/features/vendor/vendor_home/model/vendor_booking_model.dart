import 'dart:convert';

VendorBookingModel vendorBookingModelFromJson(String str) =>
    VendorBookingModel.fromJson(json.decode(str));
String vendorBookingModelToJson(VendorBookingModel data) =>
    json.encode(data.toJson());

class VendorBookingModel {
  bool success;
  List<Datum> data;

  VendorBookingModel({required this.success, required this.data});

  factory VendorBookingModel.fromJson(Map<String, dynamic> json) =>
      VendorBookingModel(
        success: json["success"] ?? false,
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  int userId;
  int vendorId;
  int? packageId;
  int? eventId;
  dynamic quoteId;
  int timeSlotId;
  int guests;
  String? specialConcerns;
  String productType;
  String subtotal;
  String tax;
  String platformFee;
  String vendorTotal;
  String total;
  String status;
  int reviewed;
  DateTime date;
  String time;
  DatumUser user;
  Vendor vendor;
  Package? package;
  Event? event;
  dynamic quote;
  TimeSlot timeSlot;
  Payment payment;

  Datum({
    required this.id,
    required this.userId,
    required this.vendorId,
    required this.packageId,
    required this.eventId,
    required this.quoteId,
    required this.timeSlotId,
    required this.guests,
    required this.specialConcerns,
    required this.productType,
    required this.subtotal,
    required this.tax,
    required this.platformFee,
    required this.vendorTotal,
    required this.total,
    required this.status,
    required this.reviewed,
    required this.date,
    required this.time,
    required this.user,
    required this.vendor,
    required this.package,
    required this.event,
    required this.quote,
    required this.timeSlot,
    required this.payment,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    vendorId: json["vendor_id"] ?? 0,
    packageId: json["package_id"],
    eventId: json["event_id"],
    quoteId: json["quote_id"],
    timeSlotId: json["time_slot_id"] ?? 0,
    guests: json["guests"] ?? 0,
    specialConcerns: json["special_concerns"],
    productType: json["product_type"] ?? "",
    subtotal: json["subtotal"]?.toString() ?? "0",
    tax: json["tax"]?.toString() ?? "0",
    platformFee: json["platform_fee"]?.toString() ?? "0",
    vendorTotal: json["vendor_total"]?.toString() ?? "0",
    total: json["total"]?.toString() ?? "0",
    status: json["status"] ?? "",
    reviewed: json["reviewed"] ?? 0,
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
    time: json["time"] ?? "",
    user: DatumUser.fromJson(json["user"] ?? {}),
    vendor: Vendor.fromJson(json["vendor"] ?? {}),
    package: json["package"] == null ? null : Package.fromJson(json["package"]),
    event: json["event"] == null ? null : Event.fromJson(json["event"]),
    quote: json["quote"],
    timeSlot: TimeSlot.fromJson(json["time_slot"] ?? {}),
    payment: Payment.fromJson(json["payment"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "vendor_id": vendorId,
    "package_id": packageId,
    "event_id": eventId,
    "quote_id": quoteId,
    "time_slot_id": timeSlotId,
    "guests": guests,
    "special_concerns": specialConcerns,
    "product_type": productType,
    "subtotal": subtotal,
    "tax": tax,
    "platform_fee": platformFee,
    "vendor_total": vendorTotal,
    "total": total,
    "status": status,
    "reviewed": reviewed,
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "user": user.toJson(),
    "vendor": vendor.toJson(),
    "package": package?.toJson(),
    "event": event?.toJson(),
    "quote": quote,
    "time_slot": timeSlot.toJson(),
    "payment": payment.toJson(),
  };
}

class Event {
  int id;
  String title;
  String slug;
  DateTime eventDate;
  String eventTime;
  String venueType;
  String location;
  String ticketPrice;

  Event({
    required this.id,
    required this.title,
    required this.slug,
    required this.eventDate,
    required this.eventTime,
    required this.venueType,
    required this.location,
    required this.ticketPrice,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    slug: json["slug"] ?? "",
    eventDate: json["event_date"] == null
        ? DateTime.now()
        : DateTime.parse(json["event_date"]),
    eventTime: json["event_time"] ?? "",
    venueType: json["venue_type"] ?? "",
    location: json["location"] ?? "",
    ticketPrice: json["ticket_price"]?.toString() ?? "0",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "event_date":
        "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
    "event_time": eventTime,
    "venue_type": venueType,
    "location": location,
    "ticket_price": ticketPrice,
  };
}

class Package {
  int id;
  String title;
  String slug;
  String pricePerEvent;
  String venueType;
  String location;

  Package({
    required this.id,
    required this.title,
    required this.slug,
    required this.pricePerEvent,
    required this.venueType,
    required this.location,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"] ?? 0,
    title: json["title"] ?? "",
    slug: json["slug"] ?? "",
    pricePerEvent: json["price_per_event"]?.toString() ?? "0",
    venueType: json["venue_type"] ?? "",
    location: json["location"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "price_per_event": pricePerEvent,
    "venue_type": venueType,
    "location": location,
  };
}

class Payment {
  int id;
  int bookingId;
  String amount;
  String paymentMethod;
  String transactionId;
  String currency;
  String status;
  DateTime createdAt;

  Payment({
    required this.id,
    required this.bookingId,
    required this.amount,
    required this.paymentMethod,
    required this.transactionId,
    required this.currency,
    required this.status,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"] ?? 0,
    bookingId: json["booking_id"] ?? 0,
    amount: json["amount"]?.toString() ?? "0",
    paymentMethod: json["payment_method"] ?? "",
    transactionId: json["transaction_id"] ?? "",
    currency: json["currency"] ?? "",
    status: json["status"] ?? "",
    createdAt: json["created_at"] == null
        ? DateTime.now()
        : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "amount": amount,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "currency": currency,
    "status": status,
    "created_at": createdAt.toIso8601String(),
  };
}

class TimeSlot {
  int id;
  int dateId;
  String time;
  String period;
  AvailableDate? availableDate;

  TimeSlot({
    required this.id,
    required this.dateId,
    required this.time,
    required this.period,
    required this.availableDate,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
    id: json["id"] ?? 0,
    dateId: json["date_id"] ?? 0,
    time: json["time"] ?? "",
    period: json["period"] ?? "",
    availableDate: json["available_date"] == null
        ? null
        : AvailableDate.fromJson(json["available_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_id": dateId,
    "time": time,
    "period": period,
    "available_date": availableDate?.toJson(),
  };
}

class AvailableDate {
  int id;
  DateTime date;

  AvailableDate({required this.id, required this.date});

  factory AvailableDate.fromJson(Map<String, dynamic> json) => AvailableDate(
    id: json["id"] ?? 0,
    date: json["date"] == null ? DateTime.now() : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}

class DatumUser {
  int id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String email;
  dynamic image;
  dynamic backgroundImage;

  DatumUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.image,
    required this.backgroundImage,
  });

  factory DatumUser.fromJson(Map<String, dynamic> json) => DatumUser(
    id: json["id"] ?? 0,
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    email: json["email"] ?? "",
    image: json["image"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
    "image": image,
    "background_image": backgroundImage,
  };
}

class Vendor {
  int id;
  int userId;
  String businessName;
  VendorUser? user;

  Vendor({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.user,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    businessName: json["business_name"] ?? "",
    user: json["user"] == null ? null : VendorUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "business_name": businessName,
    "user": user?.toJson(),
  };
}

class VendorUser {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  VendorUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory VendorUser.fromJson(Map<String, dynamic> json) => VendorUser(
    id: json["id"] ?? 0,
    firstName: json["first_name"] ?? "",
    lastName: json["last_name"] ?? "",
    phoneNumber: json["phone_number"] ?? "",
    email: json["email"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "email": email,
  };
}
