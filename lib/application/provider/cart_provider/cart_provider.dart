import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';

class CartProvider with ChangeNotifier {
  List<HiveCartModel> _items = [];
  late Box<HiveCartModel> _cartBox;

  CartProvider() {
    _loadCart();
  }

  List<HiveCartModel> get items => _items;
  double get subTotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get totalVoucherDiscount =>
      _items.fold(0, (sum, item) => sum + item.totalVoucherDiscount);

  Future<void> _loadCart() async {
    _cartBox = Hive.box<HiveCartModel>('cartBox');
    _items = _cartBox.values.toList();
    notifyListeners();
  }

  bool isProductInCart(int productId) {
    return _items.any((item) => item.productId == productId);
  }

  void addToCart(HiveCartModel product) {
    final existingIndex =
        _items.indexWhere((item) => item.productId == product.productId);
    if (existingIndex != -1) {
      if (_items[existingIndex].quantity < _items[existingIndex].stock) {
        _items[existingIndex].incrementQuantity();
      }
    } else {
      _items.add(product);
      _cartBox.add(product);
    }
    notifyListeners();
  }

  void incrementItemQuantity(int index, BuildContext context) {
    if (_items[index].quantity < _items[index].stock) {
      _items[index].incrementQuantity();
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Out of stock",
              style: TextStyle(color: Colors.white),
            )),
      );
    }
  }

  void decrementItemQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].decrementQuantity();
    } else {
      _items[index].delete();
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartBox.clear();
    _items.clear();
    notifyListeners();
  }

  // Prepare cart data for API call
  List<Map<String, dynamic>> getCartDataForApi() {
    return _items.map((item) => item.toMap()).toList();
  }
}

// import 'package:flutter/material.dart';

// import 'package:hive/hive.dart';
// import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';

// class CartProvider with ChangeNotifier {
//   List<HiveCartModel> _items = [];
//   late Box<HiveCartModel> _cartBox;

//   CartProvider() {
//     _loadCart();
//   }

//   List<HiveCartModel> get items => _items;
//   double get subTotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

//   Future<void> _loadCart() async {
//     _cartBox = Hive.box<HiveCartModel>('cartBox');
//     _items = _cartBox.values.toList();
//     notifyListeners();
//   }

//   void addToCart(HiveCartModel product) {
//     final existingIndex =
//         _items.indexWhere((item) => item.productId == product.productId);
//     if (existingIndex != -1) {
//       if (_items[existingIndex].quantity < _items[existingIndex].stock) {
//         _items[existingIndex].incrementQuantity();
//       }
//     } else {
//       _items.add(product);
//       _cartBox.add(product); // Save new item to Hive
//     }
//     notifyListeners();
//   }

//   void incrementItemQuantity(int index) {
//     if (_items[index].quantity < _items[index].stock) {
//       _items[index].incrementQuantity();
//       notifyListeners();
//     }
//   }

//   void decrementItemQuantity(int index) {
//     if (_items[index].quantity > 1) {
//       _items[index].decrementQuantity();
//     } else {
//       _items[index].delete(); // Remove from Hive
//       _items.removeAt(index); // Remove from local list
//     }
//     notifyListeners();
//   }

//   void clearCart() {
//     _cartBox.clear(); // Clear Hive box
//     _items.clear(); // Clear local list
//     notifyListeners();
//   }
// }
