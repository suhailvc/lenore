class DeliveryChargeRequestProduct {
  final int productId;
  final int quantity;
  final int productType;

  DeliveryChargeRequestProduct({
    required this.productId,
    required this.quantity,
    required this.productType,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'product_type': productType,
    };
  }
}

// Model for the delivery charge API response
class DeliveryChargeResponse {
  final bool status;
  final String message;
  final double deliveryCharge;

  DeliveryChargeResponse({
    required this.status,
    required this.message,
    required this.deliveryCharge,
  });

  factory DeliveryChargeResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryChargeResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      deliveryCharge: json['get_delivery_charge'] != null
          ? double.parse(json['get_delivery_charge'].toString())
          : 0.0,
    );
  }
}
// class DeliveryChargeRequestProduct {
//   final int productId;
//   final int quantity;
//   final int productType;

//   DeliveryChargeRequestProduct({
//     required this.productId,
//     required this.quantity,
//     required this.productType,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'product_id': productId,
//       'quantity': quantity,
//       'product_type': productType,
//     };
//   }
// }

// class DeliveryChargeResponse {
//   final bool status;
//   final String message;
//   final double deliveryCharge;

//   DeliveryChargeResponse({
//     required this.status,
//     required this.message,
//     required this.deliveryCharge,
//   });

//   factory DeliveryChargeResponse.fromJson(Map<String, dynamic> json) {
//     return DeliveryChargeResponse(
//       status: json['status'] ?? false,
//       message: json['message'] ?? '',
//       deliveryCharge: json['get_delivery_charge'] != null
//           ? double.parse(json['get_delivery_charge'].toString())
//           : 0.0,
//     );
//   }
// }
