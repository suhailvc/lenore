class GoldPurityModel {
  bool status;
  String message;
  List<GoldData> data;

  GoldPurityModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GoldPurityModel.fromJson(Map<String, dynamic> json) {
    return GoldPurityModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => GoldData.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class GoldData {
  int id;
  String purity;
  double price;

  GoldData({
    required this.id,
    required this.purity,
    required this.price,
  });

  factory GoldData.fromJson(Map<String, dynamic> json) {
    return GoldData(
      id: json['id'] ?? 0,
      purity: json['purity'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'purity': purity,
      'price': price,
    };
  }
}
// class GoldData {
//   int id;
//   String purity;
//   double price;

//   GoldData({
//     required this.id,
//     required this.purity,
//     required this.price,
//   });

//   factory GoldData.fromJson(Map<String, dynamic> json) {
//     return GoldData(
//       id: json['id'] ?? 0,
//       purity: json['purity'] ?? '',
//       price: json['price'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'purity': purity,
//       'price': price,
//     };
//   }
// }
