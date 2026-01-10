class ServiceRequestListResponse {
  final String message;
  final List<ServiceRequestListItem> requests;

  ServiceRequestListResponse({required this.message, required this.requests});

  factory ServiceRequestListResponse.fromJson(Map<String, dynamic> json) {
    return ServiceRequestListResponse(
      message: json["message"] ?? "",
      requests: (json["requests"] as List<dynamic>? ?? [])
          .map(
            (item) =>
                ServiceRequestListItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class ServiceRequestListItem {
  final int serviceRequestId;
  final List<dynamic> serviceType;
  final DateTime? serviceDatetime;
  final String projectDetails;
  final String paymentMethod;
  final String status;
  final CustomerSummary customer;

  ServiceRequestListItem({
    required this.serviceRequestId,
    required this.serviceType,
    required this.serviceDatetime,
    required this.projectDetails,
    required this.paymentMethod,
    required this.status,
    required this.customer,
  });

  factory ServiceRequestListItem.fromJson(Map<String, dynamic> json) {
    return ServiceRequestListItem(
      serviceRequestId: json["service_request_id"] ?? 0,
      serviceType: json["service_type"] is List
          ? List<dynamic>.from(json["service_type"])
          : <dynamic>[],
      serviceDatetime: DateTime.tryParse(json["service_datetime"] ?? ""),
      projectDetails: json["project_details"] ?? "",
      paymentMethod: json["payment_method"] ?? "",
      status: json["status"] ?? "",
      customer: CustomerSummary.fromJson(json["customer"] ?? {}),
    );
  }
}

class CustomerSummary {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? image;

  CustomerSummary({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory CustomerSummary.fromJson(Map<String, dynamic> json) {
    return CustomerSummary(
      id: json["id"] ?? 0,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      email: json["email"] ?? "",
      image: json["image"],
    );
  }
}

class ServiceRequestDetailResponse {
  final ServiceRequestDetail serviceRequest;

  ServiceRequestDetailResponse({required this.serviceRequest});

  factory ServiceRequestDetailResponse.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDetailResponse(
      serviceRequest: ServiceRequestDetail.fromJson(
        json["service_request"] ?? {},
      ),
    );
  }
}

class ServiceRequestDetail {
  final int id;
  final List<dynamic> serviceType;
  final DateTime? serviceDatetime;
  final String projectDetails;
  final String status;
  final String paymentMethod;
  final CustomerDetail customer;
  final VendorDetail vendor;

  ServiceRequestDetail({
    required this.id,
    required this.serviceType,
    required this.serviceDatetime,
    required this.projectDetails,
    required this.status,
    required this.paymentMethod,
    required this.customer,
    required this.vendor,
  });

  factory ServiceRequestDetail.fromJson(Map<String, dynamic> json) {
    return ServiceRequestDetail(
      id: json["id"] ?? 0,
      serviceType: json["service_type"] is List
          ? List<dynamic>.from(json["service_type"])
          : <dynamic>[],
      serviceDatetime: DateTime.tryParse(json["service_datetime"] ?? ""),
      projectDetails: json["project_details"] ?? "",
      status: json["status"] ?? "",
      paymentMethod: json["payment_method"] ?? "",
      customer: CustomerDetail.fromJson(json["customer"] ?? {}),
      vendor: VendorDetail.fromJson(json["vendor"] ?? {}),
    );
  }
}

class CustomerDetail {
  final int id;
  final String name;
  final String email;

  CustomerDetail({required this.id, required this.name, required this.email});

  factory CustomerDetail.fromJson(Map<String, dynamic> json) {
    return CustomerDetail(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }
}

class VendorDetail {
  final int id;
  final String businessName;

  VendorDetail({required this.id, required this.businessName});

  factory VendorDetail.fromJson(Map<String, dynamic> json) {
    return VendorDetail(
      id: json["id"] ?? 0,
      businessName: json["business_name"] ?? "",
    );
  }
}
