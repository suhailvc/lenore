import 'package:flutter/material.dart';

import 'package:lenore/application/provider/auth_provider/auth_provider.dart';

import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/sign_out_widget.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();
    if (token != null) {
      Provider.of<WishlistProvider>(context, listen: false)
          .fetchWishlist(token);
    } else {
      // Handle case where token is null, e.g., show an error or prompt login
      print("Token not available");
    }
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
            child: !Provider.of<AuthProvider>(context).hasToken
                ? Column(
                    children: [
                      customOneSizedBox(querySize),
                      customTopBar(querySize, context),
                      askSignIn(querySize),
                    ],
                  )
                : Consumer<WishlistProvider>(
                    builder: (context, wishlistProvider, child) {
                      if (wishlistProvider.isLoading &&
                          !wishlistProvider.isFirstLoadCompleted) {
                        // Show loading indicator only on the first load
                        return lenoreGif(querySize);
                      } else if (wishlistProvider.wishlist == null ||
                          wishlistProvider.wishlist!.data.isEmpty) {
                        return Center(child: Text('Your wishlist is empty.'));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customOneSizedBox(querySize),
                          customTopBar(querySize, context),
                          customSizedBox(querySize),
                          Text(
                            'Wishlist',
                            style: TextStyle(
                                color: const Color(0xFF008186),
                                fontSize: querySize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ElMessiri'),
                          ),
                          customSizedBox(querySize),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: wishlistProvider.wishlist!.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: querySize.height * 0.015,
                              childAspectRatio: 0.67,
                            ),
                            itemBuilder: (context, index) {
                              final item =
                                  wishlistProvider.wishlist!.data[index];
                              final isInWishlist =
                                  wishlistProvider.isProductInWishlist(item.id);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: querySize.height * 0.2,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE7E7E7),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(item.thumbImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: querySize.height * 0.008,
                                            right: querySize.height * 0.012,
                                          ),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final authProvider =
                                                  Provider.of<AuthProvider>(
                                                      context,
                                                      listen: false);
                                              final token =
                                                  await authProvider.getToken();
                                              if (token == null) {
                                                customSnackBar(
                                                    context, "Please SignIn");
                                                return;
                                              }
                                              // Toggle wishlist status for specific item
                                              await wishlistProvider
                                                  .toggleWishlist(
                                                      token, item.id);
                                            },
                                            child: CircleAvatar(
                                              radius: querySize.width * 0.03,
                                              backgroundColor: Colors.white,
                                              child: isInWishlist
                                                  ? Image.asset(
                                                      'assets/images/love (1).png',
                                                      width: querySize.width *
                                                          0.048,
                                                      height: querySize.height *
                                                          0.018,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/home/favourite.png',
                                                      width: querySize.width *
                                                          0.075,
                                                      height: querySize.height *
                                                          0.037,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: querySize.height * 0.01),
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontWeight: FontWeight.w600,
                                      fontSize: querySize.width * 0.03,
                                      color: const Color(0xFF353E4D),
                                    ),
                                  ),
                                  SizedBox(height: querySize.height * 0.007),
                                  Row(
                                    children: [
                                      Text(
                                        "QAR  ",
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      Text(
                                        item.price.toString(),
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        'assets/images/bag.png',
                                        width: querySize.width * 0.088,
                                        height: querySize.height * 0.028,
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

// class WishListScreen extends StatefulWidget {
//   const WishListScreen({super.key});

//   @override
//   State<WishListScreen> createState() => _WishListScreenState();
// }

// class _WishListScreenState extends State<WishListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _fetchWishlist();
//   }

//   Future<void> _fetchWishlist() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final token = await authProvider.getToken();
//     if (token != null) {
//       Provider.of<GetWishListProvider>(context, listen: false).fetchWishlist(
//         token,
//       );
//     } else {
//       // Handle case where token is null, e.g., show an error or prompt login
//       print("Token not available");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//           child: Consumer<GetWishListProvider>(
//               builder: (context, wishListValue, child) {
//             if (wishListValue.isLoading) {
//               return lenoreGif(querySize);
//             } else if (wishListValue.wishlist == null) {
//               return Text('empty');
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customOneSizedBox(querySize),
//                 customTopBar(querySize, context),
//                 customSizedBox(querySize),
//                 Text(
//                   'Wishlist',
//                   style: TextStyle(
//                       color: const Color(0xFF008186),
//                       fontSize: querySize.width * 0.05,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'ElMessiri'),
//                 ),
//                 customSizedBox(querySize),
//                 GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: wishListValue.wishlist!.data.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: querySize.height * 0.015,
//                     // mainAxisSpacing: querySize.height * 001,
//                     childAspectRatio: 0.67,
//                   ),
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           height: querySize.height * 0.2,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE7E7E7),
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                               image: NetworkImage(wishListValue
//                                   .wishlist!.data[index].thumbImage),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: querySize.height * 0.008,
//                                     right: querySize.height * 0.012),
//                                 child: CircleAvatar(
//                                   radius: querySize.width * 0.033,
//                                   backgroundColor: Colors.white,
//                                   child: Image.asset(
//                                     'assets/images/home/favourite.png',
//                                     width: querySize.width * 0.075,
//                                     height: querySize.height * 0.035,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: querySize.height * 0.01),
//                         Text(
//                           wishListValue.wishlist!.data[index].name,
//                           style: TextStyle(
//                             fontFamily: 'Segoe',
//                             fontWeight: FontWeight.w600,
//                             fontSize: querySize.width * 0.03,
//                             color: const Color(0xFF353E4D),
//                           ),
//                         ),
//                         SizedBox(
//                           height: querySize.height * 0.007,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               "QAR  ",
//                               style: TextStyle(
//                                 color: Color(0xFF000000),
//                                 fontSize: 10.0,
//                               ),
//                             ),
//                             Text(
//                               wishListValue.wishlist!.data[index].price
//                                   .toString(),
//                               style: TextStyle(
//                                 color: Color(0xFF000000),
//                                 fontSize: 13.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Spacer(),
//                             Image.asset(
//                               'assets/images/bag.png',
//                               width: querySize.width * 0.088,
//                               height: querySize.height * 0.028,
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             );
//           }),
//         ),
//       )),
//     );
//   }
// }
