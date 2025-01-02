class OrderStatusModel {
  bool? status;
  String? message;
  Data? data;

  OrderStatusModel({this.status, this.message, this.data});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? orderStatus;

  Data({this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'];
  }
}
