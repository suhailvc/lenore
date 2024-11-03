import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/product_detail_model/product_detail_model.dart';
import 'package:lenore/presentation/screens/payment_success_screen/payment_success_screen.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class BuyNowPaymentScreen extends StatefulWidget {
  final String addressId;
  final ProductDetailModel product;
  const BuyNowPaymentScreen(
      {required this.product, required this.addressId, super.key});

  @override
  State<BuyNowPaymentScreen> createState() => _BuyNowPaymentScreenState();
}

class _BuyNowPaymentScreenState extends State<BuyNowPaymentScreen> {
  final TextEditingController couponController = TextEditingController();
  double discount = 0.0;
  bool isCouponApplied = false;
  String errorMessage = '';
  double deliveryFee = 10.0;

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  Future<void> applyCoupon(CouponProvider couponProvider) async {
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
              ? widget.product.data!.price! * (discountValue / 100)
              : discountValue;
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
          child: SingleChildScrollView(child: Consumer<CheckOutProvider>(
            builder: (context, checkoutValue, child) {
              return Consumer<CouponProvider>(
                builder: (context, couponProvider, child) {
                  double subTotal = widget.product.data!.price!.toDouble();
                  double totalAmount = subTotal - discount + deliveryFee;
                  String couponCode = couponController.text.trim();
                  int quantity = 1;

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
                                  onPressed: () => removeCoupon(couponProvider),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    minimumSize: Size(
                                      querySize.width * 0.26,
                                      querySize.height * 0.055,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () => applyCoupon(couponProvider),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00ACB3),
                                    minimumSize: Size(
                                      querySize.width * 0.26,
                                      querySize.height * 0.055,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                        height: querySize.height * 0.21,
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
                                  "${widget.product.data!.price!} QAR",
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
                                  "${widget.product.data!.price!} QAR",
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
                                Map<String, dynamic> cartItem = {
                                  "id": widget.product.data?.id,
                                  "name": widget.product.data?.name,
                                  "price": widget.product.data?.price,
                                  "quantity": quantity,
                                };

                                List<Map<String, dynamic>> cart = [cartItem];

                                String token = await Provider.of<AuthProvider>(
                                            context,
                                            listen: false)
                                        .getToken() ??
                                    '';
                                String result =
                                    await Provider.of<PaymentProvider>(context,
                                            listen: false)
                                        .placeOrder(
                                  token: token,
                                  addressId: widget.addressId,
                                  paymentMethod: 'card',
                                  cart: cart,
                                  totalAmount: totalAmount,
                                  discount: discount,
                                  couponCode: couponCode,
                                  deliveryCharge: deliveryFee,
                                  quantity: quantity,
                                );
                                if (result == 'success') {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: PaymentSuccessScreen(),
                                    withNavBar:
                                        false, // OPTIONAL VALUE. True by default.
                                  );
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
          )),
        ),
      ),
    );
  }
}
