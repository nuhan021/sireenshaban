/// LIST OF Enums
/// They cannot be created inside a class.

enum TextSizes { small, medium, large }

enum OrderStatus { processing, shipped, delivered }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm
}

enum ServicesGroup {
  businessAndCreativeServices,
  personalCareAndEducation,
  homeAndMaintenanceServices
}

enum UserRole {
  customer,
  vendor,
}

enum BookingRequest {
  newRequest,
  quotedRequest,
  rejectedRequest,
}
