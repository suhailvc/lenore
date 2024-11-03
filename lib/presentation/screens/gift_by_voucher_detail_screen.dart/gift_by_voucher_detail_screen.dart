import 'package:flutter/material.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/application/provider/voucher_detail_provider/voucher_detail_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';
import 'package:lenore/domain/voucher_detail_model/voucher_detail_model.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class GiftByVoucherDetailScreen extends StatefulWidget {
  final int id;
  const GiftByVoucherDetailScreen({required this.id, super.key});

  @override
  State<GiftByVoucherDetailScreen> createState() =>
      _GiftByVoucherDetailScreenState();
}

class _GiftByVoucherDetailScreenState extends State<GiftByVoucherDetailScreen> {
  @override
  void initState() {
    Provider.of<VocherDetailProvider>(context, listen: false)
        .fetchVoucherDetail(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<VocherDetailProvider>(
          builder: (context, voucherValue, child) {
        if (voucherValue.isLoading) {
          return lenoreGif(querySize);
        }
        if (voucherValue.voucherDetail == null) {
          return lenoreGif(querySize);
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
                            Container(
                              margin: EdgeInsets.only(
                                  right: querySize.width * 0.025),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    querySize.height * 0.01),
                                image: DecorationImage(
                                  image: NetworkImage(voucherValue
                                      .voucherDetail!.data![0].image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: querySize.height * 0.3, // Set height
                              width: double.infinity, // Set width to fill
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
                                  SizedBox(width: querySize.width * 0.02),
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
                            )
                          ],
                        ),
                        SizedBox(height: querySize.height * 0.01),
                        buildDescriptionSection(
                            querySize, voucherValue.voucherDetail!),
                      ],
                    ),
                  ),
                  // buildSimilarProductsSection(querySize),
                  SizedBox(
                    height: querySize.height * 0.2,
                  ),
                ],
              )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: addToCartAndBuyNowButton(
                  querySize, context, voucherValue.voucherDetail!),
            ),
          ],
        );
      }),
    );
  }

  Widget buildDescriptionSection(Size querySize, VoucherDetailModel voucher) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.027),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QAR ${voucher.data![0].amount}',
            style: TextStyle(
              fontFamily: 'ElMessirisemibold',
              fontSize: querySize.height * 0.025,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: querySize.height * 0.003,
          ),
          Text(
            voucher.data![0].name!,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF008186),
                fontFamily: 'Segoe',
                fontSize: querySize.width * 0.047),
          ),
          customSizedBox(querySize),
          Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF008186),
              fontFamily: 'Segoe',
              fontSize: querySize.width * 0.04,
            ),
          ),
          SizedBox(
            height: querySize.height * 0.005,
          ),
          Html(
            data: voucher.data![0].description!,
            style: {
              "p": Style(
                fontSize: FontSize.medium, // Set font size
                color: Colors.black, // Set text color
                textAlign: TextAlign.justify, // Align text
                fontFamily: 'Segoe',
              ),
              "h1": Style(
                // fontSize: FontSize.xLarge, // Larger font for h1
                fontWeight: FontWeight.bold, // Bold font weight
                color: Colors.blueAccent, // Different color for h1
              ),
              "a": Style(
                color: Colors.blue, // Link color
                textDecoration: TextDecoration.underline, // Underline links
              ),
              // fontSize: querySize.width * 0.03,
              // fontFamily: 'Segoe',
              // color: Colors.black,
              // fontWeight: FontWeight.w500,
            },
          ),
        ],
      ),
    );
  }

  Widget buildSimilarProductsSection(Size querySize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Similar Product",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF008186),
              fontFamily: 'ElMessiri',
              fontSize: querySize.width * 0.05,
            ),
          ),
          SizedBox(height: querySize.height * 0.02),
          SizedBox(
            height: 230.7 / 812.0 * querySize.height,
            child: ListView.builder(
              physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Example count
              itemBuilder: (context, index) {
                return buildSimilarProductItem(querySize, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSimilarProductItem(Size querySize, int index) {
    return GestureDetector(
      onTap: () {
        // Handle item click
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: querySize.width * 0.025),
            width: 159.16 / 375.0 * querySize.width,
            height: 178.7 / 812.0 * querySize.height,
            decoration: BoxDecoration(
              color: const Color(0xFFE7E7E7),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: index % 2 == 0
                    ? const AssetImage("assets/images/wishlist_one.png")
                    : const AssetImage("assets/images/wishlist_two.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: querySize.height * 0.008,
                right: querySize.height * 0.012,
              ),
              child: Align(
                alignment: Alignment.topRight,
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
            ),
          ),
          SizedBox(height: querySize.height * 0.01),
          Row(
            children: const [
              Text(
                "QAR",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 10.0,
                ),
              ),
              Text(
                " 1000",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "Gift Voucher",
            style: TextStyle(
              fontFamily: 'Segoebold',
              fontWeight: FontWeight.w600,
              fontSize: querySize.width * 0.029,
            ),
          ),
        ],
      ),
    );
  }
}

Container addToCartAndBuyNowButton(
    Size querySize, BuildContext context, VoucherDetailModel voucher) {
  return Container(
    height: querySize.height * 0.085,
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
              type: '2',
              productId: voucher.data![0].id!,
              productName: voucher.data![0].name ?? '',
              description: '',
              price: voucher.data![0].amount!.toDouble(),
              size: 'Default Size',
              image: voucher.data![0].image!, // Default placeholder image
              stock: 10000,
              quantity: 1,
            );

            Provider.of<CartProvider>(context, listen: false)
                .addToCart(cartItem);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("voucher added to cart")),
            );
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

// class GiftByVoucherDetailScreen extends StatelessWidget {
//   const GiftByVoucherDetailScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
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
//                         SizedBox(
//                           height: querySize.height * 0.01,
//                         ),
//                         customTopBar(querySize, context),
//                         customSizedBox(querySize),
//                         Container(
//                           margin:
//                               EdgeInsets.only(right: querySize.width * 0.025),
//                           decoration: BoxDecoration(
//                             borderRadius:
//                                 BorderRadius.circular(querySize.height * 0.01),
//                             image: const DecorationImage(
//                               image:
//                                   AssetImage("assets/images/wishlist_one.png"),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: querySize.height * 0.025,
//                           right: querySize.height * 0.02,
//                           child: Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: querySize.width * 0.033,
//                                 backgroundColor: Colors.white,
//                                 child: Image.asset(
//                                   'assets/images/product_detail_image/share.png',
//                                   width: querySize.width * 0.04,
//                                   height: querySize.height * 0.017,
//                                 ),
//                               ),
//                               SizedBox(width: querySize.width * 0.02),
//                               CircleAvatar(
//                                 radius: querySize.width * 0.033,
//                                 backgroundColor: Colors.white,
//                                 child: Image.asset(
//                                   'assets/images/home/favourite.png',
//                                   width: querySize.width * 0.075,
//                                   height: querySize.height * 0.037,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: querySize.width * 0.06),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'QAR 100',
//                           style: TextStyle(
//                               fontFamily: 'ElMessirisemibold',
//                               fontSize: querySize.height * 0.025,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         SizedBox(
//                           height: querySize.height * 0.01,
//                         ),
//                         Text(
//                           'Description',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: const Color(0xFF008186),
//                               fontFamily: 'Segoe',
//                               fontSize: querySize.width * 0.047),
//                         ),
//                         Text(
//                           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop.",
//                           style: TextStyle(
//                               fontSize: querySize.width * 0.03,
//                               fontFamily: 'Segoe',
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         customSizedBox(querySize)
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: querySize.width * 0.06),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Similar Product",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFF008186),
//                               fontFamily: 'ElMessiri',
//                               fontSize: querySize.width * 0.05),
//                         ),
//                         customSizedBox(querySize),
//                         SizedBox(
//                           // color: Colors.blueGrey,
//                           height: 230.7 / 812.0 * querySize.height,
//                           child: ListView.builder(
//                             physics: const ScrollPhysics(
//                                 parent: BouncingScrollPhysics()),
//                             scrollDirection: Axis.horizontal,
//                             itemCount: giftByCateogryListName.length,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                   onTap: () {
//                                     // if (index == 0) {
//                                     //   Navigator.push(
//                                     //       context,
//                                     //       MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             const ProductListingScreen(
//                                     //                 productListingScreenName:
//                                     //                     'Laura'),
//                                     //       ));
//                                     // }
//                                     // if (index == 1) {
//                                     //   Navigator.push(
//                                     //       context,
//                                     //       MaterialPageRoute(
//                                     //           builder: (context) =>
//                                     //               const ProductListingScreen(
//                                     //                   productListingScreenName:
//                                     //                       "ZRI")));
//                                     // }
//                                     // if (index == 2) {
//                                     //   Navigator.push(
//                                     //       context,
//                                     //       MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             const ProductListingScreen(
//                                     //                 productListingScreenName:
//                                     //                     "WARDA"),
//                                     //       ));
//                                     // }
//                                     // if (index == 3) {
//                                     //   Navigator.push(
//                                     //       context,
//                                     //       MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             const ProductListingScreen(
//                                     //                 productListingScreenName:
//                                     //                     "ZRI"),
//                                     //       ));
//                                     // }
//                                     // if (index == 4) {
//                                     //   Navigator.push(
//                                     //       context,
//                                     //       MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             const ProductListingScreen(
//                                     //                 productListingScreenName:
//                                     //                     "WARDA"),
//                                     //       ));
//                                     // }
//                                   },
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         margin: EdgeInsets.only(
//                                             right: querySize.width * 0.025),
//                                         width: 159.16 / 375.0 * querySize.width,
//                                         height:
//                                             178.7 / 812.0 * querySize.height,
//                                         decoration: BoxDecoration(
//                                           color: const Color(0xFFE7E7E7),
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           image: DecorationImage(
//                                             image: index % 2 == 0
//                                                 ? const AssetImage(
//                                                     "assets/images/wishlist_one.png")
//                                                 : const AssetImage(
//                                                     "assets/images/wishlist_two.png"),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   top: querySize.height * 0.008,
//                                                   right:
//                                                       querySize.height * 0.012),
//                                               child: Image.asset(
//                                                 'assets/images/home/favourite.png',
//                                                 width: querySize.width * 0.075,
//                                                 height:
//                                                     querySize.height * 0.035,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: querySize.height * 0.01),
//                                       const Row(
//                                         children: [
//                                           Text(
//                                             "QAR",
//                                             style: TextStyle(
//                                               color: Color(0xFF000000),
//                                               fontSize: 10.0,
//                                             ),
//                                           ),
//                                           Text(
//                                             " 756",
//                                             style: TextStyle(
//                                               color: Color(0xFF000000),
//                                               fontSize: 13.0,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                         "Product | Name and Price Laura",
//                                         style: TextStyle(
//                                           fontFamily: 'Segoebold',
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: querySize.width * 0.026,
//                                           //color: const Color(0xFF525252),
//                                         ),
//                                       ),
//                                     ],
//                                   ));
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: querySize.height * 0.12,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: addToCartAndBuyNowButton(querySize, context),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Container addToCartAndBuyNowButton(Size querySize, BuildContext context) {
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
