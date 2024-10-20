import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/product_detail_screen/widgets/contant.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int detailActiveIndex = 0;
  @override
  void initState() {
    super.initState();
    // Initialize TabController in initState and use vsync: this
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                              itemCount: productDetailImage.length,
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
                                          image: AssetImage(
                                              productDetailImage[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: querySize.height * 0.025,
                                      right: querySize.height * 0.02,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: querySize.width * 0.033,
                                            backgroundColor: Colors.white,
                                            child: Image.asset(
                                              'assets/images/product_detail_image/share.png',
                                              width: querySize.width * 0.04,
                                              height: querySize.height * 0.017,
                                            ),
                                          ),
                                          SizedBox(
                                              width: querySize.width * 0.02),
                                          CircleAvatar(
                                            radius: querySize.width * 0.033,
                                            backgroundColor: Colors.white,
                                            child: Image.asset(
                                              'assets/images/home/favourite.png',
                                              width: querySize.width * 0.075,
                                              height: querySize.height * 0.037,
                                            ),
                                          ),
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
                                autoPlayInterval: const Duration(seconds: 4),
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
                                  count: productDetailImage.length,
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
                              'QAR 756',
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
                              child: const Center(
                                  child: Text(
                                'In Stock',
                                style: TextStyle(
                                    fontFamily: 'Segoe',
                                    color: Color(0xFF5E5E5E)),
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Text(
                          'Product | Name and prices Laura',
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
                    height: querySize.height * 0.36,
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
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: querySize.width * 0.27,
                                        height: querySize.height * 0.03,
                                        decoration: const BoxDecoration(
                                            color: Color(0x7AF3C200)),
                                        child: Center(
                                            child: Text(
                                          '18k   318.50 QR',
                                          style: TextStyle(
                                              fontSize: querySize.width * 0.03,
                                              fontFamily: 'Segoe',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      SizedBox(
                                        width: querySize.width * 0.03,
                                      ),
                                      Container(
                                        width: querySize.width * 0.27,
                                        height: querySize.height * 0.03,
                                        decoration: const BoxDecoration(
                                            color: Color(0x7AF3C200)),
                                        child: Center(
                                            child: Text(
                                          '18k   318.50 QR',
                                          style: TextStyle(
                                              fontSize: querySize.width * 0.03,
                                              fontFamily: 'Segoe',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      ),
                                      SizedBox(
                                        width: querySize.width * 0.03,
                                      ),
                                      Container(
                                        width: querySize.width * 0.27,
                                        height: querySize.height * 0.03,
                                        decoration: const BoxDecoration(
                                            color: Color(0x7AF3C200)),
                                        child: Center(
                                            child: Text(
                                          '18k   318.50 QR',
                                          style: TextStyle(
                                              fontSize: querySize.width * 0.03,
                                              fontFamily: 'Segoe',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              customSizedBox(querySize),
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
                                    'Gold',
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
                                    '60702045',
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
                                        "Type",
                                        style: TextStyle(
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF5E5E5E),
                                            fontFamily: 'Segoe'),
                                      ),
                                      Text(
                                        "18KT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: querySize.width * 0.0344,
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
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF5E5E5E),
                                            fontFamily: 'Segoe'),
                                      ),
                                      Text(
                                        "Rose Gold",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF000000),
                                            fontFamily: 'Segoe'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              customSizedBox(querySize),
                              Text(
                                'Price Breakup',
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
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Weight",
                                        style: TextStyle(
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF5E5E5E),
                                            fontFamily: 'Segoe'),
                                      ),
                                      Text(
                                        "8 gm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: querySize.width * 0.0344,
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
                                        "Making Charge",
                                        style: TextStyle(
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF5E5E5E),
                                            fontFamily: 'Segoe'),
                                      ),
                                      Text(
                                        "40 Qr",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: querySize.width * 0.0344,
                                            color: const Color(0xFF000000),
                                            fontFamily: 'Segoe'),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: querySize.width * 0.06),
                          child: Column(
                            children: [
                              customSizedBox(querySize),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop.",
                                style: TextStyle(
                                    fontSize: querySize.width * 0.03,
                                    fontFamily: 'Segoe',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
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
                          // color: Colors.blueGrey,
                          height: 230.7 / 812.0 * querySize.height,
                          child: ListView.builder(
                            physics: const ScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            scrollDirection: Axis.horizontal,
                            itemCount: giftByCateogryListName.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    // if (index == 0) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const ProductListingScreen(
                                    //                 productListingScreenName:
                                    //                     'Laura'),
                                    //       ));
                                    // }
                                    // if (index == 1) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               const ProductListingScreen(
                                    //                   productListingScreenName:
                                    //                       "ZRI")));
                                    // }
                                    // if (index == 2) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const ProductListingScreen(
                                    //                 productListingScreenName:
                                    //                     "WARDA"),
                                    //       ));
                                    // }
                                    // if (index == 3) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const ProductListingScreen(
                                    //                 productListingScreenName:
                                    //                     "ZRI"),
                                    //       ));
                                    // }
                                    // if (index == 4) {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const ProductListingScreen(
                                    //                 productListingScreenName:
                                    //                     "WARDA"),
                                    //       ));
                                    // }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: querySize.width * 0.025),
                                        width: 159.16 / 375.0 * querySize.width,
                                        height:
                                            178.7 / 812.0 * querySize.height,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE7E7E7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: index % 2 == 0
                                                ? const AssetImage(
                                                    "assets/images/wishlist_one.png")
                                                : const AssetImage(
                                                    "assets/images/wishlist_two.png"),
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
                                                  top: querySize.height * 0.008,
                                                  right:
                                                      querySize.height * 0.012),
                                              child: Image.asset(
                                                'assets/images/home/favourite.png',
                                                width: querySize.width * 0.075,
                                                height:
                                                    querySize.height * 0.035,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: querySize.height * 0.01),
                                      const Row(
                                        children: [
                                          Text(
                                            "QAR",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            " 756",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Product | Name and Price Laura",
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: addToCartAndBuyNowButton(querySize, context),
          ),
        ],
      ),
    );
  }

  Container addToCartAndBuyNowButton(Size querySize, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            //spreadRadius: 0,
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
            onPressed: () {},
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
            onPressed: () {},
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
///////////////////import 'package:flutter/material.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/screens/home/widgets/custom_home_top_bar.dart';

// class ProductDetailScreen extends StatefulWidget {
//   const ProductDetailScreen({super.key});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize TabController in initState and use vsync: this
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     // Dispose of the TabController when the widget is disposed
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(querySize.width * 0.03),
//                     child: Column(
//                       children: [
//                         customHomeTopBar(querySize),
//                         customSizedBox(querySize),
//                         Container(
//                           width: querySize.width * 0.94,
//                           height: querySize.width * 0.9,
//                           decoration: const BoxDecoration(
//                               color: Colors.amber // Add your image here
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: querySize.width * 0.06),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'QAR 756',
//                               style: TextStyle(
//                                   fontFamily: 'ElMessirisemibold',
//                                   fontSize: querySize.height * 0.025,
//                                   fontWeight: FontWeight.w800),
//                             ),
//                             const Spacer(),
//                             Container(
//                               width: querySize.width * 0.2,
//                               height: querySize.height * 0.03,
//                               decoration: BoxDecoration(
//                                 color: Color(0x4500ACB3),
//                                 borderRadius: BorderRadius.circular(
//                                     querySize.width * 0.013),
//                               ),
//                               child: const Center(
//                                   child: Text(
//                                 'In Stock',
//                                 style: TextStyle(
//                                     fontFamily: 'Segoe',
//                                     color: Color(0xFF5E5E5E)),
//                               )),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: querySize.height * 0.01,
//                         ),
//                         Text(
//                           'Product | Name and prices Laura',
//                           style: TextStyle(
//                               color: const Color(0xFF008186),
//                               fontFamily: 'Segoebold',
//                               fontSize: querySize.width * 0.05),
//                         ),
//                         TabBar(
//                           controller:
//                               _tabController, // Attach TabController here
//                           tabs: const [
//                             Tab(text: 'Details'),
//                             Tab(text: 'Description'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: querySize.height * 0.36,
//                     child: TabBarView(
//                       controller: _tabController,
//                       children: [
//                         const Text(
//                             "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: querySize.width * 0.06),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               customSizedBox(querySize),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: querySize.width * 0.27,
//                                     height: querySize.height * 0.03,
//                                     decoration: const BoxDecoration(
//                                         color: Color(0x7AF3C200)),
//                                     child: Center(
//                                         child: Text(
//                                       '18k   318.50 QR',
//                                       style: TextStyle(
//                                           fontSize: querySize.width * 0.03,
//                                           fontFamily: 'Segoe',
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w600),
//                                     )),
//                                   ),
//                                   SizedBox(
//                                     width: querySize.width * 0.03,
//                                   ),
//                                   Container(
//                                     width: querySize.width * 0.27,
//                                     height: querySize.height * 0.03,
//                                     decoration: const BoxDecoration(
//                                         color: Color(0x7AF3C200)),
//                                     child: Center(
//                                         child: Text(
//                                       '18k   318.50 QR',
//                                       style: TextStyle(
//                                           fontSize: querySize.width * 0.03,
//                                           fontFamily: 'Segoe',
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w600),
//                                     )),
//                                   ),
//                                 ],
//                               ),
//                               customSizedBox(querySize),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Category",
//                                     style: TextStyle(
//                                         fontSize: querySize.width * 0.0344,
//                                         color: const Color(0xFF5E5E5E),
//                                         fontFamily: 'Segoe'),
//                                   ),
//                                   SizedBox(
//                                     width: querySize.width * 0.132,
//                                   ),
//                                   Text(
//                                     'Gold',
//                                     style: TextStyle(
//                                         fontSize: querySize.width * 0.0344,
//                                         color: const Color(0xFF000000),
//                                         fontFamily: 'Segoe'),
//                                   )
//                                 ],
//                               ),
//                               customSizedBox(querySize),
//                               Text(
//                                 'Product Details',
//                                 style: TextStyle(
//                                   decoration: TextDecoration.underline,
//                                   fontSize: querySize.width * 0.0344,
//                                   color: const Color(0xFF000000),
//                                   fontFamily: 'Segoe',
//                                 ),
//                               ),
//                               customSizedBox(querySize),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Buttons that remain fixed at the bottom
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: EdgeInsets.all(querySize.width * 0.04),
//               color: Colors.white, // Background color for the button section
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       // Add to cart action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Button color
//                       padding: EdgeInsets.symmetric(
//                         vertical: querySize.height * 0.02,
//                         horizontal: querySize.width * 0.18,
//                       ),
//                     ),
//                     child: const Text('Add to cart'),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Buy now action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green, // Button color
//                       padding: EdgeInsets.symmetric(
//                         vertical: querySize.height * 0.02,
//                         horizontal: querySize.width * 0.18,
//                       ),
//                     ),
//                     child: const Text('Buy Now'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
