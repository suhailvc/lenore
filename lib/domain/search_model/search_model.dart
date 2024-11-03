// class SearchModel {
//   final int id;
//   final String name;
//   final String? namear; // Make this nullable
//   final String thumbImage;
//   final int price;

//   SearchModel({
//     required this.id,
//     required this.name,
//     this.namear, // Nullable field
//     required this.thumbImage,
//     required this.price,
//   });

//   factory SearchModel.fromJson(Map<String, dynamic> json) {
//     return SearchModel(
//       id: json['id'],
//       name: json['name'],
//       namear: json['namear'], // Will be null if not present
//       thumbImage: json['thumb_image'],
//       price: json['price'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'namear': namear,
//       'thumb_image': thumbImage,
//       'price': price,
//     };
//   }
// }
class SearchModel {
  final bool status;
  final String message;
  final List<SearchData> data;

  SearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'],
      message: json['message'],
      data: List<SearchData>.from(
          json['data'].map((item) => SearchData.fromJson(item))),
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

class SearchData {
  final int id;
  final String name;
  final String? namear; // Make this nullable
  final String thumbImage;
  final int price;

  SearchData({
    required this.id,
    required this.name,
    this.namear, // Nullable field
    required this.thumbImage,
    required this.price,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
      id: json['id'],
      name: json['name'],
      namear: json['namear'], // Will be null if not present
      thumbImage: json['thumb_image'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'namear': namear,
      'thumb_image': thumbImage,
      'price': price,
    };
  }
}
