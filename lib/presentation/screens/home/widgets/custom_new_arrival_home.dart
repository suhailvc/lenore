import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';

import 'package:lenore/application/provider/new_aarival_provider/new_arrival_provider.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/best_seller_new_arrival_listing_screen/best_seller_new_arrival_listing_screen.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_home_section_title.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

customHomeNewArrivalSection(
    Size querySize, sectionTitle, String buttonName, BuildContext context,
    {NewArrivalProvider? newArrivalProvider}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      homeSectionTitle(
          querySize,
          sectionTitle,
          context,
          BestSellerNewArrivalListingScreen(
            eventName: 'new-arrivals',
            productListingScreenName: 'New Arrivals',
          )),
      customSizedBox(querySize),
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: newArrivalProvider!.productListItems.data!.length > 4
            ? 4
            : newArrivalProvider.productListItems.data!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: querySize.height * 0.017,
          //mainAxisSpacing: querySize.height * 001,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: newArrivalProvider
                                .productListItems.data![index].id!,
                          ),
                        ));
                  },
                  child: Stack(
                    children: [
                      Container(
                        height: querySize.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.04),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, 7),
                              blurRadius: querySize.width * 0.008,
                              spreadRadius: -2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.04),
                          child: Image.network(
                            newArrivalProvider
                                .productListItems.data![index].thumbImage!,
                            //.cachedResponse!.data![index] index % 2 == 0
                            //     ? "assets/images/wishlist_one.png"
                            //     : "assets/images/wishlist_two.png",
                            fit: BoxFit
                                .cover, // Ensure the image covers the entire container
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),

                      // Favorite icon positioned in the top right corner
                      Positioned(
                        top: querySize.height * 0.008,
                        right: querySize.height * 0.012,
                        child: Consumer<WishlistProvider>(
                          builder: (context, wishlistProvider, child) {
                            final isInWishlist = wishlistProvider
                                .isProductInWishlist(newArrivalProvider
                                    .productListItems.data![index].id!);

                            return GestureDetector(
                              onTap: () async {
                                final authProvider = Provider.of<AuthProvider>(
                                    context,
                                    listen: false);
                                final token = await authProvider.getToken();

                                if (token == null) {
                                  customSnackBar(context, 'Please SignIn');
                                  return;
                                }

                                // Toggle wishlist status for this specific product
                                await wishlistProvider.toggleWishlist(
                                    token,
                                    newArrivalProvider
                                        .productListItems.data![index].id!);
                              },
                              child: CircleAvatar(
                                radius: querySize.width * 0.033,
                                backgroundColor: Colors.white,
                                child: isInWishlist
                                    ? Image.asset(
                                        'assets/images/love (1).png',
                                        width: querySize.width * 0.048,
                                        height: querySize.height * 0.018,
                                      )
                                    : Image.asset(
                                        'assets/images/home/favourite.png',
                                        width: querySize.width * 0.075,
                                        height: querySize.height * 0.037,
                                      ),
                              ),
                            );
                          },
                        ),
                        // child: GestureDetector(
                        //   onTap: () {},
                        //   child: CircleAvatar(
                        //     radius: querySize.width * 0.033,
                        //     backgroundColor: Colors.white,
                        //     child: Image.asset(
                        //       'assets/images/home/favourite.png',
                        //       width: querySize.width * 0.075,
                        //       height: querySize.height * 0.035,
                        //     ),
                        //   ),
                        // ),
                        // child: Image.asset(
                        //   'assets/images/home/favourite.png',
                        //   width: querySize.width * 0.075,
                        //   height: querySize.height * 0.035,
                        // ),
                      ),
                    ],
                  )

                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(querySize.width * 0.04),
                  //   child: Container(
                  //     height: querySize.height * 0.2,
                  //     decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.3),
                  //           offset: const Offset(3, 4),
                  //           blurRadius: querySize.width * 2,
                  //           spreadRadius: querySize.width * 0.01,
                  //         ),
                  //       ],
                  //       color: Colors.white,
                  //       image: DecorationImage(
                  //         image: index % 2 == 0
                  //             ? const AssetImage(
                  //                 "assets/images/home/best seller one.png")
                  //             : const AssetImage(
                  //                 "assets/images/home/best seller two.png"),
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Padding(
                  //           padding: EdgeInsets.only(
                  //               top: querySize.height * 0.008,
                  //               right: querySize.height * 0.012),
                  //           child: Image.asset(
                  //             'assets/images/home/favourite.png',
                  //             width: querySize.width * 0.075,
                  //             height: querySize.height * 0.035,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // child: Container(
                  //   height: querySize.height * 0.2,
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.3),
                  //         offset: const Offset(0, 4),
                  //         blurRadius: querySize.width * 0.008,
                  //         spreadRadius: 0,
                  //       ),
                  //     ],
                  //     color: Colors.white,
                  //     borderRadius:
                  //         BorderRadius.circular(querySize.width * 0.04),
                  //     image: DecorationImage(
                  //       image: index % 2 == 0
                  //           ? const AssetImage(
                  //               "assets/images/home/best seller one.png")
                  //           : const AssetImage(
                  //               "assets/images/home/best seller two.png"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(
                  //             top: querySize.height * 0.008,
                  //             right: querySize.height * 0.012),
                  //         child: Image.asset(
                  //           'assets/images/home/favourite.png',
                  //           width: querySize.width * 0.075,
                  //           height: querySize.height * 0.035,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ),
              SizedBox(height: querySize.height * 0.01),
              Row(
                children: [
                  Text(
                    "QAR  ",
                    style: TextStyle(
                      fontFamily: 'ElMessiri',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: querySize.width * 0.029,
                    ),
                  ),
                  Text(
                    newArrivalProvider.productListItems.data![index].price
                        .toString(),
                    style: TextStyle(
                      color: const Color(0xFF000000),
                      fontSize: querySize.width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                newArrivalProvider.productListItems.data![index].name!,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Segoe',
                  fontSize: querySize.width * 0.027,
                  color: const Color(0xFF525252),
                ),
              ),
            ],
          );
        },
      ),
      // Align(
      //     alignment: Alignment.center,
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ProductListingScreen(
      //                   productListingScreenName: sectionTitle),
      //             ));
      //       },
      //       style: ElevatedButton.styleFrom(
      //         minimumSize:
      //             Size(querySize.width * 0.8, querySize.height * 0.06),
      //         backgroundColor: Colors.white,
      //         padding: EdgeInsets.symmetric(
      //           horizontal: querySize.width * 0.15,
      //           vertical: querySize.height * 0.02,
      //         ),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(
      //             querySize.width * 0.08,
      //           ),
      //           side: BorderSide(
      //             color: const Color(0xFF00ACB3),
      //             width: querySize.height * 0.0018,
      //           ),
      //         ),
      //       ),
      //       child: Text(
      //         buttonName,
      //         style: TextStyle(
      //             fontWeight: FontWeight.w600,
      //             color: const Color(0xFF00ACB3),
      //             fontSize: querySize.height * 0.017,
      //             fontFamily: 'Segoe'),
      //       ),
      //     )),
    ],
  );
}
