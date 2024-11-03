// import 'package:flutter/material.dart';
// import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
// import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
// import 'package:provider/provider.dart';

// Future<void> fetchWishlistStatus(BuildContext context, int productId) async {
//   final authProvider = Provider.of<AuthProvider>(context, listen: false);
//   final token = await authProvider.getToken();

//   if (token != null) {
//     final wishlistProvider =
//         Provider.of<WishlistProvider>(context, listen: false);
//     await wishlistProvider.checkProductInWishlist(token, productId);
//     await wishlistProvider.fetchWishlist(token);
//   }
// }
