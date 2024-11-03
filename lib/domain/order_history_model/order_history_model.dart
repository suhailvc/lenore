class OrderHistoryModel {
  final bool? status;
  final String? message;
  final List<OrderData>? data;

  OrderHistoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => OrderData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderData {
  final String? orderId;
  final String? orderStatus;
  final DateTime? createdAt;
  final String? date;

  OrderData({
    this.orderId,
    this.orderStatus,
    this.createdAt,
    this.date,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      orderId: json['order_id'] as String?,
      orderStatus: json['order_status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_status': orderStatus,
      'created_at': createdAt?.toIso8601String(),
      'date': date,
    };
  }
}
// class OrderHistoryModel {
//   final bool status;
//   final String message;
//   final List<OrderData>? data;

//   OrderHistoryModel({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
//     return OrderHistoryModel(
//       status: json['status'] as bool,
//       message: json['message'] as String,
//       data: (json['data'] as List<dynamic>?)
//           ?.map((item) => OrderData.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class OrderData {
//   final String orderId;
//   final String orderStatus;
//   final DateTime createdAt;
//   final String date;

//   OrderData({
//     required this.orderId,
//     required this.orderStatus,
//     required this.createdAt,
//     required this.date,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     return OrderData(
//       orderId: json['order_id'] as String,
//       orderStatus: json['order_status'] as String,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       date: json['date'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'order_id': orderId,
//       'order_status': orderStatus,
//       'created_at': createdAt.toIso8601String(),
//       'date': date,
//     };
//   }
// }
