import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';

import 'package:lenore/application/provider/product_detail_provider/product_detail_provider.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';
import 'package:lenore/domain/product_detail_model/product_detail_model.dart';
import 'package:lenore/presentation/screens/check_out_screen/check_out_screen.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';

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
  ProductSize? selectedSize; // Only track the selected size
  @override
  void didUpdateWidget(ProductDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the productId has changed (e.g., when returning from a similar product)
    if (oldWidget.productId != widget.productId) {
      _resetAndFetchProduct();
    }
  }

// Add this method to your _ProductDetailScreenState class
  void _resetAndFetchProduct() {
    // Reset state
    setState(() {
      detailActiveIndex = 0;
      selectedSize = null;
    });

    // Clear previous data and fetch new product details
    Provider.of<ProductDetailProvider>(context, listen: false)
        .clearProductDetails();
    Provider.of<ProductDetailProvider>(context, listen: false)
        .fetchProductDetails(id: widget.productId)
        .then((_) {
      // After fetching product details, select the first size by default if available
      final productDetails =
          Provider.of<ProductDetailProvider>(context, listen: false)
              .productDetails;
      if (productDetails?.data?.sizes != null &&
          productDetails!.data!.sizes!.isNotEmpty) {
        setState(() {
          selectedSize = productDetails.data!.sizes!.first;
        });
      }
    });
    _fetchWishlistStatus();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetAndFetchProduct();
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this);
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<ProductDetailProvider>(context, listen: false)
  //         .clearProductDetails(); // Clear previous data
  //     Provider.of<ProductDetailProvider>(context, listen: false)
  //         .fetchProductDetails(id: widget.productId)
  //         .then((_) {
  //       // After fetching product details, select the first size by default if available
  //       final productDetails =
  //           Provider.of<ProductDetailProvider>(context, listen: false)
  //               .productDetails;
  //       if (productDetails?.data?.sizes != null &&
  //           productDetails!.data!.sizes!.isNotEmpty) {
  //         setState(() {
  //           selectedSize = productDetails.data!.sizes!.first;
  //         });
  //       }
  //     });
  //     _fetchWishlistStatus();
  //   });
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                                              Consumer<WishlistProvider>(
                                                builder: (context,
                                                    wishlistProvider, child) {
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
                                // Text(
                                //   'QAR ${(selectedSize?.addPrice ?? productDetailProvidervalue.productDetails!.data!.price)! + (selectedSize?.addMakingPrice != null ? selectedSize!.addMakingPrice : productDetailProvidervalue.productDetails!.data!.makingPrice)!}',
                                //   style: TextStyle(
                                //       fontFamily: 'ElMessirisemibold',
                                //       fontSize: querySize.height * 0.025,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text(
                                  'QAR ${selectedSize?.addPrice ?? productDetailProvidervalue.productDetails!.data!.price}',
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

                            // Size dropdown - Only show if sizes are available
                            // if (productDetailProvidervalue
                            //             .productDetails!.data!.sizes !=
                            //         null &&
                            //     productDetailProvidervalue
                            //         .productDetails!.data!.sizes!.isNotEmpty)
                            //   Padding(
                            //     padding: EdgeInsets.symmetric(
                            //         vertical: querySize.height * 0.01),
                            //     child: Row(
                            //       children: [
                            //         Text(
                            //           'Size:',
                            //           style: TextStyle(
                            //             fontFamily: 'Segoe',
                            //             fontSize: querySize.width * 0.04,
                            //             color: const Color(0xFF5E5E5E),
                            //           ),
                            //         ),
                            //         SizedBox(width: querySize.width * 0.02),
                            //         Container(
                            //           padding: EdgeInsets.symmetric(
                            //               horizontal: querySize.width * 0.02),
                            //           decoration: BoxDecoration(
                            //             border: Border.all(
                            //                 color: const Color(0xFF008186)),
                            //             borderRadius: BorderRadius.circular(
                            //                 querySize.width * 0.01),
                            //           ),
                            //           child: DropdownButton<ProductSize>(
                            //             underline: SizedBox(),
                            //             value: selectedSize,
                            //             hint: Text('Select Size'),
                            //             items: productDetailProvidervalue
                            //                 .productDetails!.data!.sizes!
                            //                 .map((size) =>
                            //                     DropdownMenuItem<ProductSize>(
                            //                       value: size,
                            //                       child: Text('${size.addKey}'),
                            //                     ))
                            //                 .toList(),
                            //             onChanged: (ProductSize? newSize) {
                            //               setState(() {
                            //                 selectedSize = newSize;
                            //               });
                            //             },
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),

                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productDetailProvidervalue
                                      .productDetails!.data!.name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF008186),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.width * 0.047),
                                ),
                                if (productDetailProvidervalue
                                            .productDetails!.data!.sizes !=
                                        null &&
                                    productDetailProvidervalue.productDetails!
                                        .data!.sizes!.isNotEmpty)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: querySize.height * 0.01),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Size:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontFamily: 'Segoe',
                                              fontSize: querySize.width * 0.04),
                                        ),
                                        SizedBox(width: querySize.width * 0.02),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  querySize.width * 0.01,
                                              vertical:
                                                  querySize.height * 0.003),
                                          height: querySize.height * 0.035,
                                          width: querySize.width *
                                              0.20, // Added fixed width
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF008186)),
                                            borderRadius: BorderRadius.circular(
                                                querySize.width * 0.01),
                                          ),
                                          child: DropdownButton<ProductSize>(
                                            isDense: true,
                                            isExpanded:
                                                true, // Makes dropdown fit the container width
                                            underline: SizedBox(),
                                            icon: Icon(Icons.arrow_drop_down,
                                                size: 19),
                                            value: selectedSize,
                                            hint: Text('Size',
                                                style: TextStyle(fontSize: 11)),
                                            items: productDetailProvidervalue
                                                .productDetails!.data!.sizes!
                                                .map((size) => DropdownMenuItem<
                                                        ProductSize>(
                                                      value: size,
                                                      child: Text(
                                                          '${size.addKey}',
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    ))
                                                .toList(),
                                            onChanged: (ProductSize? newSize) {
                                              setState(() {
                                                selectedSize = newSize;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              ],
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
                                                : "${selectedSize?.addWeight ?? productDetailProvidervalue.productDetails!.data!.goldWeight ?? "N/A"} gm",
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
                                                ? "${selectedSize?.addWeight ?? productDetailProvidervalue.productDetails!.data!.goldWeight ?? "N/A"} gm"
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
                                          ? // Update the part in ProductDetailScreen that displays making charge
                                          Column(
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
                                                  "${selectedSize?.addMakingPrice != null ? selectedSize!.addMakingPrice : productDetailProvidervalue.productDetails!.data!.makingPrice ?? "N/A"} Qr",
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
                                          // ? Column(
                                          //     crossAxisAlignment:
                                          //         CrossAxisAlignment.start,
                                          //     children: [
                                          //       Text(
                                          //         "Making Charge",
                                          //         style: TextStyle(
                                          //             fontSize:
                                          //                 querySize.width *
                                          //                     0.0344,
                                          //             color: const Color(
                                          //                 0xFF5E5E5E),
                                          //             fontFamily: 'Segoe'),
                                          //       ),
                                          //       Text(
                                          //         "${productDetailProvidervalue.productDetails!.data!.makingPrice ?? "N/A"} Qr",
                                          //         style: TextStyle(
                                          //             fontWeight:
                                          //                 FontWeight.w600,
                                          //             fontSize:
                                          //                 querySize.width *
                                          //                     0.0344,
                                          //             color: const Color(
                                          //                 0xFF000000),
                                          //             fontFamily: 'Segoe'),
                                          //       )
                                          //     ],
                                          //   )
                                          : SizedBox(),
                                    ],
                                  ),
                                  customSizedBox(querySize),
                                  customSizedBox(querySize),
                                  productDetailProvidervalue.productDetails!
                                              .data!.category!.name ==
                                          'Diamond'
                                      ? Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Diamond Weight",
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
                                    },
                                  ),
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
                                                      ChangeNotifierProvider(
                                                    create: (context) =>
                                                        ProductDetailProvider(),
                                                    child: ProductDetailScreen(
                                                      productId:
                                                          productDetailProvidervalue
                                                              .productDetails!
                                                              .relatedProducts![
                                                                  index]
                                                              .id!,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            // onTap: () {
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           ProductDetailScreen(
                                            //         productId:
                                            //             productDetailProvidervalue
                                            //                 .productDetails!
                                            //                 .relatedProducts![
                                            //                     index]
                                            //                 .id!,
                                            //       ),
                                            //     ),
                                            //   );
                                            // },
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
              // Only add to cart if not already there
              if (!Provider.of<CartProvider>(context, listen: false)
                  .isProductInCart(product.data!.id!)) {
                final cartItem = HiveCartModel(
                  type: '1',
                  productId: product.data!.id!,
                  productName: product.data!.name ?? '',
                  description: product.data!.sku ?? '',
                  price: selectedSize?.addPrice ??
                      product.data!.price?.toDouble() ??
                      0.0,
                  size: selectedSize?.addKey?.toString(),
                  image: (product.data!.images != null &&
                          product.data!.images!.isNotEmpty)
                      ? product.data!.images!.first
                      : 'assets/images/placeholder.png',
                  stock: product.data!.stock ?? 0,
                  quantity: 1,
                );

                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      backgroundColor: const Color(0xFF008186),
                      content: Text(
                        "${product.data!.name ?? ''} added to cart",
                        style: TextStyle(color: Colors.white),
                      )),
                );
              }
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
            child: Text(
              Provider.of<CartProvider>(context)
                      .isProductInCart(product.data!.id!)
                  ? 'Already added'
                  : 'Add to cart',
              style: TextStyle(color: Colors.white),
            ),
          ), // ElevatedButton(
          //   onPressed: () {
          //     final cartItem = HiveCartModel(
          //       type: '1',
          //       productId: product.data!.id!,
          //       productName: product.data!.name ?? '',
          //       description: product.data!.sku ?? '',
          //       price: selectedSize?.addPrice ??
          //           product.data!.price?.toDouble() ??
          //           0.0,
          //       size: selectedSize?.addKey?.toString(),
          //       image: (product.data!.images != null &&
          //               product.data!.images!.isNotEmpty)
          //           ? product.data!.images!.first
          //           : 'assets/images/placeholder.png',
          //       stock: product.data!.stock ?? 0,
          //       quantity: 1,
          //     );

          //     Provider.of<CartProvider>(context, listen: false)
          //         .addToCart(cartItem);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //           backgroundColor: const Color(0xFF008186),
          //           content: Text(
          //             "${product.data!.name ?? ''} added to cart",
          //             style: TextStyle(color: Colors.white),
          //           )),
          //     );
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFF008186),
          //     minimumSize: Size(
          //       MediaQuery.of(context).size.width * (137 / 375),
          //       MediaQuery.of(context).size.height * (42 / 812),
          //     ),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: const Text(
          //     'Add to cart',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              if (!Provider.of<AuthProvider>(context, listen: false).hasToken) {
                return customSnackBar(context, "Please Login");
              }
              final cartItem = HiveCartModel(
                type: '1',
                productId: product.data!.id!,
                productName: product.data!.name ?? '',
                description: product.data!.sku ?? '',
                price: selectedSize?.addPrice ??
                    product.data!.price?.toDouble() ??
                    0.0,
                size: selectedSize?.addKey?.toString(),
                image: (product.data!.images != null &&
                        product.data!.images!.isNotEmpty)
                    ? product.data!.images!.first
                    : 'assets/images/placeholder.png',
                stock: product.data!.stock ?? 0,
                quantity: 1,
              );
              if (Provider.of<CartProvider>(context, listen: false)
                  .isProductInCart(product.data!.id!)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutScreen(

                          //  size: selectedSize?.addKey,
                          //price: selectedSize?.addPrice,
                          ),
                    ));
              } else {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(cartItem);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutScreen(

                          //  size: selectedSize?.addKey,
                          //price: selectedSize?.addPrice,
                          ),
                    ));
              }
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => BuyNowCheckOutScreen(
              //         productId: product.data!.id!,
              //         quantity: 1,
              //         //  size: selectedSize?.addKey,
              //         //price: selectedSize?.addPrice,
              //       ),
              //     ));
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
}
