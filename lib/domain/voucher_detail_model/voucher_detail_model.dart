class VoucherDetailModel {
  bool? status;
  String? message;
  List<VoucherData>? data;

  VoucherDetailModel({this.status, this.message, this.data});

  VoucherDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(VoucherData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VoucherData {
  int? id;
  String? voucherCode;
  String? name;
  String? namear;
  int? amount;
  String? description;
  String? descriptionar;
  String? image;
  double? discount;
  String? priceAfterDiscount; // Updated field as String

  VoucherData({
    this.id,
    this.voucherCode,
    this.name,
    this.namear,
    this.amount,
    this.description,
    this.descriptionar,
    this.image,
    this.discount,
    this.priceAfterDiscount,
  });

  VoucherData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherCode = json['voucher_code'];
    name = json['name'];
    namear = json['namear'];
    amount = json['amount'] is String
        ? int.tryParse(json['amount'])
        : json['amount'];
    description = json['description'];
    descriptionar = json['descriptionar'];
    image = json['image'];
    discount = json['discount'] is String
        ? double.tryParse(json['discount'])
        : json['discount'];
    priceAfterDiscount = json['price_after_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['voucher_code'] = voucherCode;
    data['name'] = name;
    data['namear'] = namear;
    data['amount'] = amount;
    data['description'] = description;
    data['descriptionar'] = descriptionar;
    data['image'] = image;
    data['discount'] = discount;
    data['price_after_discount'] =
        priceAfterDiscount; // Updated field as String
    return data;
  }
}
// class VoucherDetailModel {
//   bool? status;
//   String? message;
//   List<VoucherData>? data;

//   VoucherDetailModel({this.status, this.message, this.data});

//   VoucherDetailModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data!.add(VoucherData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class VoucherData {
//   int? id;
//   String? voucherCode;
//   String? name;
//   String? namear;
//   int? amount;
//   String? description;
//   String? descriptionar;
//   String? image;
//   double? discount;

//   VoucherData({
//     this.id,
//     this.voucherCode,
//     this.name,
//     this.namear,
//     this.amount,
//     this.description,
//     this.descriptionar,
//     this.image,
//     this.discount,
//   });

//   VoucherData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     voucherCode = json['voucher_code'];
//     name = json['name'];
//     namear = json['namear'];
//     amount = json['amount'] is String
//         ? int.tryParse(json['amount'])
//         : json['amount'];
//     description = json['description'];
//     descriptionar = json['descriptionar'];
//     image = json['image'];
//     discount = json['discount'] is String
//         ? double.tryParse(json['discount'])
//         : json['discount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['voucher_code'] = voucherCode;
//     data['name'] = name;
//     data['namear'] = namear;
//     data['amount'] = amount;
//     data['description'] = description;
//     data['descriptionar'] = descriptionar;
//     data['image'] = image;
//     data['discount'] = discount;
//     return data;
//   }
// }
// class VoucherDetailModel {
//   bool? status;
//   String? message;
//   List<VoucherData>? data;

//   VoucherDetailModel({this.status, this.message, this.data});

//   VoucherDetailModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data!.add(VoucherData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class VoucherData {
//   int? id;
//   String? voucherCode;
//   String? name;
//   String? namear;
//   int? amount;
//   String? description;
//   String? descriptionar;
//   String? image;

//   VoucherData({
//     this.id,
//     this.voucherCode,
//     this.name,
//     this.namear,
//     this.amount,
//     this.description,
//     this.descriptionar,
//     this.image,
//   });

//   VoucherData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     voucherCode = json['voucher_code'];
//     name = json['name'];
//     namear = json['namear'];
//     amount = json['amount'] is String
//         ? int.tryParse(json['amount'])
//         : json['amount'];
//     description = json['description'];
//     descriptionar = json['descriptionar'];
//     image = json['image'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = {};
//     data['id'] = id;
//     data['voucher_code'] = voucherCode;
//     data['name'] = name;
//     data['namear'] = namear;
//     data['amount'] = amount;
//     data['description'] = description;
//     data['descriptionar'] = descriptionar;
//     data['image'] = image;
//     return data;
//   }
// }
