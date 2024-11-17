class FilterModel {
  bool status;
  String message;
  List<Product> data;
  int currentPage;
  int lastPage;
  int perPage;
  int total;

  FilterModel({
    required this.status,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      status: json['status'],
      message: json['message'],
      data: List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}

class Product {
  int id;
  String name;
  String? namear;
  String thumbImage;
  int price;

  Product({
    required this.id,
    required this.name,
    this.namear,
    required this.thumbImage,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      namear: json['namear'],
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
// class FilterModel {
//   bool status;
//   String message;
//   List<Data> data;

//   FilterModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory FilterModel.fromJson(Map<String, dynamic> json) {
//     return FilterModel(
//       status: json['status'],
//       message: json['message'],
//       data: List<Data>.from(json['data'].map((item) => Data.fromJson(item))),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class Data {
//   int id;
//   String name;
//   String? namear;
//   String thumbImage;
//   int price;

//   Data({
//     required this.id,
//     required this.name,
//     this.namear,
//     required this.thumbImage,
//     required this.price,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       id: json['id'],
//       name: json['name'],
//       namear: json['namear'],
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

//   @override
//   String toString() {
//     return 'Data(id: $id, name: $name, namear: $namear, thumbImage: $thumbImage, price: $price)';
//   }
// }
