class DeliveryFeeModel {
  final bool status;
  final String message;
  final DeliveryFeeData data;

  DeliveryFeeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeliveryFeeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryFeeModel(
      status: json['status'],
      message: json['message'],
      data: DeliveryFeeData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class DeliveryFeeData {
  final String value;

  DeliveryFeeData({
    required this.value,
  });

  factory DeliveryFeeData.fromJson(Map<String, dynamic> json) {
    return DeliveryFeeData(
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}
