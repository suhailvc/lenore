class OrderDetailModel {
  final bool? status;
  final String? message;
  final OrderData? data;

  OrderDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class OrderData {
  final String? orderId;
  final String? orderDate;
  final String? deliveryDate;
  final String? couponCode;
  final String? paymentMode;
  final int? amount;
  final String? discount;
  final String? walletUsed;

  final String? voucherDiscountAmount;
  final String? deliveryCharge;
  final List<ProductDetail>? productDetails;

  OrderData({
    this.orderId,
    this.orderDate,
    this.deliveryDate,
    this.couponCode,
    this.paymentMode,
    this.amount,
    this.discount,
    this.walletUsed,
    this.voucherDiscountAmount,
    this.deliveryCharge,
    this.productDetails,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['order_id'] as String?,
      orderDate: json['order_date'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      couponCode: json['coupon_code'] as String?,
      paymentMode: json['payment_mode'] as String?,
      amount: json['amount'] as int?,
      discount: json['discount'] as String?,
      deliveryCharge: json['delivery_charge'] as String?,
      walletUsed: json['wallet_used'] as String?,
      voucherDiscountAmount: json['voucher_discount_amount'] as String?,
      productDetails: (json['product_details'] as List<dynamic>?)
          ?.map((item) => ProductDetail.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_date': orderDate,
      'delivery_date': deliveryDate,
      'coupon_code': couponCode,
      'payment_mode': paymentMode,
      'amount': amount,
      'discount': discount,
      'voucher_discount_amount': voucherDiscountAmount,
      'wallet_used': walletUsed,
      'delivery_charge': deliveryCharge,
      'product_details': productDetails?.map((item) => item.toJson()).toList(),
    };
  }
}

class ProductDetail {
  final int? id;
  final String? name;
  final String? image;
  final String? namear;
  final int? amount;
  final int? quantity;

  ProductDetail({
    this.id,
    this.name,
    this.image,
    this.namear,
    this.amount,
    this.quantity,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      namear: json['namear'] as String?,
      amount: json['amount'] as int?,
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'namear': namear,
      'amount': amount,
      'quantity': quantity,
    };
  }
}
// class OrderDetailModel {
//   final bool? status;
//   final String? message;
//   final OrderData? data;

//   OrderDetailModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailModel(
//       status: json['status'] as bool?,
//       message: json['message'] as String?,
//       data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.toJson(),
//     };
//   }
// }

// class OrderData {
//   final String? orderId;
//   final String? orderDate;
//   final String? deliveryDate;
//   final String? couponCode;
//   final String? paymentMode;
//   final int? amount;
//   final String? discount;
//   final String? deliveryCharge;
//   final List<ProductDetail>? productDetails;

//   OrderData({
//     this.orderId,
//     this.orderDate,
//     this.deliveryDate,
//     this.couponCode,
//     this.paymentMode,
//     this.amount,
//     this.discount,
//     this.deliveryCharge,
//     this.productDetails,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       orderId: json['order_id'] as String?,
//       orderDate: json['order_date'] as String?,
//       deliveryDate: json['delivery_date'] as String?,
//       couponCode: json['coupon_code'] as String?,
//       paymentMode: json['payment_mode'] as String?,
//       amount: json['amount'] as int?,
//       discount: json['discount'] as String?,
//       deliveryCharge: json['delivery_charge'] as String?,
//       productDetails: (json['product_details'] as List<dynamic>?)
//           ?.map((item) => ProductDetail.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'order_id': orderId,
//       'order_date': orderDate,
//       'delivery_date': deliveryDate,
//       'coupon_code': couponCode,
//       'payment_mode': paymentMode,
//       'amount': amount,
//       'discount': discount,
//       'delivery_charge': deliveryCharge,
//       'product_details': productDetails?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class ProductDetail {
//   final int? id;
//   final String? name;
//   final String? image;
//   final String? namear;
//   final int? amount;
//   final int? quantity;

//   ProductDetail({
//     this.id,
//     this.name,
//     this.image,
//     this.namear,
//     this.amount,
//     this.quantity,
//   });

//   factory ProductDetail.fromJson(Map<String, dynamic> json) {
//     return ProductDetail(
//       id: json['id'] as int?,
//       name: json['name'] as String?,
//       image: json['image'] as String?,
//       namear: json['namear'] as String?,
//       amount: json['amount'] as int?,
//       quantity: json['quantity'] as int?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'namear': namear,
//       'amount': amount,
//       'quantity': quantity,
//     };
//   }
// }
// class OrderDetailModel {
//   final bool status;
//   final String message;
//   final OrderData? data;

//   OrderDetailModel({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailModel(
//       status: json['status'] as bool,
//       message: json['message'] as String,
//       data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.toJson(),
//     };
//   }
// }

// class OrderData {
//   final String orderId;
//   final String orderDate;
//   final String? deliveryDate;
//   final String? couponCode;
//   final String? paymentMode;
//   final int amount;
//   final String? discount;
//   final String deliveryCharge;
//   final List<ProductDetail>? productDetails;

//   OrderData({
//     required this.orderId,
//     required this.orderDate,
//     this.deliveryDate,
//     this.couponCode,
//     this.paymentMode,
//     required this.amount,
//     this.discount,
//     required this.deliveryCharge,
//     this.productDetails,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       orderId: json['order_id'] as String,
//       orderDate: json['order_date'] as String,
//       deliveryDate: json['delivery_date'] as String?,
//       couponCode: json['coupon_code'] as String?,
//       paymentMode: json['payment_mode'] as String?,
//       amount: json['amount'] as int,
//       discount: json['discount'] as String?,
//       deliveryCharge: json['delivery_charge'] as String,
//       productDetails: (json['product_details'] as List<dynamic>?)
//           ?.map((item) => ProductDetail.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'order_id': orderId,
//       'order_date': orderDate,
//       'delivery_date': deliveryDate,
//       'coupon_code': couponCode,
//       'payment_mode': paymentMode,
//       'amount': amount,
//       'discount': discount,
//       'delivery_charge': deliveryCharge,
//       'product_details': productDetails?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class ProductDetail {
//   final int id;
//   final String name;
//   final String image;
//   final String namear;
//   final int amount;
//   final int quantity;

//   ProductDetail({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.namear,
//     required this.amount,
//     required this.quantity,
//   });

//   factory ProductDetail.fromJson(Map<String, dynamic> json) {
//     return ProductDetail(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       image: json['image'] as String,
//       namear: json['namear'] as String,
//       amount: json['amount'] as int,
//       quantity: json['quantity'] as int,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'namear': namear,
//       'amount': amount,
//       'quantity': quantity,
//     };
//   }
// }
//.............................................
// class OrderDetailModel {
//   final bool status;
//   final String message;
//   final OrderData? data;

//   OrderDetailModel({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
//     return OrderDetailModel(
//       status: json['status'] as bool,
//       message: json['message'] as String,
//       data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.toJson(),
//     };
//   }
// }

// class OrderData {
//   final String orderId;
//   final String orderDate;
//   final String deliveryDate;
//   final String? couponCode;
//   final String paymentMode;
//   final int amount;
//   final String? discount;
//   final String deliveryCharge;
//   final List<ProductDetail>? productDetails;

//   OrderData({
//     required this.orderId,
//     required this.orderDate,
//     required this.deliveryDate,
//     this.couponCode,
//     required this.paymentMode,
//     required this.amount,
//     this.discount,
//     required this.deliveryCharge,
//     this.productDetails,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       orderId: json['order_id'] as String,
//       orderDate: json['order_date'] as String,
//       deliveryDate: json['delivery_date'] as String,
//       couponCode: json['coupon_code'] as String?,
//       paymentMode: json['payment_mode'] as String,
//       amount: json['amount'] as int,
//       discount: json['discount'] as String?,
//       deliveryCharge: json['delivery_charge'] as String,
//       productDetails: (json['product_details'] as List<dynamic>?)
//           ?.map((item) => ProductDetail.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'order_id': orderId,
//       'order_date': orderDate,
//       'delivery_date': deliveryDate,
//       'coupon_code': couponCode,
//       'payment_mode': paymentMode,
//       'amount': amount,
//       'discount': discount,
//       'delivery_charge': deliveryCharge,
//       'product_details': productDetails?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class ProductDetail {
//   final int id;
//   final String name;
//   final String namear;
//   final int amount;
//   final int quantity;

//   ProductDetail({
//     required this.id,
//     required this.name,
//     required this.namear,
//     required this.amount,
//     required this.quantity,
//   });

//   factory ProductDetail.fromJson(Map<String, dynamic> json) {
//     return ProductDetail(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       namear: json['namear'] as String,
//       amount: json['amount'] as int,
//       quantity: json['quantity'] as int,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'namear': namear,
//       'amount': amount,
//       'quantity': quantity,
//     };
//   }
// }
