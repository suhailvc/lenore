// import 'package:hive/hive.dart';

// part 'hive_cart_model.g.dart';

// @HiveType(typeId: 0)
// class HiveCartModel extends HiveObject {
//   @HiveField(0)
//   final int productId;

//   @HiveField(1)
//   final String productName;

//   @HiveField(2)
//   final String description;

//   @HiveField(3)
//   final double price;

//   @HiveField(4)
//   final String size;

//   @HiveField(5)
//   final String image;

//   @HiveField(6)
//   final int stock;

//   @HiveField(7)
//   int quantity;

//   HiveCartModel({
//     required this.productId,
//     required this.productName,
//     required this.description,
//     required this.price,
//     required this.size,
//     required this.image,
//     required this.stock,
//     this.quantity = 1,
//   });

//   double get totalPrice => price * quantity;

//   // Convert this model to a map for the API
//   Map<String, dynamic> toMap() {
//     return {
//       "id": productId,
//       "product_id": productId,
//       "quantity": quantity,
//       "price": price,
//       "type": 1, // Assuming 'type' is always 1 for your use case
//     };
//   }

//   void incrementQuantity() {
//     if (quantity < stock) {
//       quantity++;
//       save();
//     }
//   }

//   void decrementQuantity() {
//     if (quantity > 1) {
//       quantity--;
//       save();
//     } else {
//       delete();
//     }
//   }
// }
import 'package:hive/hive.dart';

part 'hive_cart_model.g.dart';

@HiveType(typeId: 0)
class HiveCartModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String size;

  @HiveField(5)
  final String image;

  @HiveField(6)
  final int stock;

  @HiveField(7)
  int quantity;

  @HiveField(8)
  final String type; // Required String field without default

  HiveCartModel({
    required this.productId,
    required this.productName,
    required this.description,
    required this.price,
    required this.size,
    required this.image,
    required this.stock,
    required this.type, // Marked as required
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  // Convert this model to a map for the API
  Map<String, dynamic> toMap() {
    return {
      "id": productId,
      "product_id": productId,
      "quantity": quantity,
      "price": price,
      "type": type,
    };
  }

  void incrementQuantity() {
    if (quantity < stock) {
      quantity++;
      save();
    }
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      save();
    } else {
      delete();
    }
  }
}
