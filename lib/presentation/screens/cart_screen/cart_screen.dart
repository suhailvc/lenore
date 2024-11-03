import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/cart_model/cart_model.dart';
import 'package:lenore/domain/hive_model/hive_cart_model/hive_cart_model.dart';
import 'package:lenore/presentation/screens/check_out_screen/check_out_screen.dart';
import 'package:lenore/presentation/widgets/cart_top_bar.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final TextEditingController _promoController = TextEditingController();
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: SafeArea(child:
            Consumer<CartProvider>(builder: (context, cartProvider, child) {
          //  return Consumer(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    customOneSizedBox(querySize),
                    cartTopBar(querySize, context, "Cart"),
                    // customTopBar(querySize, context),
                    SizedBox(
                      height: querySize.height * 0.03,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.items.length,
                      itemBuilder: (context, index) {
                        return customCartProductContainer(querySize,
                            cartProvider.items[index], context, cartProvider);
                      },
                    ),
                    // customCartProductContainer(querySize),
                    // SizedBox(
                    //   height: querySize.height * 0.03,
                    // ),
                    // customCartProductContainer(querySize),
                    // customHeightThree(querySize),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: querySize.width * (0.58),
                    //       height: querySize.height * 0.06,
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(
                    //               querySize.width * 0.03)),
                    //       child: TextFormField(
                    //         decoration: const InputDecoration(
                    //           hintText: "Enter Promo Code",
                    //           hintStyle: TextStyle(
                    //             color: Colors.grey,
                    //           ),
                    //           border: InputBorder.none,
                    //           contentPadding:
                    //               EdgeInsets.symmetric(horizontal: 16),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: querySize.height * 0.02,
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         // Navigator.push(
                    //         //     context,
                    //         //     MaterialPageRoute(
                    //         //       builder: (context) => const EditProfileScreen(),
                    //         //     ));
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: const Color(0xFF00ACB3),
                    //         minimumSize: Size(
                    //           querySize.width * 0.29,
                    //           querySize.height * 0.055,
                    //         ),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //       ),
                    //       child: const Text(
                    //         'Apply',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    customHeightThree(querySize),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.03)),
                      width: querySize.width * 0.9,
                      height: querySize.height * 0.2,
                      child: Padding(
                        padding: EdgeInsets.all(querySize.width * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Sub Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF201A25),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.02),
                                ),
                                const Spacer(),
                                Text(
                                  "QAR ${cartProvider.subTotal.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFC3C6C9),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.02),
                                ),
                              ],
                            ),
                            customSizedBox(querySize),
                            Row(
                              children: [
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF201A25),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.02),
                                ),
                                const Spacer(),
                                Text(
                                  "00",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFC3C6C9),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.02),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                            const Divider(),
                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF201A25),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.019),
                                ),
                                const Spacer(),
                                Text(
                                  "QAR ${cartProvider.subTotal.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF201A25),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.019),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    customHeightThree(querySize),
                    Container(
                      width: querySize.width * 0.9,
                      height: querySize.height * 0.15,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF6F7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(querySize.width * 0.04),
                          topRight: Radius.circular(querySize.width * 0.04),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(querySize.width * 0.04),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('total',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF667080),
                                        fontFamily: 'Segoe',
                                        fontSize: querySize.height * 0.021)),
                                Text(
                                    "QAR ${cartProvider.subTotal.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF667080),
                                        fontFamily: 'Segoe',
                                        fontSize: querySize.height * 0.022))
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () async {
                                if (!Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .hasToken) {
                                  return customSnackBar(
                                      context, "Please Login");
                                }
                                if (cartProvider.items.isEmpty) {
                                  return customSnackBar(
                                      context, 'Cart is empty');
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CheckOutScreen(),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00ACB3),
                                minimumSize: Size(
                                  querySize.width * (160 / 375),
                                  querySize.height * (48 / 812),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      querySize.width * 0.045),
                                ),
                              ),
                              child: const Text(
                                'Check Out',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
          // });
        })),
      ),
    );
  }

  Container customCartProductContainer(Size querySize, HiveCartModel item,
      BuildContext context, CartProvider cartProvider) {
    return Container(
      width: querySize.width,
      height: querySize.height * 0.17,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(querySize.width * 0.03)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(querySize.width * 0.03),
            child: Container(
              width: querySize.width * 0.3,
              height: querySize.width * 0.28,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(item.image), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(querySize.width * 0.02),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: querySize.height * 0.022),
              Text(
                item.productName.length > 20
                    ? '${item.productName.substring(0, 13)}...'
                    : item.productName,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF353E4D),
                    fontFamily: 'Segoe',
                    fontSize: querySize.height * 0.014),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              Text(
                item.description,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF353E4D),
                    fontFamily: 'Segoe',
                    fontSize: querySize.height * 0.0128),
              ),
              SizedBox(height: querySize.height * 0.01),
              Text(
                'QAR ${item.price}',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF667080),
                    fontFamily: 'Segoe',
                    fontSize: querySize.height * 0.016),
              ),
              SizedBox(height: querySize.height * 0.01),
            ],
          ),
          SizedBox(width: querySize.width * 0.03),
          Column(
            children: [
              SizedBox(height: querySize.height * 0.055),
              Row(
                children: [
                  SizedBox(width: querySize.width * 0.04),
                  GestureDetector(
                    onTap: () {
                      cartProvider.decrementItemQuantity(
                          cartProvider.items.indexOf(item));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF1F4),
                        shape: BoxShape.circle,
                      ),
                      width: querySize.width * 0.08,
                      height: querySize.width * 0.08,
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          size: querySize.width * 0.05,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: querySize.width * 0.02),
                  Text(
                    item.quantity.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFC3C6C9),
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.024),
                  ),
                  SizedBox(width: querySize.width * 0.02),
                  GestureDetector(
                    onTap: () {
                      cartProvider.incrementItemQuantity(
                          cartProvider.items.indexOf(item));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEF1F4),
                        shape: BoxShape.circle,
                      ),
                      width: querySize.width * 0.08,
                      height: querySize.width * 0.08,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: querySize.width * 0.05,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // Container customCartProductContainer(
  //     Size querySize, CartModel item, CartProvider cartProvider) {
  //   return Container(
  //     width: querySize.width * 1,
  //     height: querySize.height * 0.17,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(querySize.width * 0.03)),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.all(querySize.width * 0.03),
  //           child: Container(
  //             width: querySize.width * 0.3,
  //             height: querySize.width * 0.28,
  //             decoration: BoxDecoration(
  //               image: const DecorationImage(
  //                   image: AssetImage("assets/images/carts/cart_image.png"),
  //                   fit: BoxFit.cover),
  //               //  color: Colors.red,
  //               borderRadius: BorderRadius.circular(querySize.width * 0.01),
  //             ),
  //           ),
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: querySize.height * 0.022,
  //             ),
  //             Text(
  //               item.productName.length > 20
  //                   ? '${item.productName.substring(0, 13)}...'
  //                   : item.productName,
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   color: const Color(0xFF353E4D),
  //                   fontFamily: 'Segoe',
  //                   fontSize: querySize.height * 0.012),
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               softWrap: true,
  //             ),
  //             Text(
  //               item.description,
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   color: const Color(0xFF353E4D),
  //                   fontFamily: 'Segoe',
  //                   fontSize: querySize.height * 0.014),
  //             ),
  //             SizedBox(
  //               height: querySize.height * 0.01,
  //             ),
  //             Text(
  //               'QAR ${item.price}',
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w700,
  //                   color: const Color(0xFF667080),
  //                   fontFamily: 'Segoe',
  //                   fontSize: querySize.height * 0.016),
  //             ),
  //             SizedBox(
  //               height: querySize.height * 0.01,
  //             ),
  //             // Text(
  //             //   'Size: US 7',
  //             //   style: TextStyle(
  //             //       fontWeight: FontWeight.w600,
  //             //       color: const Color(0xFF353E4D),
  //             //       fontFamily: 'Segoe',
  //             //       fontSize: querySize.height * 0.014),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(
  //           width: querySize.width * 0.06,
  //         ),
  //         Column(
  //           children: [
  //             SizedBox(
  //               height: querySize.height * 0.055,
  //             ),
  //             Row(
  //               children: [
  //                 SizedBox(
  //                   width: querySize.width * 0.04,
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     cartProvider.decrementItemQuantity(
  //                         cartProvider.items.indexOf(item));
  //                   },
  //                   child: Container(
  //                     decoration: const BoxDecoration(
  //                       color: Color(0xFFEEF1F4),
  //                       shape: BoxShape.circle, // Makes the container circular
  //                     ),
  //                     width: querySize.width * 0.08, // Width of the circle
  //                     height: querySize.width *
  //                         0.08, // Height of the circle (same as width)
  //                     child: Center(
  //                       child: Icon(
  //                         Icons.remove,
  //                         size: querySize.width * 0.05,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: querySize.width * 0.03,
  //                 ),
  //                 Text(
  //                   item.quantity.toString(),
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.w600,
  //                       color: const Color(0xFFC3C6C9),
  //                       fontFamily: 'Segoe',
  //                       fontSize: querySize.height * 0.024),
  //                 ),
  //                 SizedBox(
  //                   width: querySize.width * 0.03,
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     cartProvider.incrementItemQuantity(
  //                         cartProvider.items.indexOf(item));
  //                   },
  //                   child: Container(
  //                     decoration: const BoxDecoration(
  //                       color: Color(0xFFEEF1F4),
  //                       shape: BoxShape.circle, // Makes the container circular
  //                     ),
  //                     width: querySize.width * 0.08, // Width of the circle
  //                     height: querySize.width *
  //                         0.08, // Height of the circle (same as width)
  //                     child: Center(
  //                       child: Icon(
  //                         Icons.add,
  //                         size: querySize.width * 0.05,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
