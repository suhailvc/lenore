import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/collection_screen/collection_screen.dart';
import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';
import 'package:lenore/presentation/screens/gift_by_event_screen/gift_by_event_screen.dart';
import 'package:lenore/presentation/screens/gift_by_voucher_detail_screen.dart/gift_by_voucher_detail_screen.dart';
import 'package:lenore/presentation/screens/gift_by_voucher_screen/gift_by_voucher_screen.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_event_card.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_event_message_field.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_home_top_bar.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:lenore/presentation/screens/product_listng_screen/product_listing_screen.dart';
import 'package:lenore/presentation/screens/sub_category_screen/sub_category_screen.dart';
import 'package:lenore/presentation/screens/sub_category_screen/widget/sub_category_product_card.dart';
import 'package:lenore/presentation/widgets/cutom_bottom_bar_top_bar.dart';
import 'package:lenore/sample.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  int giftActiveIndex = 0;
  int collectionActiveIndex = 0;
  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: EdgeInsets.all(querySize.height * 0.02),
            child: Column(
              children: [
                customHomeTopBar(querySize, context),
                customSizedBox(querySize),
                // customEventMessageField(querySize),
                Column(
                  children: [
                    CarouselSlider.builder(
                        itemCount: homeBanner.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            margin:
                                EdgeInsets.only(right: querySize.width * 0.025),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  querySize.height * 0.01),
                              image: DecorationImage(
                                image: AssetImage(homeBanner[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                            viewportFraction: 1,
                            height: querySize.height * 0.24,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 4))),
                    SizedBox(
                      height: querySize.height * 0.01,
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: homeBanner.length,
                      effect: SlideEffect(
                          dotHeight: querySize.height * 0.008,
                          dotWidth: querySize.width * 0.018,
                          activeDotColor: appColor),
                    )
                  ],
                ),
                customSizedBox(querySize),
                giftByEventSection(querySize, context),
                customSizedBox(querySize),
                giftByCategorySection(querySize, context),
                customHeightThree(querySize),
                bestSellerNewArrivalSection(
                    querySize, "Best Seller", "All Best Sellers", context),
                customSizedBox(querySize),
                giftByVoucherSection(querySize, context),
                customSizedBox(querySize),
                bestSellerNewArrivalSection(
                    querySize, "New Arrivals", "All New Arrivals", context),
                customSizedBox(querySize),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeSectionTitle(querySize, 'Collection', context,
                        const CollectionScreen()),
                    customSizedBox(querySize),
                    Column(
                      children: [
                        CarouselSlider.builder(
                            itemCount: 5,
                            itemBuilder: (context, index, realIndex) {
                              return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductListingScreen(
                                                    productListingScreenName:
                                                        'Laura'),
                                          ));
                                    }
                                    if (index == 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProductListingScreen(
                                                      productListingScreenName:
                                                          "ZRI")));
                                    }
                                    if (index == 2) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductListingScreen(
                                                    productListingScreenName:
                                                        "WARDA"),
                                          ));
                                    }
                                    if (index == 3) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductListingScreen(
                                                    productListingScreenName:
                                                        "ZRI"),
                                          ));
                                    }
                                    if (index == 4) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductListingScreen(
                                                    productListingScreenName:
                                                        "WARDA"),
                                          ));
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: querySize.width * 0.025),
                                        width: 127.16 / 375.0 * querySize.width,
                                        height:
                                            108.7 / 812.0 * querySize.height,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                collectionListPhotos[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        collectionListName[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              13.69 / 375.0 * querySize.width,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Segoe',
                                          color: const Color(0xFF00ACB3),
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              const Color(0xFF00ACB3),
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                            options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    collectionActiveIndex = index;
                                  });
                                },
                                viewportFraction: querySize.width * 0.00087,
                                // viewportFraction: 1,
                                height: querySize.height * 0.18,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 4))),
                        AnimatedSmoothIndicator(
                          activeIndex: collectionActiveIndex,
                          count: 5,
                          effect: SlideEffect(
                              dotHeight: querySize.height * 0.008,
                              dotWidth: querySize.width * 0.018,
                              activeDotColor: appColor),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: 140.7 / 812.0 * querySize.height,
                    //   child: ListView.builder(
                    //     physics: const ScrollPhysics(
                    //         parent: BouncingScrollPhysics()),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: giftByCateogryListName.length,
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //           onTap: () {
                    //             if (index == 0) {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const ProductListingScreen(
                    //                             productListingScreenName:
                    //                                 'Laura'),
                    //                   ));
                    //             }
                    //             if (index == 1) {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           const ProductListingScreen(
                    //                               productListingScreenName:
                    //                                   "ZRI")));
                    //             }
                    //             if (index == 2) {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const ProductListingScreen(
                    //                             productListingScreenName:
                    //                                 "WARDA"),
                    //                   ));
                    //             }
                    //             if (index == 3) {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const ProductListingScreen(
                    //                             productListingScreenName:
                    //                                 "ZRI"),
                    //                   ));
                    //             }
                    //             if (index == 4) {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         const ProductListingScreen(
                    //                             productListingScreenName:
                    //                                 "WARDA"),
                    //                   ));
                    //             }
                    //           },
                    //           child: Column(
                    //             children: [
                    //               Container(
                    //                 margin: EdgeInsets.only(
                    //                     right: querySize.width * 0.025),
                    //                 width: 127.16 / 375.0 * querySize.width,
                    //                 height: 108.7 / 812.0 * querySize.height,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(12.0),
                    //                   image: DecorationImage(
                    //                     image: AssetImage(
                    //                         collectionListPhotos[index]),
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Text(
                    //                 collectionListName[index],
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                   fontSize: 13.69 / 375.0 * querySize.width,
                    //                   fontWeight: FontWeight.w500,
                    //                   fontFamily: 'Segoe',
                    //                   color: const Color(0xFF00ACB3),
                    //                   decoration: TextDecoration.underline,
                    //                   decorationColor: const Color(0xFF00ACB3),
                    //                 ),
                    //               ),
                    //             ],
                    //           ));
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ],
            )),
      )),
    );
  }

  Column giftByVoucherSection(Size querySize, BuildContext context) {
    return Column(
      children: [
        homeSectionTitle(
            querySize, "Gift by Voucher", context, const GiftByVoucherScreen()),
        customSizedBox(querySize),
        SizedBox(
          height: 0.15 * querySize.height,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GiftByVoucherDetailScreen(),
                      ));
                },
                child: Container(
                  width: querySize.width * 0.75,
                  height: querySize.height * 0.13,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Positioned(
                        left: querySize.height * 0.03,
                        top: querySize.height * 0.00,
                        child: Container(
                          width: querySize.width * 0.65,
                          height: querySize.height * 0.13,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(2, 3),
                              ),
                            ],
                            border: Border.all(
                              color: const Color(0xFFF3BC8B),
                              width: querySize.width * 0.008,
                            ),
                            color: const Color(0xFFFBE8DC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      Positioned(
                          left: querySize.height * 0,
                          top: querySize.height * 0.028,
                          child: Container(
                            width: querySize.height * 0.08,
                            height: querySize.height * 0.08,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFF3BC8B),
                                width: querySize.width * 0.008,
                              ),
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          )
                          // child: Container(
                          //   width: querySize.width * 0.15,
                          //   height: querySize.height * 0.15,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.only(
                          //       topRight: Radius.circular(60),
                          //       bottomRight: Radius.circular(60),
                          //     ),
                          //     border: Border.all(
                          //       color: Color(0xFFEDC298), // Border color
                          //       width: 3,
                          //     ),
                          //   ),
                          // ),
                          ),
                      Positioned(
                          left: querySize.height * 0.0,
                          top: querySize.height * 0.00,
                          child: Container(
                            color: Colors.white,
                            width: querySize.width * 0.06,
                            height: querySize.height * 0.15,
                          )),
                      Positioned(
                        left: querySize.width * 0.29,
                        top: querySize.width * 0.07,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1000 QR',
                              style: TextStyle(
                                  fontSize: querySize.height * 0.035,
                                  fontFamily: 'Segoe',
                                  color: const Color(0xFF00ACB3)),
                            ),
                            Text(
                              'Gift Voucher',
                              style: TextStyle(
                                  fontSize: querySize.height * 0.015,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Segoe',
                                  color: const Color(0xFF00ACB3)),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          left: querySize.width * 0.23,
                          top: querySize.width * 0.01,
                          child: DottedLine(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.center,
                            lineLength: querySize.height * 0.12,
                            lineThickness: querySize.width * 0.004,
                            dashLength: 4.0,
                            dashColor: const Color(0xFFFBE8DC),
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.black,
                            dashGapRadius: 0.0,
                          ))
                    ],
                  ),
                ),
              );
            },
            itemCount: 5,
          ),
        )
        // Container(
        //   width: querySize.width * 0.77,
        //   height: querySize.height * 0.15,
        //   decoration: BoxDecoration(
        //     color: const Color(0xFFFBE8DC),
        //     borderRadius: BorderRadius.circular(20),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black26,
        //         blurRadius: 6,
        //         offset: Offset(2, 4),
        //       ),
        //     ],
        //   ),
        //   child: Stack(
        //     children: [
        //       // Left Circular Cut-out
        //       Positioned(
        //         left: querySize.height * 0,
        //         top: querySize.height * 0.05,
        //         child: CircleAvatar(
        //           radius: querySize.height * 0.04,
        //           backgroundColor: Colors.white,
        //         ),
        //         // child: Container(
        //         //   width: querySize.width * 0.15,
        //         //   height: querySize.height * 0.15,
        //         //   decoration: BoxDecoration(
        //         //     color: Colors.white,
        //         //     borderRadius: BorderRadius.only(
        //         //       topRight: Radius.circular(60),
        //         //       bottomRight: Radius.circular(60),
        //         //     ),
        //         //     border: Border.all(
        //         //       color: Color(0xFFEDC298), // Border color
        //         //       width: 3,
        //         //     ),
        //         //   ),
        //         // ),
        //       ),
        //       // Dotted Line Divider
        //       Positioned(
        //         left: querySize.width * 0.22,
        //         top: 10,
        //         bottom: 10,
        //         child: Container(
        //           width: 1,
        //           color: Colors.brown,
        //           child: Column(
        //             mainAxisAlignment:
        //                 MainAxisAlignment.spaceBetween,
        //             children: List.generate(
        //               20,
        //               (index) => Container(
        //                 height: 2,
        //                 color: index % 2 == 0
        //                     ? Colors.brown
        //                     : Colors.transparent,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),

        //       Positioned(
        //         left: querySize.width * 0.28,
        //         top: querySize.height * 0.04,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               "1000 QR",
        //               style: TextStyle(
        //                 fontSize: querySize.height * 0.038,
        //                 color:
        //                     const Color(0xFF00ACB3), // Teal color
        //                 fontWeight: FontWeight.bold,
        //               ),
        //             ),
        //             //SizedBox(height: 10),
        //             Text(
        //               "Gift Voucher",
        //               style: TextStyle(
        //                 fontSize: querySize.height * 0.02,
        //                 color: Colors.black54,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Column bestSellerNewArrivalSection(
      Size querySize, sectionTitle, String buttonName, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        homeSectionTitle(querySize, sectionTitle, context,
            ProductListingScreen(productListingScreenName: sectionTitle)),
        customSizedBox(querySize),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
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
                            builder: (context) => const ProductDetailScreen(),
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
                            child: Image.asset(
                              index % 2 == 0
                                  ? "assets/images/wishlist_one.png"
                                  : "assets/images/wishlist_two.png",
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
                          child: GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: querySize.width * 0.033,
                              backgroundColor: Colors.white,
                              child: Image.asset(
                                'assets/images/home/favourite.png',
                                width: querySize.width * 0.075,
                                height: querySize.height * 0.035,
                              ),
                            ),
                          ),
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
                      "QAR",
                      style: TextStyle(
                        fontFamily: 'ElMessiri',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: querySize.width * 0.029,
                      ),
                    ),
                    Text(
                      " 756",
                      style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: querySize.width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Product | Name and Price Laura",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Segoe',
                    fontSize: querySize.width * 0.024,
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

  Row homeSectionTitle(Size querySize, String sectionTitle,
      BuildContext context, navigationScreenName) {
    return Row(
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
              color: const Color(0xFF008186),
              fontSize: querySize.width * 0.05,
              fontWeight: FontWeight.bold,
              fontFamily: 'ElMessiri'),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => navigationScreenName,
                ));
          },
          child: Text(
            "View More",
            style: TextStyle(
                color: const Color(0xFF00ACB3),
                fontSize: querySize.width * 0.033,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF00ACB3),
                fontFamily: 'Segoe'),
          ),
        ),
      ],
    );
  }

  Column giftByCategorySection(Size querySize, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Gift by category',
              style: TextStyle(
                  color: const Color(0xFF008186),
                  fontSize: querySize.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri'),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GiftByCategoryScreen(
                        widget: customBottomBarTopBar(querySize, context),
                      ),
                    ));
              },
              child: Text(
                "View More",
                style: TextStyle(
                    color: const Color(0xFF00ACB3),
                    fontSize: querySize.width * 0.033,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF00ACB3),
                    fontFamily: 'Segoe'),
              ),
            ),
          ],
        ),
        customSizedBox(querySize),
        Column(
          children: [
            CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (context, index, realIndex) {
                  return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubCategoryScreen(screenName: 'Diamond'),
                              ));
                        }
                        if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SubCategoryScreen(screenName: 'Gold')));
                        }
                        if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubCategoryScreen(screenName: 'Silver'),
                              ));
                        }
                        if (index == 3) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SubCategoryScreen(screenName: 'Pearl'),
                              ));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: querySize.width * 0.025),
                        width: 255.16 / 375.0 * querySize.width,
                        // height: 200.7 / 812.0 * querySize.height,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(querySize.height * 0.01),
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/home/diamond_earing.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              giftByCateogryListName[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.69 / 375.0 * querySize.width,
                                  fontFamily: 'NunitoSans',
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: querySize.height * 0.004,
                            )
                          ],
                        ),
                      ));
                },
                options: CarouselOptions(
                    viewportFraction: 0.45,
                    onPageChanged: (index, reason) {
                      setState(() {
                        giftActiveIndex = index;
                      });
                    },
                    height: querySize.height * 0.24,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4))),
            SizedBox(
              height: querySize.height * 0.01,
            ),
            AnimatedSmoothIndicator(
              activeIndex: giftActiveIndex,
              count: 5,
              effect: SlideEffect(
                  dotHeight: querySize.height * 0.008,
                  dotWidth: querySize.width * 0.018,
                  activeDotColor: appColor),
            )
          ],
        ),
        // SizedBox(
        //   height: 180.7 / 812.0 * querySize.height,
        //   child: ListView.builder(
        //     physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: giftByCateogryListName.length,
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //           onTap: () {
        //             // if (index == 0) {
        //             //   Navigator.push(
        //             //       context,
        //             //       MaterialPageRoute(
        //             //         builder: (context) => ,
        //             //       ));
        //             // }
        //             // if (index == 1) {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //       builder: (context) =>
        //             //
        //             //     ));
        //             // }
        //             // if (index == 2) {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //       builder: (context) => ,
        //             //     ));
        //             // }
        //             // if (index == 3) {
        //             // Navigator.push(
        //             //     context,
        //             //     MaterialPageRoute(
        //             //       builder: (context) =>
        //             //           ,
        //             //     ));
        //             //  }
        //           },
        //           child: Container(
        //             margin: EdgeInsets.only(right: querySize.width * 0.025),
        //             width: 150.16 / 375.0 * querySize.width,
        //             // height: 200.7 / 812.0 * querySize.height,
        //             decoration: BoxDecoration(
        //               borderRadius:
        //                   BorderRadius.circular(querySize.height * 0.01),
        //               image: const DecorationImage(
        //                 image:
        //                     AssetImage("assets/images/home/diamond_earing.png"),
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Text(
        //                   giftByCateogryListName[index],
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                       fontSize: 13.69 / 375.0 * querySize.width,
        //                       fontFamily: 'NunitoSans',
        //                       color: Colors.white),
        //                 ),
        //                 SizedBox(
        //                   height: querySize.height * 0.004,
        //                 )
        //               ],
        //             ),
        //           ));
        //     },
        //   ),
        // ),
      ],
    );
  }

  Column giftByEventSection(Size querySize, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Gift by event',
              style: TextStyle(
                  color: const Color(0xFF008186),
                  fontSize: querySize.width * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri'),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                //  GoRouter.of(context).push(NamedRoutes().giftByEvent.path);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GiftByEventScreen(),
                    ));
              },
              child: Text(
                "View More",
                style: TextStyle(
                    color: appColor,
                    fontSize: querySize.width * 0.033,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF00ACB3),
                    fontFamily: 'Segoe'),
              ),
            ),
          ],
        ),
        customSizedBox(querySize),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.1,
          children: [
            buildEventCard("assets/images/home/Birth Day.png", "Birthday",
                querySize, context),
            buildEventCard(
                "assets/images/home/ramdan.png", "Ramadan", querySize, context),
            buildEventCard("assets/images/home/New Born.png", "New Born",
                querySize, context),
            buildEventCard("assets/images/home/Graduation.png", "Graduation",
                querySize, context),
            buildEventCard(
                "assets/images/home/eid.png", "Eid", querySize, context),
            buildEventCard("assets/images/home/wedding.png", "Wedding",
                querySize, context),
            buildEventCard(
                "assets/images/home/omra.png", "Omra", querySize, context),
            buildEventCard("assets/images/home/thankyou.png", "Thank you",
                querySize, context),
          ],
        ),
        customHeightThree(querySize),
        Divider(
          color: const Color(0xFFFFD99D),
          endIndent: querySize.width * 0.09,
          indent: querySize.width * 0.09,
        ),
        customSizedBox(querySize),
      ],
    );
  }
}
