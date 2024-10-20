import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/filter_screen/filter_screen.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class ProductListingScreen extends StatelessWidget {
  final String productListingScreenName;
  const ProductListingScreen(
      {required this.productListingScreenName, super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customOneSizedBox(querySize),
                Padding(
                  padding: EdgeInsets.only(
                      left: querySize.height * 0.014,
                      right: querySize.height * 0.014),
                  child: customTopBar(querySize, context),
                ),
                customSizedBox(querySize),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productListingScreenName,
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
                        itemCount: 8,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: querySize.height * 0.015,
                          // mainAxisSpacing: querySize.height * 001,
                          childAspectRatio: 0.8,
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
                                        builder: (context) =>
                                            const ProductDetailScreen(),
                                      ));
                                },
                                child: Container(
                                  height: querySize.height * 0.2,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE7E7E7),
                                    borderRadius: BorderRadius.circular(10),
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: querySize.height * 0.008,
                                            right: querySize.height * 0.012),
                                        child: CircleAvatar(
                                          radius: querySize.width * 0.033,
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            'assets/images/home/favourite.png',
                                            width: querySize.width * 0.075,
                                            height: querySize.height * 0.035,
                                          ),
                                        ),
                                        // Image.asset(
                                        //   'assets/images/home/favourite.png',
                                        //   width: querySize.width * 0.075,
                                        //   height: querySize.height * 0.035,
                                        // ),
                                      ),
                                    ],
                                  ),
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
                                  fontSize: querySize.width * 0.02,
                                  color: const Color(0xFF525252),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>,
                              //     ));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(querySize.width * 0.8,
                                  querySize.height * 0.05),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: querySize.width * 0.15,
                                vertical: querySize.height * 0.017,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  querySize.width * 0.08,
                                ),
                                side: BorderSide(
                                  color: const Color(0xFF00ACB3),
                                  width: querySize.height * 0.0018,
                                ),
                              ),
                            ),
                            child: Text(
                              "View More",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF00ACB3),
                                  fontSize: querySize.height * 0.017,
                                  fontFamily: 'Segoe'),
                            ),
                          )),
                      SizedBox(
                        height: querySize.height * 0.08,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: querySize.width * 0.5,
          height: querySize.height * 0.055,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(querySize.height * 0.03),
            ),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                showDragHandle: true,
                enableDrag: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(querySize.width * 0.05),
                  ),
                ),
                builder: (context) => const FilterScreen(),
              );
            },
            backgroundColor: const Color(0xFF00ACB3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/product_list/filter.png',
                  width: querySize.width * 0.06,
                ),
                SizedBox(
                  width: querySize.height * 0.01,
                ),
                const Text(
                  "Filter",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
