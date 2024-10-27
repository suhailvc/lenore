class GiftByVoucherModel {
  bool? status;
  String? message;
  List<Data>? data;

  GiftByVoucherModel({this.status, this.message, this.data});

  GiftByVoucherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? namear;
  String? amount;

  Data({this.id, this.name, this.namear, this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    namear = json['namear'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['namear'] = this.namear;
    data['amount'] = this.amount;
    return data;
  }
}
