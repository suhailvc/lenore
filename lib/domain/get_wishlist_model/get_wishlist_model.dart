class GetWishListModel {
  final bool status;
  final String message;
  final List<WishlistItem> data;

  GetWishListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetWishListModel.fromJson(Map<String, dynamic> json) {
    return GetWishListModel(
      status: json['status'],
      message: json['message'],
      data: List<WishlistItem>.from(
          json['data'].map((item) => WishlistItem.fromJson(item))),
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

class WishlistItem {
  final int id;
  final String name;
  final String? namear;
  final String thumbImage;
  final int price;

  WishlistItem({
    required this.id,
    required this.name,
    this.namear,
    required this.thumbImage,
    required this.price,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
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
