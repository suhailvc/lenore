// class CartModel {
//   final int productId; // New property for product ID
//   final String productName;
//   final String description;
//   final double price;
//   final String size;
//   final String image; // Property for image URL or path
//   final int stock; // Property for stock quantity
//   int quantity;

//   CartModel({
//     required this.productId, // Initialize product ID
//     required this.productName,
//     required this.description,
//     required this.price,
//     required this.size,
//     required this.image,
//     required this.stock,
//     this.quantity = 1,
//   });

//   double get totalPrice => price * quantity;

//   void incrementQuantity() {
//     if (quantity < stock) {
//       quantity++;
//     }
//   }

//   void decrementQuantity() {
//     if (quantity > 1) {
//       quantity--;
//     }
//   }
// }
