import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
import 'package:lenore/presentation/screens/my_fatoorah_screen/fatoorah_payment_screen.dart';
import 'package:lenore/presentation/screens/payment_success_screen/payment_success_screen.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PaymentScreen extends StatefulWidget {
  final String addressId;
  const PaymentScreen({required this.addressId, super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController couponController = TextEditingController();
  double discount = 0.0;
  bool isCouponApplied = false;
  String errorMessage = '';
  //double deliveryFee = 10.0;

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  Future<void> applyCoupon(
      CartProvider cartProvider, CouponProvider couponProvider) async {
    final couponCode = couponController.text.trim();
    if (couponCode.isNotEmpty) {
      await couponProvider.fetchCouponData(couponCode);
      if (couponProvider.couponData != null) {
        setState(() {
          isCouponApplied = true;
          errorMessage = '';
          final offerType = couponProvider.couponData!['offer_type'];
          final discountValue =
              (couponProvider.couponData!['discount'] as int).toDouble();
          discount = (offerType == 'percentage')
              ? cartProvider.subTotal * (discountValue / 100)
              : discountValue;
          if (discount > cartProvider.subTotal) {
            customSnackBar(context, 'You are not eligible');
            discount = 0;
          }
        });
      } else {
        setState(() {
          isCouponApplied = false;
          errorMessage = 'Invalid promo code';
          discount = 0.0;
        });
      }
    }
  }

  void removeCoupon(CouponProvider couponProvider) {
    setState(() {
      isCouponApplied = false;
      discount = 0.0;
      errorMessage = '';
      couponProvider.clearCouponData();
      couponController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.06),
          child: SingleChildScrollView(
            child: Consumer<CartProvider>(builder: (context, cartValue, child) {
              return Consumer<CheckOutProvider>(
                builder: (context, checkoutValue, child) {
                  return Consumer<CouponProvider>(
                    builder: (context, couponProvider, child) {
                      double subTotal = cartValue.subTotal.toDouble();
                      print("----------------$subTotal");
                      print("----------------$discount");
                      print(
                          "----------------${double.parse(globalDeliveryFee)}");
                      double totalAmount = subTotal -
                          cartValue.totalVoucherDiscount -
                          (discount + double.parse(globalDeliveryFee));

                      String couponCode = couponController.text.trim();
                      int quantity = cartValue.items
                          .fold(0, (sum, item) => sum + item.quantity);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customSizedBox(querySize),
                          customProfileTopBar(querySize, context, "Payment"),
                          customSizedBox(querySize),
                          Text(
                            "Delivery Address",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: querySize.width * 0.037,
                              color: const Color(0xFF667080),
                              fontFamily: 'Seogoe',
                            ),
                          ),
                          customSizedBox(querySize),
                          Container(
                            width: querySize.width * 0.88,
                            height: querySize.height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(querySize.width * 0.03),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(querySize.width * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/tick-icon.png',
                                        width: querySize.width * 0.053,
                                        height: querySize.width * 0.053,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: querySize.height * 0.02),
                                  Text(
                                    checkoutValue.list!.myName,
                                    style: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.width * 0.039,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF858585),
                                    ),
                                  ),
                                  SizedBox(height: querySize.height * 0.01),
                                  Text(
                                    "+971 ${checkoutValue.list!.myPhone}",
                                    style: TextStyle(
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.width * 0.037,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF858585),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          customSizedBox(querySize),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: querySize.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        querySize.width * 0.03),
                                  ),
                                  child: TextFormField(
                                    controller: couponController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Promo Code",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: querySize.height * 0.02),
                              isCouponApplied
                                  ? ElevatedButton(
                                      onPressed: () =>
                                          removeCoupon(couponProvider),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        minimumSize: Size(
                                          querySize.width * 0.26,
                                          querySize.height * 0.055,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () => applyCoupon(
                                          cartValue, couponProvider),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF00ACB3),
                                        minimumSize: Size(
                                          querySize.width * 0.26,
                                          querySize.height * 0.055,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Apply',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                            ],
                          ),
                          if (errorMessage.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: querySize.width * 0.035,
                                ),
                              ),
                            ),
                          customSizedBox(querySize),
                          Text(
                            "Payment",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: querySize.width * 0.037,
                              color: const Color(0xFF667080),
                              fontFamily: 'Seogoe',
                            ),
                          ),
                          customSizedBox(querySize),
                          Container(
                            padding: EdgeInsets.all(querySize.width * 0.046),
                            width: querySize.width * 0.9,
                            height: querySize.height * 0.23,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(querySize.width * 0.03),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Amount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${cartValue.subTotal} QAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFC3C6C9),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: querySize.height * 0.01),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Voucher Discount",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w600,
                                //           color: const Color(0xFF667080),
                                //           fontFamily: 'Segoe',
                                //           fontSize: querySize.height * 0.017),
                                //     ),
                                //     const Spacer(),
                                //     Text(
                                //       "${cartValue.subTotal} QAR",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.w600,
                                //           color: const Color(0xFFC3C6C9),
                                //           fontFamily: 'Segoe',
                                //           fontSize: querySize.height * 0.017),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: querySize.height * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      "Voucher Discount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "-${cartValue.totalVoucherDiscount} QAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFC3C6C9),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                  ],
                                ),

                                SizedBox(height: querySize.height * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      "Discount",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "-${discount.toStringAsFixed(2)} QAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFC3C6C9),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                  ],
                                ),
                                SizedBox(height: querySize.height * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      "Delivery Fee",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                    const Spacer(),
                                    Text(
                                      globalDeliveryFee, // "${deliveryFee.toStringAsFixed(2)} QAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFC3C6C9),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.017),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.019),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "${totalAmount.toStringAsFixed(2)} QAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.019),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: querySize.height * 0.04),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: querySize.width * 0.058),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF667080),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.021),
                                    ),
                                    Text(
                                      'QAR ${totalAmount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF00ACB3),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.height * 0.022),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => CardPaymentScreen(
                                    //       totalAmount: totalAmount,
                                    //     ),
                                    //   ),
                                    // );
                                    String token =
                                        await Provider.of<AuthProvider>(context,
                                                    listen: false)
                                                .getToken() ??
                                            '';
                                    print(token);
                                    int? result =
                                        await Provider.of<PaymentProvider>(
                                                context,
                                                listen: false)
                                            .placeOrder(
                                      token: token,
                                      addressId: widget.addressId,
                                      paymentMethod: 'card',
                                      cart: cartValue.getCartDataForApi(),
                                      totalAmount: totalAmount,
                                      discount: discount,
                                      couponCode: couponCode,
                                      deliveryCharge:
                                          double.parse(globalDeliveryFee),
                                      quantity: quantity,
                                    );
                                    if (result != null) {
                                      cartValue.clearCart();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CardPaymentScreen(
                                            context: context,
                                            token: token,
                                            orderId: result,
                                            totalAmount: totalAmount,
                                          ),
                                        ),
                                      );
                                      // PersistentNavBarNavigator.pushNewScreen(
                                      //   context,
                                      //   screen: PaymentSuccessScreen(),
                                      //   withNavBar: false,
                                      //   pageTransitionAnimation:
                                      //       PageTransitionAnimation.cupertino,
                                      // );
                                    }
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
                                    'Pay Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
// import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
// import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
// import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

// class PaymentScreen extends StatefulWidget {
//   final String addressId;
//   const PaymentScreen({required this.addressId, super.key});

//   @override
//   _PaymentScreenState createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final TextEditingController couponController = TextEditingController();
//   double discount = 0.0;
//   bool isCouponApplied = false;
//   String errorMessage = '';
//   double deliveryFee = 10.0;

//   @override
//   void dispose() {
//     couponController.dispose();
//     super.dispose();
//   }

//   Future<void> applyCoupon(
//       CartProvider cartProvider, CouponProvider couponProvider) async {
//     final couponCode = couponController.text.trim();
//     if (couponCode.isNotEmpty) {
//       await couponProvider.fetchCouponData(couponCode);
//       if (couponProvider.couponData != null) {
//         setState(() {
//           isCouponApplied = true;
//           errorMessage = '';
//           final offerType = couponProvider.couponData!['offer_type'];
//           final discountValue =
//               (couponProvider.couponData!['discount'] as int).toDouble();
//           discount = (offerType == 'percentage')
//               ? cartProvider.subTotal * (discountValue / 100)
//               : discountValue;
//         });
//       } else {
//         setState(() {
//           isCouponApplied = false;
//           errorMessage = 'Invalid promo code';
//           discount = 0.0;
//         });
//       }
//     }
//   }

//   void removeCoupon(CouponProvider couponProvider) {
//     setState(() {
//       isCouponApplied = false;
//       discount = 0.0;
//       errorMessage = '';
//       couponProvider.clearCouponData();
//       couponController.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.06),
//           child: SingleChildScrollView(
//             child: Consumer<CartProvider>(builder: (context, cartValue, child) {
//               return Consumer<CheckOutProvider>(
//                 builder: (context, checkoutValue, child) {
//                   return Consumer<CouponProvider>(
//                     builder: (context, couponProvider, child) {
//                       double subTotal = cartValue.subTotal.toDouble();
//                       double total = subTotal - discount + deliveryFee;

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           customSizedBox(querySize),
//                           customProfileTopBar(querySize, context, "Payment"),
//                           customSizedBox(querySize),
//                           Text(
//                             "Delivery Address",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: querySize.width * 0.037,
//                               color: const Color(0xFF667080),
//                               fontFamily: 'Seogoe',
//                             ),
//                           ),
//                           customSizedBox(querySize),
//                           Container(
//                             width: querySize.width * 0.88,
//                             height: querySize.height * 0.15,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.03),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(querySize.width * 0.04),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/tick-icon.png',
//                                         width: querySize.width * 0.053,
//                                         height: querySize.width * 0.053,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: querySize.height * 0.02),
//                                   Text(
//                                     checkoutValue.list!.myName,
//                                     style: TextStyle(
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.width * 0.039,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF858585),
//                                     ),
//                                   ),
//                                   SizedBox(height: querySize.height * 0.01),
//                                   Text(
//                                     "+971 ${checkoutValue.list!.myPhone}",
//                                     style: TextStyle(
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.width * 0.037,
//                                       fontWeight: FontWeight.w500,
//                                       color: const Color(0xFF858585),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           customSizedBox(querySize),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: querySize.height * 0.06,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(
//                                         querySize.width * 0.03),
//                                   ),
//                                   child: TextFormField(
//                                     controller: couponController,
//                                     decoration: const InputDecoration(
//                                       hintText: "Enter Promo Code",
//                                       hintStyle: TextStyle(color: Colors.grey),
//                                       border: InputBorder.none,
//                                       contentPadding:
//                                           EdgeInsets.symmetric(horizontal: 16),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: querySize.height * 0.02),
//                               isCouponApplied
//                                   ? ElevatedButton(
//                                       onPressed: () =>
//                                           removeCoupon(couponProvider),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.red,
//                                         minimumSize: Size(
//                                           querySize.width * 0.26,
//                                           querySize.height * 0.055,
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Remove',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     )
//                                   : ElevatedButton(
//                                       onPressed: () => applyCoupon(
//                                           cartValue, couponProvider),
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor:
//                                             const Color(0xFF00ACB3),
//                                         minimumSize: Size(
//                                           querySize.width * 0.26,
//                                           querySize.height * 0.055,
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Apply',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                           if (errorMessage.isNotEmpty)
//                             Padding(
//                               padding: EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 errorMessage,
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: querySize.width * 0.035,
//                                 ),
//                               ),
//                             ),
//                           customSizedBox(querySize),
//                           Text(
//                             "Payment",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: querySize.width * 0.037,
//                               color: const Color(0xFF667080),
//                               fontFamily: 'Seogoe',
//                             ),
//                           ),
//                           customSizedBox(querySize),
//                           Container(
//                             padding: EdgeInsets.all(querySize.width * 0.046),
//                             width: querySize.width * 0.9,
//                             height: querySize.height * 0.21,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.03),
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Amount",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                     const Spacer(),
//                                     Text(
//                                       "${cartValue.subTotal} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFFC3C6C9),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: querySize.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Discount",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                     const Spacer(),
//                                     Text(
//                                       "-${discount.toStringAsFixed(2)} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFFC3C6C9),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: querySize.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Delivery Fee",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                     const Spacer(),
//                                     Text(
//                                       "${deliveryFee.toStringAsFixed(2)} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFFC3C6C9),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Total",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.019),
//                                     ),
//                                     const Spacer(),
//                                     Text(
//                                       "${total.toStringAsFixed(2)} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.019),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: querySize.height * 0.04),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: querySize.width * 0.058),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Total',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.021),
//                                     ),
//                                     Text(
//                                       'QAR ${total.toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w700,
//                                           color: const Color(0xFF00ACB3),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.022),
//                                     ),
//                                   ],
//                                 ),
//                                 const Spacer(),
//                                 ElevatedButton(
//                                   onPressed: () async{String token = (await AuthProvider().getToken())!;await Provider.of<PaymentProvider>(context).placeOrder(     token: token,
//                                       addressId: widget.addressId,
//                                       paymentMethod: 'card',
//                                       cart: cartValue.getCartDataForApi(),
//                                       totalAmount: totalAmount,
//                                       discount: discount,
//                                       couponCode: couponCode,
//                                       deliveryCharge: deliveryFee,
//                                       quantity: quantity,)},
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF00ACB3),
//                                     minimumSize: Size(
//                                       querySize.width * (160 / 375),
//                                       querySize.height * (48 / 812),
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           querySize.width * 0.045),
//                                     ),
//                                   ),
//                                   child: const Text(
//                                     'Pay Now',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
// import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
// import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
// import 'package:lenore/core/constant.dart';
// import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

// class PaymentScreen extends StatelessWidget {
//   final String addressId;
//   const PaymentScreen({required this.addressId, super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     final couponController = TextEditingController();

//     double discount = 0.0;
//     double discountValue = 0.0;
//     const double deliveryFee = 10.0; // Fixed delivery fee

//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.06),
//           child: SingleChildScrollView(
//             child: Consumer<CartProvider>(builder: (context, cartValue, child) {
//               return Consumer<CheckOutProvider>(
//                 builder: (context, checkoutValue, child) {
//                   return Consumer<CouponProvider>(
//                     builder: (context, couponValue, child) {
//                       double subTotal = cartValue.subTotal.toDouble();

//                       // Update discount based on coupon data if available
//                       if (couponValue.couponData != null) {
//                         final offerType = couponValue.couponData!['offer_type'];
//                         discountValue =
//                             (couponValue.couponData!['discount'] as int)
//                                 .toDouble();

//                         discount = (offerType == 'percentage')
//                             ? subTotal * (discountValue / 100)
//                             : discountValue;
//                       } else {
//                         discount = 0.0; // Reset discount if coupon is invalid
//                       }

//                       double total = subTotal - discount + deliveryFee;

//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           customSizedBox(querySize),
//                           customProfileTopBar(querySize, context, "Payment"),
//                           customSizedBox(querySize),
//                           Text(
//                             "Delivery Address",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: querySize.width * 0.037,
//                               color: const Color(0xFF667080),
//                               fontFamily: 'Seogoe',
//                             ),
//                           ),
//                           customSizedBox(querySize),
//                           Container(
//                             width: querySize.width * 0.88,
//                             height: querySize.height * 0.15,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.03),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(querySize.width * 0.04),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/tick-icon.png',
//                                         width: querySize.width * 0.053,
//                                         height: querySize.width * 0.053,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: querySize.height * 0.02),
//                                   Text(
//                                     checkoutValue.list!.myName,
//                                     style: TextStyle(
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.width * 0.039,
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF858585),
//                                     ),
//                                   ),
//                                   SizedBox(height: querySize.height * 0.01),
//                                   Text(
//                                     "+971 ${checkoutValue.list!.myPhone}",
//                                     style: TextStyle(
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.width * 0.037,
//                                       fontWeight: FontWeight.w500,
//                                       color: const Color(0xFF858585),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           customSizedBox(querySize),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   height: querySize.height * 0.06,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(
//                                         querySize.width * 0.03),
//                                   ),
//                                   child: TextFormField(
//                                     controller: couponController,
//                                     decoration: const InputDecoration(
//                                       hintText: "Enter Promo Code",
//                                       hintStyle: TextStyle(color: Colors.grey),
//                                       border: InputBorder.none,
//                                       contentPadding:
//                                           EdgeInsets.symmetric(horizontal: 16),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: querySize.height * 0.02),
//                               couponValue.couponData == null
//                                   ? ElevatedButton(
//                                       onPressed: () async {
//                                         final couponCode =
//                                             couponController.text.trim();
//                                         if (couponCode.isNotEmpty) {
//                                           await Provider.of<CouponProvider>(
//                                                   context,
//                                                   listen: false)
//                                               .fetchCouponData(couponCode);
//                                         }
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor:
//                                             const Color(0xFF00ACB3),
//                                         minimumSize: Size(
//                                           querySize.width * 0.26,
//                                           querySize.height * 0.055,
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Apply',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     )
//                                   : ElevatedButton(
//                                       onPressed: () {
//                                         Provider.of<CouponProvider>(context,
//                                                 listen: false)
//                                             .clearCouponData();
//                                         couponController.clear();
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.red,
//                                         minimumSize: Size(
//                                           querySize.width * 0.26,
//                                           querySize.height * 0.055,
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Remove',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                           customSizedBox(querySize),
//                           Text(
//                             "Payment",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: querySize.width * 0.037,
//                               color: const Color(0xFF667080),
//                               fontFamily: 'Seogoe',
//                             ),
//                           ),
//                           customSizedBox(querySize),
//                           Container(
//                             padding: EdgeInsets.all(querySize.width * 0.046),
//                             width: querySize.width * 0.9,
//                             height: querySize.height * 0.21,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                                   BorderRadius.circular(querySize.width * 0.03),
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Amount",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "${cartValue.subTotal} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFFC3C6C9),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: querySize.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Discount",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "-${discount.toStringAsFixed(2)} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFFC3C6C9),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: querySize.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Delivery Fee",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "${deliveryFee.toStringAsFixed(2)} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFFC3C6C9),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.017),
//                                     ),
//                                   ],
//                                 ),
//                                 Divider(),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "Total",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.019),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "${total.toStringAsFixed(2)} QAR",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF667080),
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.height * 0.019),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
// import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
// import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
// import 'package:lenore/core/constant.dart';

// import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
// import 'package:provider/provider.dart';

// class PaymentScreen extends StatelessWidget {
//   final String addressId;
//   const PaymentScreen({required this.addressId, super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     final couponController = TextEditingController();

//     double discount = 0.0;
//     double discountValue = 0.0;
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.06),
//           child: SingleChildScrollView(
//             child: Consumer<CartProvider>(builder: (context, cartValue, child) {
//               return Consumer<CheckOutProvider>(
//                   builder: (context, checkoutValue, child) {
//                 return Consumer<CouponProvider>(
//                     builder: (context, couponValue, child) {
//                   double subTotal = cartValue.subTotal.toDouble();
//                   // Calculate discount if coupon data is available
//                   // if (couponValue.couponData != null) {
//                   //   final offerType = couponValue.couponData!['offer_type'];
//                   //   final discountValue = couponValue.couponData!['discount'];

//                   //   if (offerType == 'percentage') {
//                   //     discount = subTotal * (discountValue / 100);
//                   //   } else if (offerType == 'amount') {
//                   //     discount = discountValue;
//                   //   }
//                   // }
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       customSizedBox(querySize),
//                       customProfileTopBar(querySize, context, "Payment"),
//                       customSizedBox(querySize),
//                       Text(
//                         "Delivery Address",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: querySize.width * 0.037,
//                           color: const Color(0xFF667080),
//                           fontFamily: 'Seogoe',
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       Container(
//                         width: querySize.width * 0.88,
//                         height: querySize.height * 0.15,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(querySize.width * 0.04),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/tick-icon.png',
//                                     width: querySize.width * 0.053,
//                                     height: querySize.width * 0.053,
//                                   ),
//                                   // const Spacer(),
//                                   // Image.asset(
//                                   //   'assets/images/edit_icon.png',
//                                   //   width: querySize.width * 0.049,
//                                   //   height: querySize.width * 0.049,
//                                   // ),
//                                   // SizedBox(width: querySize.width * 0.01),
//                                   // Text(
//                                   //   "Edit",
//                                   //   style: TextStyle(
//                                   //     fontFamily: 'Segoe',
//                                   //     fontSize: querySize.width * 0.03,
//                                   //     fontWeight: FontWeight.w600,
//                                   //     color: const Color(0xFF87A5A6),
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: querySize.height * 0.02,
//                               ),
//                               Text(
//                                 checkoutValue.list!.myName,
//                                 style: TextStyle(
//                                   fontFamily: 'Segoe',
//                                   fontSize: querySize.width * 0.039,
//                                   fontWeight: FontWeight.w600,
//                                   color: const Color(0xFF858585),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: querySize.height * 0.01,
//                               ),
//                               Text(
//                                 "+971 ${checkoutValue.list!.myPhone}",
//                                 style: TextStyle(
//                                   fontFamily: 'Segoe',
//                                   fontSize: querySize.width * 0.037,
//                                   fontWeight: FontWeight.w500,
//                                   color: const Color(0xFF858585),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       customSizedBox(querySize),
//                       Row(
//                         children: [
//                           Container(
//                             width: querySize.width * (0.56),
//                             height: querySize.height * 0.06,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(
//                                     querySize.width * 0.03)),
//                             child: TextFormField(
//                               controller: couponController,
//                               decoration: const InputDecoration(
//                                 hintText: "Enter Promo Code",
//                                 hintStyle: TextStyle(
//                                   color: Colors.grey,
//                                 ),
//                                 border: InputBorder.none,
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 16),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: querySize.height * 0.02,
//                           ),
//                           ElevatedButton(
//                             onPressed: () async {
//                               final couponCode = couponController.text.trim();
//                               if (couponCode.isNotEmpty) {
//                                 await Provider.of<CouponProvider>(context,
//                                         listen: false)
//                                     .fetchCouponData(couponCode);
//                                 if (couponValue.couponData != null) {
//                                   final offerType =
//                                       couponValue.couponData!['offer_type'];
//                                   discountValue =
//                                       couponValue.couponData!['discount'];

//                                   if (offerType == 'percentage') {
//                                     discount = subTotal * (discountValue / 100);
//                                   } else if (offerType == 'amount') {
//                                     discount = discountValue;
//                                   }
//                                 }
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00ACB3),
//                               minimumSize: Size(
//                                 querySize.width * 0.26,
//                                 querySize.height * 0.055,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text(
//                               'Apply',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                       customSizedBox(querySize),
//                       Text(
//                         "Payment",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: querySize.width * 0.037,
//                           color: const Color(0xFF667080),
//                           fontFamily: 'Seogoe',
//                         ),
//                       ),
//                       // customSizedBox(querySize),
//                       // Container(
//                       //   width: querySize.width * 0.88,
//                       //   height: querySize.height * 0.14,
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white,
//                       //     borderRadius: BorderRadius.circular(querySize.width * 0.03),
//                       //   ),
//                       //   child: Padding(
//                       //     padding: EdgeInsets.all(querySize.width * 0.04),
//                       //     child: Column(
//                       //       crossAxisAlignment: CrossAxisAlignment.start,
//                       //       children: [
//                       //         customPaymentListTile(
//                       //             querySize,
//                       //             'assets/images/pay online.png',
//                       //             'Pay Online',
//                       //             "assets/images/selected_tick.png"),
//                       //         customSizedBox(querySize),
//                       //         customPaymentListTile(
//                       //             querySize,
//                       //             'assets/images/apple.png',
//                       //             'Apple Pay',
//                       //             "assets/images/un_selected_tick.png")
//                       //       ],
//                       //     ),
//                       //   ),
//                       // ),
//                       customSizedBox(querySize),
//                       Container(
//                         padding: EdgeInsets.all(querySize.width * 0.046),
//                         width: querySize.width * 0.9,
//                         height: querySize.height * 0.21,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.03),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   "Amount",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF667080),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.017),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   "${cartValue.subTotal} QAR",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFFC3C6C9),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.017),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: querySize.height * 0.01,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Discount",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF667080),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.017),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   "-${couponValue.couponData?['discount'] ?? '0'} QAR",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: const Color(0xFFC3C6C9),
//                                     fontFamily: 'Segoe',
//                                     fontSize: querySize.height * 0.017,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: querySize.height * 0.01,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Delivery Fee",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF667080),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.017),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   "10 QAR",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFFC3C6C9),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.017),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: querySize.height * 0.01,
//                             ),
//                             Divider(
//                               thickness: querySize.height * 0.0007,
//                               color: const Color(0x6670802E),
//                             ),
//                             SizedBox(
//                               height: querySize.height * 0.01,
//                             ),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Total",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF667080),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.019),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   "${subTotal - discountValue}  QAR",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: const Color(0xFF667080),
//                                       fontFamily: 'Segoe',
//                                       fontSize: querySize.height * 0.019),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: querySize.height * 0.04,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: querySize.width * 0.058),
//                         child: Row(
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('total',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         color: const Color(0xFF667080),
//                                         fontFamily: 'Segoe',
//                                         fontSize: querySize.height * 0.021)),
//                                 Text('QAR 300.00',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                         color: const Color(0xFF00ACB3),
//                                         fontFamily: 'Segoe',
//                                         fontSize: querySize.height * 0.022))
//                               ],
//                             ),
//                             const Spacer(),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //       builder: (context) =>
//                                 //           const ,
//                                 //     ));
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF00ACB3),
//                                 minimumSize: Size(
//                                   querySize.width * (160 / 375),
//                                   querySize.height * (48 / 812),
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       querySize.width * 0.045),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'Pay Now',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 });
//               });
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
