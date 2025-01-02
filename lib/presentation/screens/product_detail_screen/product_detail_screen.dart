import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';

import 'package:lenore/application/provider/product_detail_provider/product_detail_provider.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';
import 'package:lenore/domain/product_detail_model/product_detail_model.dart';
import 'package:lenore/presentation/screens/buy_now_check_out_screen/buy_now_check_out_screen.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/multiple_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({required this.productId, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int detailActiveIndex = 0;
  @override
  void initState() {
    print('---------------------------------${widget.productId}');
    // Initialize TabController in initState and use vsync: this
    _tabController = TabController(length: 2, vsync: this);
    Provider.of<ProductDetailProvider>(context, listen: false)
        .fetchProductDetails(id: widget.productId);
    _fetchWishlistStatus();
    super.initState();
  }

  Future<void> _fetchWishlistStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    if (token != null) {
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      await wishlistProvider.fetchWishlist(token);
    }
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('---------------------------------${widget.productId}');
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ProductDetailProvider>(
        builder: (context, productDetailProvidervalue, child) {
          if (productDetailProvidervalue.isLoading) {
            return multipleShimmerLoading(
                containerHeight: querySize.height * 0.06);
            // return lenoreGif(querySize);
          }
          if (productDetailProvidervalue.productDetails == null) {
            return Container(
              height: 200,
              width: 200,
              color: Colors.red,
            );
          }

          return Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(querySize.width * 0.03),
                        child: Column(
                          children: [
                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                            customTopBar(querySize, context),
                            customSizedBox(querySize),
                            Stack(
                              children: [
                                // CarouselSlider and other elements
                                CarouselSlider.builder(
                                  itemCount: productDetailProvidervalue
                                      .productDetails!.data!.images!.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: querySize.width * 0.025),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                querySize.height * 0.01),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  productDetailProvidervalue
                                                      .productDetails!
                                                      .data!
                                                      .images![index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: querySize.height * 0.025,
                                          right: querySize.height * 0.02,
                                          child: Row(
                                            children: [
                                              // CircleAvatar(
                                              //   radius: querySize.width * 0.033,
                                              //   backgroundColor: Colors.white,
                                              //   child: Image.asset(
                                              //     'assets/images/product_detail_image/share.png',
                                              //     width: querySize.width * 0.04,
                                              //     height:
                                              //         querySize.height * 0.017,
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //     width:
                                              //         querySize.width * 0.02),
                                              // Consumer2<GetWishListProvider,
                                              //     AddToWishlistProvider>(
                                              //   builder: (context,
                                              //       getWishListProvider,
                                              //       addToWishlistProvider,
                                              //       child) {
                                              //     final productId =
                                              //         productDetailProvidervalue
                                              //             .productDetails!
                                              //             .data!
                                              //             .id!;
                                              //     final isInWishlist =
                                              //         addToWishlistProvider
                                              //             .isProductInWishlist(
                                              //                 productId);

                                              //     return GestureDetector(
                                              //       onTap: () async {
                                              //         String token =
                                              //             await Provider.of<
                                              //                             AuthProvider>(
                                              //                         context,
                                              //                         listen:
                                              //                             false)
                                              //                     .getToken() ??
                                              //                 '';
                                              //         if (token.isEmpty) {
                                              //           customSnackBar(context,
                                              //               "Please Sign In");
                                              //         } else {
                                              //           // Add or remove from wishlist based on current state
                                              //           if (isInWishlist) {
                                              //             await addToWishlistProvider
                                              //                 .addToWishListProvider(
                                              //                     productId,
                                              //                     '0',
                                              //                     token);
                                              //           } else {
                                              //             await addToWishlistProvider
                                              //                 .addToWishListProvider(
                                              //                     productId,
                                              //                     '1',
                                              //                     token);
                                              //           }
                                              //         }
                                              //       },
                                              //       child: CircleAvatar(
                                              //         radius: querySize.width *
                                              //             0.033,
                                              //         backgroundColor:
                                              //             isInWishlist
                                              //                 ? Colors.red
                                              //                 : Colors.white,
                                              //         child: Image.asset(
                                              //           isInWishlist
                                              //               ? 'assets/images/app icon.png'
                                              //               : 'assets/images/home/favourite.png',
                                              //           width: querySize.width *
                                              //               0.075,
                                              //           height:
                                              //               querySize.height *
                                              //                   0.037,
                                              //         ),
                                              //       ),
                                              //     );
                                              //   },
                                              // )

                                              // Consumer<GetWishListProvider>(...............................................
                                              //     builder: (context,
                                              //         getWishListvalue, child) {
                                              //   return Consumer<
                                              //           AddToWishlistProvider>(
                                              //       builder: (context,
                                              //           wishlistValue, child) {
                                              //     return GestureDetector(
                                              //       onTap: () async {
                                              //         String token =
                                              //             await Provider.of<
                                              //                             AuthProvider>(
                                              //                         context,
                                              //                         listen:
                                              //                             false)
                                              //                     .getToken() ??
                                              //                 '';
                                              //         if (token == '') {
                                              //           return customSnackBar(
                                              //               context,
                                              //               "Please SignIn");
                                              //         } else if (getWishListvalue
                                              //                 .isProductInWishlist(
                                              //                     productDetailProvidervalue
                                              //                         .productDetails!
                                              //                         .data!
                                              //                         .id!) ==
                                              //             false)
                                              //           wishlistValue
                                              //               .addToWishListProvider(
                                              //                   productDetailProvidervalue
                                              //                       .productDetails!
                                              //                       .data!
                                              //                       .id!,
                                              //                   '1',
                                              //                   token);
                                              //         else if (getWishListvalue
                                              //                 .isProductInWishlist(
                                              //                     productDetailProvidervalue
                                              //                         .productDetails!
                                              //                         .data!
                                              //                         .id!) ==
                                              //             true)
                                              //           wishlistValue
                                              //               .addToWishListProvider(
                                              //                   productDetailProvidervalue
                                              //                       .productDetails!
                                              //                       .data!
                                              //                       .id!,
                                              //                   '0',
                                              //                   token);
                                              //         print('touched');
                                              //       },
                                              //       child: CircleAvatar(
                                              //         radius: querySize.width *
                                              //             0.033,
                                              //         backgroundColor:
                                              //             Colors.white,
                                              //         child: getWishListvalue
                                              //                     .isProductInWishlist(
                                              //                         productDetailProvidervalue
                                              //                             .productDetails!
                                              //                             .data!
                                              //                             .id!) ==
                                              //                 false
                                              //             ? Image.asset(
                                              //                 'assets/images/home/favourite.png',
                                              //                 width: querySize
                                              //                         .width *
                                              //                     0.075,
                                              //                 height: querySize
                                              //                         .height *
                                              //                     0.037,
                                              //               )
                                              //             : Image.asset(
                                              //                 'assets/images/app icon.png',
                                              //                 width: querySize
                                              //                         .width *
                                              //                     0.075,
                                              //                 height: querySize
                                              //                         .height *
                                              //                     0.037,
                                              //               ),
                                              //       ),
                                              //     );
                                              //   });
                                              // }),
                                              Consumer<WishlistProvider>(
                                                builder: (context,
                                                    wishlistProvider, child) {
                                                  // if (wishlistProvider
                                                  //     .isLoading) {
                                                  //   return CircularProgressIndicator();
                                                  // }
                                                  if (wishlistProvider
                                                          .errorMessage !=
                                                      null) {
                                                    return Text(
                                                        'Error: ${wishlistProvider.errorMessage}');
                                                  }

                                                  final isInWishlist =
                                                      wishlistProvider
                                                          .isProductInWishlist(
                                                              widget.productId);

                                                  return GestureDetector(
                                                    onTap: () async {
                                                      final authProvider =
                                                          Provider.of<
                                                                  AuthProvider>(
                                                              context,
                                                              listen: false);
                                                      final token =
                                                          await authProvider
                                                              .getToken();

                                                      if (token == null) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  "Please SignIn")),
                                                        );
                                                        return;
                                                      }

                                                      // Toggle wishlist status
                                                      await wishlistProvider
                                                          .toggleWishlist(token,
                                                              widget.productId);
                                                    },
                                                    child: CircleAvatar(
                                                      radius: querySize.width *
                                                          0.033,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: isInWishlist
                                                          ? Image.asset(
                                                              'assets/images/love (1).png',
                                                              width: querySize
                                                                      .width *
                                                                  0.048,
                                                              height: querySize
                                                                      .height *
                                                                  0.018,
                                                            )
                                                          : Image.asset(
                                                              'assets/images/home/favourite.png',
                                                              width: querySize
                                                                      .width *
                                                                  0.075,
                                                              height: querySize
                                                                      .height *
                                                                  0.037,
                                                            ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                  width:
                                                      querySize.width * 0.02),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        detailActiveIndex = index;
                                      });
                                    },
                                    viewportFraction: 1,
                                    height: querySize.height * 0.35,
                                    autoPlay: false,
                                    autoPlayInterval:
                                        const Duration(seconds: 4),
                                  ),
                                ),
                                // Indicator or other widgets
                                Positioned(
                                  bottom: querySize.height * 0.016,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: AnimatedSmoothIndicator(
                                      activeIndex: detailActiveIndex,
                                      count: productDetailProvidervalue
                                          .productDetails!.data!.images!.length,
                                      effect: SlideEffect(
                                        dotHeight: querySize.height * 0.008,
                                        dotWidth: querySize.width * 0.018,
                                        activeDotColor: appColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                            // Container(
                            //   width: querySize.width * 0.94,
                            //   height: querySize.width * 0.9,
                            //   decoration: BoxDecoration(
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black.withOpacity(0.3),
                            //         offset: const Offset(0, 4),
                            //         blurRadius: querySize.width * 0.008,
                            //         spreadRadius: 0,
                            //       ),
                            //     ],
                            //     color: const Color(0xFFE7E7E7),
                            //     borderRadius:
                            //         BorderRadius.circular(querySize.width * 0.02),
                            //     image: const DecorationImage(
                            //       image:
                            //           AssetImage("assets/images/wishlist_one.png"),
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
                            //         child: Row(
                            //           children: [
                            // Image.asset(
                            //   'assets/images/product_detail_image/share.png',
                            //   width: querySize.width * 0.04,
                            //   height: querySize.height * 0.017,
                            // ),
                            // SizedBox(
                            //   width: querySize.width * 0.03,
                            // ),
                            // Image.asset(
                            //   'assets/images/home/favourite.png',
                            //   width: querySize.width * 0.075,
                            //   height: querySize.height * 0.037,
                            // ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: querySize.width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'QAR ${productDetailProvidervalue.productDetails!.data!.price}',
                                  style: TextStyle(
                                      fontFamily: 'ElMessirisemibold',
                                      fontSize: querySize.height * 0.025,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                Container(
                                  width: querySize.width * 0.2,
                                  height: querySize.height * 0.03,
                                  decoration: BoxDecoration(
                                    color: const Color(0x4500ACB3),
                                    borderRadius: BorderRadius.circular(
                                        querySize.width * 0.013),
                                  ),
                                  child: Center(
                                      child: Text(
                                          productDetailProvidervalue
                                                      .productDetails!
                                                      .data!
                                                      .stock! >
                                                  0
                                              ? 'In Stock'
                                              : 'Out Of Stock',
                                          style: productDetailProvidervalue
                                                      .productDetails!
                                                      .data!
                                                      .stock! >
                                                  0
                                              ? TextStyle(
                                                  fontFamily: 'Segoe',
                                                  color: Color(0xFF5E5E5E))
                                              : TextStyle(
                                                  fontSize:
                                                      querySize.height * 0.013,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Segoe',
                                                  color: Color(0xFF5E5E5E)))),
                                )
                              ],
                            ),
                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                            Text(
                              productDetailProvidervalue
                                  .productDetails!.data!.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF008186),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.width * 0.047),
                            ),
                            TabBar(
                              labelColor: appColor,
                              unselectedLabelColor: Colors.black,
                              indicatorColor: const Color(0xFF929292),
                              dividerColor: Colors.black,
                              controller:
                                  _tabController, // Attach TabController here
                              tabs: const [
                                Tab(text: 'Details'),
                                Tab(text: 'Description'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: productDetailProvidervalue
                                    .productDetails!.data!.category!.name ==
                                'Diamond'
                            ? querySize.height * 0.32
                            : querySize.height * 0.28,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: querySize.width * 0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customSizedBox(querySize),
                                  productDetailProvidervalue.productDetails!
                                              .data!.category!.name !=
                                          'Diamond'
                                      ? Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: querySize.width * 0.27,
                                                  height:
                                                      querySize.height * 0.03,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(
                                                              0x7AF3C200)),
                                                  child: Center(
                                                      child: Text(
                                                    '${productDetailProvidervalue.productDetails!.data!.currentGoldRate![2].purity ?? ''}k   ${productDetailProvidervalue.productDetails!.data!.currentGoldRate![2].price} QR',
                                                    style: TextStyle(
                                                        fontSize:
                                                            querySize.width *
                                                                0.03,
                                                        fontFamily: 'Segoe',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: querySize.width * 0.03,
                                                ),
                                                Container(
                                                  width: querySize.width * 0.27,
                                                  height:
                                                      querySize.height * 0.03,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(
                                                              0x7AF3C200)),
                                                  child: Center(
                                                      child: Text(
                                                    '${productDetailProvidervalue.productDetails!.data!.currentGoldRate![1].purity}k   ${productDetailProvidervalue.productDetails!.data!.currentGoldRate![0].price} QR',
                                                    style: TextStyle(
                                                        fontSize:
                                                            querySize.width *
                                                                0.03,
                                                        fontFamily: 'Segoe',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: querySize.width * 0.03,
                                                ),
                                                Container(
                                                  width: querySize.width * 0.27,
                                                  height:
                                                      querySize.height * 0.03,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color(
                                                              0x7AF3C200)),
                                                  child: Center(
                                                      child: Text(
                                                    '${productDetailProvidervalue.productDetails!.data!.currentGoldRate![0].purity}k   ${productDetailProvidervalue.productDetails!.data!.currentGoldRate![0].price} QR',
                                                    style: TextStyle(
                                                        fontSize:
                                                            querySize.width *
                                                                0.03,
                                                        fontFamily: 'Segoe',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      : SizedBox(
                                          height: 0,
                                        ),
                                  productDetailProvidervalue.productDetails!
                                              .data!.category!.name !=
                                          'Diamond'
                                      ? customSizedBox(querySize)
                                      : SizedBox(),
                                  Row(
                                    children: [
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF5E5E5E),
                                            fontFamily: 'Segoe'),
                                      ),
                                      SizedBox(
                                        width: querySize.width * 0.132,
                                      ),
                                      Text(
                                        productDetailProvidervalue
                                            .productDetails!
                                            .data!
                                            .category!
                                            .name!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF000000),
                                            fontFamily: 'Segoe'),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Product Code",
                                        style: TextStyle(
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF5E5E5E),
                                            fontFamily: 'Segoe'),
                                      ),
                                      SizedBox(
                                        width: querySize.width * 0.06,
                                      ),
                                      Text(
                                        productDetailProvidervalue
                                                .productDetails!.data!.sku ??
                                            'N/A',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF000000),
                                            fontFamily: 'Segoe'),
                                      )
                                    ],
                                  ),
                                  customSizedBox(querySize),
                                  Text(
                                    'Product Details',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: querySize.width * 0.0344,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Segoe',
                                    ),
                                  ),
                                  customSizedBox(querySize),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .category!
                                                        .name !=
                                                    'Diamond'
                                                ? "Type"
                                                : "Gold Weight",
                                            style: TextStyle(
                                                fontSize:
                                                    querySize.width * 0.0344,
                                                color: const Color(0xFF5E5E5E),
                                                fontFamily: 'Segoe'),
                                          ),
                                          Text(
                                            productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .category!
                                                        .name !=
                                                    'Diamond'
                                                ? "${productDetailProvidervalue.productDetails!.data!.type ?? "N/A"}KT"
                                                : "${productDetailProvidervalue.productDetails!.data!.goldWeight ?? "N/A"} gm",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    querySize.width * 0.0344,
                                                color: const Color(0xFF000000),
                                                fontFamily: 'Segoe'),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: querySize.height * 0.049,
                                        child: VerticalDivider(
                                          color: Colors.grey,
                                          thickness: querySize.width * 0.002,
                                          width: querySize.width * 0.08,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Color",
                                            style: TextStyle(
                                                fontSize:
                                                    querySize.width * 0.0344,
                                                color: const Color(0xFF5E5E5E),
                                                fontFamily: 'Segoe'),
                                          ),
                                          Text(
                                            productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .category!
                                                        .name !=
                                                    'Diamond'
                                                ? productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .goldColour ??
                                                    'N/A'
                                                : productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .goldColour ??
                                                    "N/A",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    querySize.width * 0.0344,
                                                color: const Color(0xFF000000),
                                                fontFamily: 'Segoe'),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: querySize.height * 0.049,
                                        child: VerticalDivider(
                                          color: Colors.grey,
                                          thickness: querySize.width * 0.002,
                                          width: querySize.width * 0.08,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .category!
                                                        .name !=
                                                    'Diamond'
                                                ? "Weight"
                                                : "Gold Purity",
                                            style: TextStyle(
                                                fontSize:
                                                    querySize.width * 0.0344,
                                                color: const Color(0xFF5E5E5E),
                                                fontFamily: 'Segoe'),
                                          ),
                                          Text(
                                            productDetailProvidervalue
                                                        .productDetails!
                                                        .data!
                                                        .category!
                                                        .name !=
                                                    'Diamond'
                                                ? "${productDetailProvidervalue.productDetails!.data!.goldWeight ?? "N/A"} gm"
                                                : productDetailProvidervalue
                                                    .productDetails!
                                                    .data!
                                                    .goldPurity!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    querySize.width * 0.0344,
                                                color: const Color(0xFF000000),
                                                fontFamily: 'Segoe'),
                                          )
                                        ],
                                      ),
                                      productDetailProvidervalue.productDetails!
                                                  .data!.category!.name !=
                                              'Diamond'
                                          ? SizedBox(
                                              height: querySize.height * 0.049,
                                              child: VerticalDivider(
                                                color: Colors.grey,
                                                thickness:
                                                    querySize.width * 0.002,
                                                width: querySize.width * 0.08,
                                              ),
                                            )
                                          : SizedBox(),
                                      productDetailProvidervalue.productDetails!
                                                  .data!.category!.name !=
                                              'Diamond'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Making Charge",
                                                  style: TextStyle(
                                                      fontSize:
                                                          querySize.width *
                                                              0.0344,
                                                      color: const Color(
                                                          0xFF5E5E5E),
                                                      fontFamily: 'Segoe'),
                                                ),
                                                Text(
                                                  "${productDetailProvidervalue.productDetails!.data!.makingPrice ?? "N/A"} Qr",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          querySize.width *
                                                              0.0344,
                                                      color: const Color(
                                                          0xFF000000),
                                                      fontFamily: 'Segoe'),
                                                )
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                  customSizedBox(querySize),
                                  // Text(
                                  //   'Price Breakup',
                                  //   style: TextStyle(
                                  //     decoration: TextDecoration.underline,
                                  //     fontSize: querySize.width * 0.0344,
                                  //     color: const Color(0xFF000000),
                                  //     fontWeight: FontWeight.w600,
                                  //     fontFamily: 'Segoe',
                                  //   ),
                                  // ),
                                  customSizedBox(querySize),
                                  productDetailProvidervalue.productDetails!
                                              .data!.category!.name ==
                                          'Diamond'
                                      ? Row(
                                          //   mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Dimaond Weight",
                                                  style: TextStyle(
                                                      fontSize:
                                                          querySize.width *
                                                              0.03,
                                                      color: const Color(
                                                          0xFF5E5E5E),
                                                      fontFamily: 'Segoe'),
                                                ),
                                                Text(
                                                  "${productDetailProvidervalue.productDetails!.data!.diamondWeight ?? "N/A"} gm",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          querySize.width *
                                                              0.0344,
                                                      color: const Color(
                                                          0xFF000000),
                                                      fontFamily: 'Segoe'),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: querySize.height * 0.049,
                                              child: VerticalDivider(
                                                color: Colors.grey,
                                                thickness:
                                                    querySize.width * 0.002,
                                                width: querySize.width * 0.08,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Diamond Colour",
                                                  style: TextStyle(
                                                      fontSize:
                                                          querySize.width *
                                                              0.03,
                                                      color: const Color(
                                                          0xFF5E5E5E),
                                                      fontFamily: 'Segoe'),
                                                ),
                                                Text(
                                                  "${productDetailProvidervalue.productDetails!.data!.diamondColour ?? "N/A"}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          querySize.width *
                                                              0.0344,
                                                      color: const Color(
                                                          0xFF000000),
                                                      fontFamily: 'Segoe'),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: querySize.height * 0.049,
                                              child: VerticalDivider(
                                                color: Colors.grey,
                                                thickness:
                                                    querySize.width * 0.002,
                                                width: querySize.width * 0.08,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Diamond Clarity",
                                                  style: TextStyle(
                                                      fontSize:
                                                          querySize.width *
                                                              0.03,
                                                      color: const Color(
                                                          0xFF5E5E5E),
                                                      fontFamily: 'Segoe'),
                                                ),
                                                Text(
                                                  "${productDetailProvidervalue.productDetails!.data!.diamondClarity ?? "N/A"}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          querySize.width *
                                                              0.0344,
                                                      color: const Color(
                                                          0xFF000000),
                                                      fontFamily: 'Segoe'),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: querySize.width * 0.06),
                              child: Column(
                                children: [
                                  customSizedBox(querySize),
                                  Html(
                                    data: productDetailProvidervalue
                                            .productDetails!
                                            .data!
                                            .longDescription ??
                                        '',
                                    style: {
                                      "p": Style(
                                        fontSize:
                                            FontSize.small, // Set font size
                                        color: Colors.black, // Set text color
                                        textAlign:
                                            TextAlign.justify, // Align text
                                        fontFamily: 'Segoe',
                                      ),
                                      "h1": Style(
                                        // fontSize: FontSize.xLarge, // Larger font for h1
                                        fontWeight:
                                            FontWeight.bold, // Bold font weight
                                        color: Colors
                                            .blueAccent, // Different color for h1
                                      ),
                                      "a": Style(
                                        color: Colors.blue, // Link color
                                        textDecoration: TextDecoration
                                            .underline, // Underline links
                                      ),
                                      // fontSize: querySize.width * 0.03,
                                      // fontFamily: 'Segoe',
                                      // color: Colors.black,
                                      // fontWeight: FontWeight.w500,
                                    },
                                  ),
                                  // Text(
                                  //   productDetailProvidervalue.productDetails!
                                  //           .data!.longDescription ??
                                  //       "N/A",
                                  //   style: TextStyle(
                                  //       fontSize: querySize.width * 0.03,
                                  //       fontFamily: 'Segoe',
                                  //       color: Colors.black,
                                  //       fontWeight: FontWeight.w500),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: querySize.width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Similar Product",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF008186),
                                  fontFamily: 'ElMessiri',
                                  fontSize: querySize.width * 0.05),
                            ),
                            customSizedBox(querySize),
                            SizedBox(
                              // color: Colors.blueGrey,
                              height: 230.7 / 812.0 * querySize.height,
                              child: ListView.builder(
                                physics: const ScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                scrollDirection: Axis.horizontal,
                                itemCount: productDetailProvidervalue
                                    .productDetails!.relatedProducts!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailScreen(
                                                            productId: productDetailProvidervalue
                                                                .productDetails!
                                                                .relatedProducts![
                                                                    index]
                                                                .id!),
                                                  ));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right:
                                                      querySize.width * 0.025),
                                              width: 159.16 /
                                                  375.0 *
                                                  querySize.width,
                                              height: 178.7 /
                                                  812.0 *
                                                  querySize.height,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFE7E7E7),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      productDetailProvidervalue
                                                          .productDetails!
                                                          .relatedProducts![
                                                              index]
                                                          .thumbImage!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: querySize.height *
                                                            0.008,
                                                        right:
                                                            querySize.height *
                                                                0.012),
                                                    child: CircleAvatar(
                                                      radius: querySize.width *
                                                          0.033,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Image.asset(
                                                        'assets/images/home/favourite.png',
                                                        width: querySize.width *
                                                            0.075,
                                                        height:
                                                            querySize.height *
                                                                0.035,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: querySize.height * 0.01),
                                          Row(
                                            children: [
                                              Text(
                                                "QAR ",
                                                style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 10.0,
                                                ),
                                              ),
                                              Text(
                                                productDetailProvidervalue
                                                    .productDetails!
                                                    .relatedProducts![index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            productDetailProvidervalue
                                                    .productDetails!
                                                    .relatedProducts![index]
                                                    .name ??
                                                '',
                                            style: TextStyle(
                                              fontFamily: 'Segoebold',
                                              fontWeight: FontWeight.w600,
                                              fontSize: querySize.width * 0.026,
                                              //color: const Color(0xFF525252),
                                            ),
                                          ),
                                        ],
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: querySize.height * 0.12,
                      ),
                    ],
                  ),
                ),
              ),
              productDetailProvidervalue.productDetails!.data!.stock! > 0
                  ? Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: addToCartAndBuyNowButton(querySize, context,
                          productDetailProvidervalue.productDetails!),
                    )
                  : SizedBox(),
            ],
          );
        },
      ),
    );
  }

  Container addToCartAndBuyNowButton(
      Size querySize, BuildContext context, ProductDetailModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(querySize.width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              final cartItem = HiveCartModel(
                type: '1',
                productId: product.data!.id!,
                productName: product.data!.name ?? '',
                description: product.data!.sku ?? '',
                price: product.data!.price?.toDouble() ?? 0.0,
                size: 'Default Size',
                image: (product.data!.images != null &&
                        product.data!.images!.isNotEmpty)
                    ? product
                        .data!.images!.first // Use the first image if available
                    : 'assets/images/placeholder.png', // Default placeholder image
                stock: product.data!.stock ?? 0,
                quantity: 1,
              );

              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(cartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("${product.data!.name ?? ''} added to cart")),
              );
              // final cartItem = CartModel(
              //   productId: product.data!.id!,
              //   image: (product.data!.images != null &&
              //           product.data!.images!.isNotEmpty)
              //       ? product
              //           .data!.images!.first // Use the first image if available
              //       : 'assets/images/placeholder.png', // Provide a default placeholder image
              //   stock: product.data!.stock ?? 0,
              //   productName: product.data!.name ?? '',
              //   description: product.data!.sku ?? '',
              //   price: product.data!.price!.toDouble(),
              //   size: 'Default Size',
              // );

              // Provider.of<CartProvider>(context, listen: false)
              //     .addToCart(cartItem);
              // customSnackBar(
              //     context, "${product.data!.name ?? ''} added to cart");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008186),
              minimumSize: Size(
                MediaQuery.of(context).size.width * (137 / 375),
                MediaQuery.of(context).size.height * (42 / 812),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add to cart',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyNowCheckOutScreen(
                      productId: product.data!.id!,
                      quantity: 1,
                    ),
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008186),
              minimumSize: Size(
                MediaQuery.of(context).size.width * (137 / 375),
                MediaQuery.of(context).size.height * (42 / 812),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Buy Now',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  // Container addToCartAndBuyNowButton(
  //     Size querySize, BuildContext context, ProductDetailModel product) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.2),
  //           //spreadRadius: 0,
  //           blurRadius: 4,
  //           offset: const Offset(0, -5),
  //         ),
  //       ],
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     padding: EdgeInsets.all(querySize.width * 0.04),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         ElevatedButton(
  //           onPressed: () {
  //             final cartItem = CartModel(
  //               image: product.data!.images![1],
  //               stock: product.data!.stock ?? 0,
  //               productName: product.data!.name ?? '',
  //               description: product.data!.sku ?? '',
  //               price: product.data!.price!.toDouble(),
  //               size: 'Default Size',
  //             );
  //             Provider.of<CartProvider>(context, listen: false)
  //                 .addToCart(cartItem);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                   content: Text("${product.data!.name ?? ''} added to cart")),
  //             );
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xFF008186),
  //             minimumSize: Size(
  //               MediaQuery.of(context).size.width * (137 / 375),
  //               MediaQuery.of(context).size.height * (42 / 812),
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //           child: const Text(
  //             'Add to cart',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xFF008186),
  //             minimumSize: Size(
  //               MediaQuery.of(context).size.width * (137 / 375),
  //               MediaQuery.of(context).size.height * (42 / 812),
  //             ),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //           ),
  //           child: const Text(
  //             'Buy Now',
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
