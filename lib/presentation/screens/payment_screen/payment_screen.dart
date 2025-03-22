import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/delivery_fee_provider/delivery_fee_provider.dart';
import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
import 'package:lenore/application/provider/profile_provider/profile_provider.dart';
import 'package:lenore/application/provider/wallet_balance_provider/wallet_balance_provider.dart';
import 'package:lenore/domain/delivery_charge_model/delivery_charge_model.dart';
import 'package:lenore/presentation/screens/my_fatoorah_screen/fatoorah_payment_screen.dart';
import 'package:lenore/presentation/screens/payment_success_screen/payment_success_screen.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
import 'package:lenore/application/provider/coupon_provider/coupon_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

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
  bool isLoadingDeliveryCharge = true;
  double deliveryCharge = 0.0;
  bool useWallet = false;
  double walletAmountUsed = 0.0;

  @override
  void initState() {
    super.initState();
    // Fetch delivery charge when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDeliveryCharge();

      // Fetch wallet balance
      Provider.of<WalletBalanceProvider>(context, listen: false)
          .fetchWalletBalance(context);
    });
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final authProvider =
        await Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    print(token);
    if (token != null) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile(token);
    }
  }

  Future<void> fetchDeliveryCharge() async {
    setState(() {
      isLoadingDeliveryCharge = true;
    });

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final deliveryChargeProvider =
        Provider.of<DeliveryFeeProvider>(context, listen: false);

    try {
      // Convert cart items to format needed for delivery charge API
      final products = cartProvider.items
          .map((item) => DeliveryChargeRequestProduct(
                productId: item.productId,
                quantity: item.quantity,
                productType: int.parse(item
                    .type), // Assuming type is stored as a string that can be parsed to int
              ))
          .toList();

      // Print products being passed to the API for debugging
      print("------ Products being passed to delivery charge API ------");
      products.forEach((product) {
        print(
            "Product ID: ${product.productId}, Quantity: ${product.quantity}, Type: ${product.productType}");
      });
      print("Total products: ${products.length}");
      print("--------------------------------------------------------");

      // Fetch delivery charge
      deliveryCharge =
          await deliveryChargeProvider.fetchDeliveryCharge(products);

      // Print the received delivery charge
      print("Delivery charge received from API: $deliveryCharge QAR");
    } catch (e) {
      print('Error fetching delivery charge: $e');
      // Handle error - maybe set a default charge or show an error message
      deliveryCharge = 0.0;
    } finally {
      setState(() {
        isLoadingDeliveryCharge = false;
      });
    }
  }

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

  // Toggle wallet usage and calculate amount
  void toggleWalletUsage(double totalAmount, double walletBalance) {
    setState(() {
      useWallet = !useWallet;
      if (useWallet) {
        // Calculate how much wallet balance to use
        walletAmountUsed = (walletBalance >= totalAmount)
            ? totalAmount // Use full amount if wallet has enough
            : walletBalance; // Use whatever is available
      } else {
        walletAmountUsed = 0.0;
      }
    });
  }

  // Determine payment method based on wallet usage
  String getPaymentMethod(double totalAmount) {
    if (!useWallet) {
      return 'card';
    } else if (walletAmountUsed >= totalAmount) {
      return 'wallet';
    } else {
      return 'partial';
    }
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
                      return Consumer<DeliveryFeeProvider>(
                        builder: (context, deliveryChargeProvider, child) {
                          return Consumer<WalletBalanceProvider>(
                              builder: (context, walletProvider, child) {
                            double subTotal = cartValue.subTotal.toDouble();
                            double totalBeforeWallet = subTotal -
                                cartValue.totalVoucherDiscount -
                                discount +
                                deliveryCharge;

                            // Calculate final amount after wallet
                            double totalAmount =
                                totalBeforeWallet - walletAmountUsed;
                            if (totalAmount < 0) totalAmount = 0;

                            String couponCode = couponController.text.trim();
                            int quantity = cartValue.items
                                .fold(0, (sum, item) => sum + item.quantity);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customSizedBox(querySize),
                                customProfileTopBar(
                                    querySize, context, "Payment"),
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
                                    borderRadius: BorderRadius.circular(
                                        querySize.width * 0.03),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(querySize.width * 0.04),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        SizedBox(
                                            height: querySize.height * 0.02),
                                        Text(
                                          checkoutValue.list!.myName,
                                          style: TextStyle(
                                            fontFamily: 'Segoe',
                                            fontSize: querySize.width * 0.039,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF858585),
                                          ),
                                        ),
                                        SizedBox(
                                            height: querySize.height * 0.01),
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

                                // Promo Code Section
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
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              !useWallet;
                                              walletAmountUsed = 0.0;
                                              applyCoupon(
                                                  cartValue, couponProvider);
                                            },
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
                                              style: TextStyle(
                                                  color: Colors.white),
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

                                // Wallet Balance Section - ADDED HERE
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: querySize.height * 0.015,
                                    horizontal: querySize.width * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        querySize.width * 0.03),
                                    border: Border.all(
                                      color: const Color(0xFFE5E5E5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Apply Wallet",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: querySize.width * 0.037,
                                              color: const Color(0xFF667080),
                                              fontFamily: 'Seogoe',
                                            ),
                                          ),
                                          const Spacer(),
                                          Switch(
                                            value: useWallet,
                                            activeColor:
                                                const Color(0xFF00ACB3),
                                            onChanged: walletProvider.isLoading
                                                ? null
                                                : (value) {
                                                    toggleWalletUsage(
                                                        totalBeforeWallet,
                                                        walletProvider
                                                            .walletBalance);
                                                  },
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: querySize.height * 0.01),
                                      Row(
                                        children: [
                                          Text(
                                            "Available Balance",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: querySize.width * 0.035,
                                              color: const Color(0xFF667080),
                                              fontFamily: 'Seogoe',
                                            ),
                                          ),
                                          const Spacer(),
                                          walletProvider.isLoading
                                              ? SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Color(0xFF00ACB3),
                                                  ),
                                                )
                                              : Text(
                                                  "${walletProvider.walletBalance.toStringAsFixed(2)} QAR",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        querySize.width * 0.035,
                                                    color:
                                                        const Color(0xFF00ACB3),
                                                    fontFamily: 'Seogoe',
                                                  ),
                                                ),
                                        ],
                                      ),
                                      if (useWallet && walletAmountUsed > 0)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: querySize.height * 0.01),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Amount Applied",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      querySize.width * 0.035,
                                                  color:
                                                      const Color(0xFF667080),
                                                  fontFamily: 'Seogoe',
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "-${walletAmountUsed.toStringAsFixed(2)} QAR",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      querySize.width * 0.035,
                                                  color: Colors.green,
                                                  fontFamily: 'Seogoe',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
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
                                  padding:
                                      EdgeInsets.all(querySize.width * 0.046),
                                  width: querySize.width * 0.9,
                                  // Increase height to accommodate wallet row if needed
                                  height: useWallet
                                      ? querySize.height * 0.3
                                      : querySize.height * 0.23,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        querySize.width * 0.03),
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
                                                fontSize:
                                                    querySize.height * 0.017),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${cartValue.subTotal} QAR",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFFC3C6C9),
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.height * 0.017),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: querySize.height * 0.01),
                                      Row(
                                        children: [
                                          Text(
                                            "Voucher Discount",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF667080),
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.height * 0.017),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "-${cartValue.totalVoucherDiscount} QAR",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFFC3C6C9),
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.height * 0.017),
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
                                                fontSize:
                                                    querySize.height * 0.017),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "-${discount.toStringAsFixed(2)} QAR",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFFC3C6C9),
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.height * 0.017),
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
                                                fontSize:
                                                    querySize.height * 0.017),
                                          ),
                                          const Spacer(),
                                          isLoadingDeliveryCharge
                                              ? SizedBox(
                                                  height: 12,
                                                  width: 12,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Color(0xFF00ACB3),
                                                  ),
                                                )
                                              : Text(
                                                  "${deliveryCharge.toStringAsFixed(2)} QAR",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFFC3C6C9),
                                                      fontFamily: 'Segoe',
                                                      fontSize:
                                                          querySize.height *
                                                              0.017),
                                                ),
                                        ],
                                      ),

                                      // Add wallet amount row if wallet is being used
                                      if (useWallet &&
                                          walletAmountUsed > 0) ...[
                                        SizedBox(
                                            height: querySize.height * 0.01),
                                        Row(
                                          children: [
                                            Text(
                                              "Wallet Amount",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF667080),
                                                  fontFamily: 'Segoe',
                                                  fontSize:
                                                      querySize.height * 0.017),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "-${walletAmountUsed.toStringAsFixed(2)} QAR",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green,
                                                  fontFamily: 'Segoe',
                                                  fontSize:
                                                      querySize.height * 0.017),
                                            ),
                                          ],
                                        ),
                                      ],

                                      Divider(),
                                      Row(
                                        children: [
                                          Text(
                                            "Total",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF667080),
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.height * 0.019),
                                          ),
                                          const Spacer(),
                                          isLoadingDeliveryCharge ||
                                                  walletProvider.isLoading
                                              ? SizedBox(
                                                  height: 14,
                                                  width: 14,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Color(0xFF00ACB3),
                                                  ),
                                                )
                                              : Text(
                                                  "${totalAmount.toStringAsFixed(2)} QAR",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF667080),
                                                      fontFamily: 'Segoe',
                                                      fontSize:
                                                          querySize.height *
                                                              0.019),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Total',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF667080),
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.height * 0.021),
                                          ),
                                          isLoadingDeliveryCharge ||
                                                  walletProvider.isLoading
                                              ? SizedBox(
                                                  height: 16,
                                                  width: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: Color(0xFF00ACB3),
                                                  ),
                                                )
                                              : Text(
                                                  'QAR ${totalAmount.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                          0xFF00ACB3),
                                                      fontFamily: 'Segoe',
                                                      fontSize:
                                                          querySize.height *
                                                              0.022),
                                                ),
                                        ],
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        onPressed: isLoadingDeliveryCharge ||
                                                walletProvider.isLoading
                                            ? null
                                            : () async {
                                                String token = await Provider
                                                            .of<AuthProvider>(
                                                                context,
                                                                listen: false)
                                                        .getToken() ??
                                                    '';
                                                print(token);

                                                // Determine payment method based on wallet usage
                                                String paymentMethod;
                                                if (useWallet &&
                                                    walletAmountUsed >=
                                                        totalBeforeWallet) {
                                                  paymentMethod =
                                                      'wallet'; // Use wallet for full payment
                                                } else {
                                                  paymentMethod =
                                                      'card'; // Use card for payment
                                                }

                                                // Place the order
                                                int? result = await Provider.of<
                                                            PaymentProvider>(
                                                        context,
                                                        listen: false)
                                                    .placeOrder(
                                                  walletUsed: walletAmountUsed,
                                                  token: token,
                                                  addressId: widget.addressId,
                                                  paymentMethod: paymentMethod,
                                                  cart: cartValue
                                                      .getCartDataForApi(),
                                                  totalAmount: totalAmount,
                                                  discount: discount,
                                                  couponCode: couponCode,
                                                  deliveryCharge:
                                                      deliveryCharge,
                                                  quantity: quantity,
                                                );

                                                if (result != null) {
                                                  // Clear the cart (if needed)
                                                  // cartValue.clearCart();

                                                  // Navigate based on payment method
                                                  if (paymentMethod ==
                                                      'wallet') {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PaymentResultScreen(
                                                          orderId: '',
                                                          message:
                                                              "Payment Successful!",
                                                          isSuccess: true,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CardPaymentScreen(
                                                          customerIdentifier:
                                                              Provider.of<ProfileProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .profile!
                                                                  .data
                                                                  .id
                                                                  .toString(),
                                                          context: context,
                                                          token: token,
                                                          orderId: result,
                                                          totalAmount:
                                                              totalAmount,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF00ACB3),
                                          disabledBackgroundColor:
                                              const Color(0xFF00ACB3)
                                                  .withOpacity(0.5),
                                          minimumSize: Size(
                                            querySize.width * (160 / 375),
                                            querySize.height * (48 / 812),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                querySize.width * 0.045),
                                          ),
                                        ),
                                        child: Text(
                                          useWallet &&
                                                  walletAmountUsed >=
                                                      totalBeforeWallet
                                              ? 'Pay with Wallet'
                                              : 'Pay Now',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      // ElevatedButton(
                                      //   onPressed: isLoadingDeliveryCharge ||
                                      //           walletProvider.isLoading
                                      //       ? null
                                      //       : () async {
                                      //           String token = await Provider
                                      //                       .of<AuthProvider>(
                                      //                           context,
                                      //                           listen: false)
                                      //                   .getToken() ??
                                      //               '';
                                      //           print(token);

                                      //           // Get payment method
                                      //           String paymentMethod =
                                      //               getPaymentMethod(
                                      //                   totalBeforeWallet);

                                      //           int? result = await Provider.of<
                                      //                       PaymentProvider>(
                                      //                   context,
                                      //                   listen: false)
                                      //               .placeOrder(
                                      //             walletUsed: walletAmountUsed,
                                      //             token: token,
                                      //             addressId: widget.addressId,
                                      //             paymentMethod: paymentMethod,
                                      //             cart: cartValue
                                      //                 .getCartDataForApi(),
                                      //             totalAmount: totalAmount,
                                      //             discount: discount,
                                      //             couponCode: couponCode,
                                      //             deliveryCharge:
                                      //                 deliveryCharge,
                                      //             quantity: quantity,
                                      //           );

                                      //           if (result != null) {
                                      //             //cartValue.clearCart();

                                      //             // If using wallet for full payment, go to PaymentResultScreen
                                      //             if (paymentMethod ==
                                      //                 'wallet') {
                                      //               Navigator.push(
                                      //                 context,
                                      //                 MaterialPageRoute(
                                      //                   builder: (context) =>
                                      //                       PaymentResultScreen(
                                      //                     message:
                                      //                         "Payment Successful!",
                                      //                     isSuccess: true,
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             } else {
                                      //               // Otherwise go to card payment screen
                                      //               Navigator.push(
                                      //                 context,
                                      //                 MaterialPageRoute(
                                      //                   builder: (context) =>
                                      //                       CardPaymentScreen(
                                      //                     context: context,
                                      //                     token: token,
                                      //                     orderId: result,
                                      //                     totalAmount:
                                      //                         totalAmount,
                                      //                   ),
                                      //                 ),
                                      //               );
                                      //             }
                                      //           }
                                      //         },
                                      //   style: ElevatedButton.styleFrom(
                                      //     backgroundColor:
                                      //         const Color(0xFF00ACB3),
                                      //     disabledBackgroundColor:
                                      //         const Color(0xFF00ACB3)
                                      //             .withOpacity(0.5),
                                      //     minimumSize: Size(
                                      //       querySize.width * (160 / 375),
                                      //       querySize.height * (48 / 812),
                                      //     ),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(
                                      //           querySize.width * 0.045),
                                      //     ),
                                      //   ),
                                      //   child: Text(
                                      //     useWallet &&
                                      //             walletAmountUsed >=
                                      //                 totalBeforeWallet
                                      //         ? 'Pay with Wallet'
                                      //         : 'Pay Now',
                                      //     style: TextStyle(color: Colors.white),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: querySize.height * 0.03,
                                )
                              ],
                            );
                          });
                        },
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
//   bool isLoadingDeliveryCharge = true;
//   double deliveryCharge = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch delivery charge when screen initializes
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       fetchDeliveryCharge();
//     });
//   }

//   Future<void> fetchDeliveryCharge() async {
//     setState(() {
//       isLoadingDeliveryCharge = true;
//     });

//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final deliveryChargeProvider =
//         Provider.of<DeliveryFeeProvider>(context, listen: false);

//     try {
//       // Convert cart items to format needed for delivery charge API
//       final products = cartProvider.items
//           .map((item) => DeliveryChargeRequestProduct(
//                 productId: item.productId,
//                 quantity: item.quantity,
//                 productType: int.parse(item
//                     .type), // Assuming type is stored as a string that can be parsed to int
//               ))
//           .toList();

//       // Print products being passed to the API for debugging
//       print("------ Products being passed to delivery charge API ------");
//       products.forEach((product) {
//         print(
//             "Product ID: ${product.productId}, Quantity: ${product.quantity}, Type: ${product.productType}");
//       });
//       print("Total products: ${products.length}");
//       print("--------------------------------------------------------");

//       // Fetch delivery charge
//       deliveryCharge =
//           await deliveryChargeProvider.fetchDeliveryCharge(products);

//       // Print the received delivery charge
//       print("Delivery charge received from API: $deliveryCharge QAR");
//     } catch (e) {
//       print('Error fetching delivery charge: $e');
//       // Handle error - maybe set a default charge or show an error message
//       deliveryCharge = 0.0;
//     } finally {
//       setState(() {
//         isLoadingDeliveryCharge = false;
//       });
//     }
//   }

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
//           if (discount > cartProvider.subTotal) {
//             customSnackBar(context, 'You are not eligible');
//             discount = 0;
//           }
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
//                       return Consumer<DeliveryFeeProvider>(
//                         builder: (context, deliveryChargeProvider, child) {
//                           double subTotal = cartValue.subTotal.toDouble();
//                           double totalAmount = subTotal -
//                               cartValue.totalVoucherDiscount -
//                               discount +
//                               deliveryCharge;

//                           String couponCode = couponController.text.trim();
//                           int quantity = cartValue.items
//                               .fold(0, (sum, item) => sum + item.quantity);

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               customSizedBox(querySize),
//                               customProfileTopBar(
//                                   querySize, context, "Payment"),
//                               customSizedBox(querySize),
//                               Text(
//                                 "Delivery Address",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: querySize.width * 0.037,
//                                   color: const Color(0xFF667080),
//                                   fontFamily: 'Seogoe',
//                                 ),
//                               ),
//                               customSizedBox(querySize),
//                               Container(
//                                 width: querySize.width * 0.88,
//                                 height: querySize.height * 0.15,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(
//                                       querySize.width * 0.03),
//                                 ),
//                                 child: Padding(
//                                   padding:
//                                       EdgeInsets.all(querySize.width * 0.04),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/images/tick-icon.png',
//                                             width: querySize.width * 0.053,
//                                             height: querySize.width * 0.053,
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: querySize.height * 0.02),
//                                       Text(
//                                         checkoutValue.list!.myName,
//                                         style: TextStyle(
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.width * 0.039,
//                                           fontWeight: FontWeight.w600,
//                                           color: const Color(0xFF858585),
//                                         ),
//                                       ),
//                                       SizedBox(height: querySize.height * 0.01),
//                                       Text(
//                                         "+971 ${checkoutValue.list!.myPhone}",
//                                         style: TextStyle(
//                                           fontFamily: 'Segoe',
//                                           fontSize: querySize.width * 0.037,
//                                           fontWeight: FontWeight.w500,
//                                           color: const Color(0xFF858585),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               customSizedBox(querySize),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: querySize.height * 0.06,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(
//                                             querySize.width * 0.03),
//                                       ),
//                                       child: TextFormField(
//                                         controller: couponController,
//                                         decoration: const InputDecoration(
//                                           hintText: "Enter Promo Code",
//                                           hintStyle:
//                                               TextStyle(color: Colors.grey),
//                                           border: InputBorder.none,
//                                           contentPadding: EdgeInsets.symmetric(
//                                               horizontal: 16),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: querySize.height * 0.02),
//                                   isCouponApplied
//                                       ? ElevatedButton(
//                                           onPressed: () =>
//                                               removeCoupon(couponProvider),
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor: Colors.red,
//                                             minimumSize: Size(
//                                               querySize.width * 0.26,
//                                               querySize.height * 0.055,
//                                             ),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             'Remove',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         )
//                                       : ElevatedButton(
//                                           onPressed: () => applyCoupon(
//                                               cartValue, couponProvider),
//                                           style: ElevatedButton.styleFrom(
//                                             backgroundColor:
//                                                 const Color(0xFF00ACB3),
//                                             minimumSize: Size(
//                                               querySize.width * 0.26,
//                                               querySize.height * 0.055,
//                                             ),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             'Apply',
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                 ],
//                               ),
//                               if (errorMessage.isNotEmpty)
//                                 Padding(
//                                   padding: EdgeInsets.only(top: 8.0),
//                                   child: Text(
//                                     errorMessage,
//                                     style: TextStyle(
//                                       color: Colors.red,
//                                       fontSize: querySize.width * 0.035,
//                                     ),
//                                   ),
//                                 ),
//                               customSizedBox(querySize),
//                               Text(
//                                 "Payment",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: querySize.width * 0.037,
//                                   color: const Color(0xFF667080),
//                                   fontFamily: 'Seogoe',
//                                 ),
//                               ),
//                               customSizedBox(querySize),
//                               Container(
//                                 padding:
//                                     EdgeInsets.all(querySize.width * 0.046),
//                                 width: querySize.width * 0.9,
//                                 height: querySize.height * 0.23,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(
//                                       querySize.width * 0.03),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Amount",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFF667080),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                         const Spacer(),
//                                         Text(
//                                           "${cartValue.subTotal} QAR",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFFC3C6C9),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: querySize.height * 0.01),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Voucher Discount",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFF667080),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                         const Spacer(),
//                                         Text(
//                                           "-${cartValue.totalVoucherDiscount} QAR",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFFC3C6C9),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: querySize.height * 0.01),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Discount",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFF667080),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                         const Spacer(),
//                                         Text(
//                                           "-${discount.toStringAsFixed(2)} QAR",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFFC3C6C9),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: querySize.height * 0.01),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Delivery Fee",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFF667080),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.017),
//                                         ),
//                                         const Spacer(),
//                                         isLoadingDeliveryCharge
//                                             ? SizedBox(
//                                                 height: 12,
//                                                 width: 12,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   strokeWidth: 2,
//                                                   color: Color(0xFF00ACB3),
//                                                 ),
//                                               )
//                                             : Text(
//                                                 "${deliveryCharge.toStringAsFixed(2)} QAR",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w600,
//                                                     color:
//                                                         const Color(0xFFC3C6C9),
//                                                     fontFamily: 'Segoe',
//                                                     fontSize: querySize.height *
//                                                         0.017),
//                                               ),
//                                       ],
//                                     ),
//                                     Divider(),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Total",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                               color: const Color(0xFF667080),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.019),
//                                         ),
//                                         const Spacer(),
//                                         isLoadingDeliveryCharge
//                                             ? SizedBox(
//                                                 height: 14,
//                                                 width: 14,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   strokeWidth: 2,
//                                                   color: Color(0xFF00ACB3),
//                                                 ),
//                                               )
//                                             : Text(
//                                                 "${totalAmount.toStringAsFixed(2)} QAR",
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w600,
//                                                     color:
//                                                         const Color(0xFF667080),
//                                                     fontFamily: 'Segoe',
//                                                     fontSize: querySize.height *
//                                                         0.019),
//                                               ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: querySize.height * 0.04),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: querySize.width * 0.058),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Total',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: const Color(0xFF667080),
//                                               fontFamily: 'Segoe',
//                                               fontSize:
//                                                   querySize.height * 0.021),
//                                         ),
//                                         isLoadingDeliveryCharge
//                                             ? SizedBox(
//                                                 height: 16,
//                                                 width: 16,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   strokeWidth: 2,
//                                                   color: Color(0xFF00ACB3),
//                                                 ),
//                                               )
//                                             : Text(
//                                                 'QAR ${totalAmount.toStringAsFixed(2)}',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w700,
//                                                     color:
//                                                         const Color(0xFF00ACB3),
//                                                     fontFamily: 'Segoe',
//                                                     fontSize: querySize.height *
//                                                         0.022),
//                                               ),
//                                       ],
//                                     ),
//                                     const Spacer(),
//                                     ElevatedButton(
//                                       onPressed: isLoadingDeliveryCharge
//                                           ? null
//                                           : () async {
//                                               String token = await Provider.of<
//                                                               AuthProvider>(
//                                                           context,
//                                                           listen: false)
//                                                       .getToken() ??
//                                                   '';
//                                               print(token);
//                                               int? result = await Provider.of<
//                                                           PaymentProvider>(
//                                                       context,
//                                                       listen: false)
//                                                   .placeOrder(walletUsed: ,
//                                                 token: token,
//                                                 addressId: widget.addressId,
//                                                 paymentMethod: ,
//                                                 cart: cartValue
//                                                     .getCartDataForApi(),
//                                                 totalAmount: totalAmount,
//                                                 discount: discount,
//                                                 couponCode: couponCode,
//                                                 deliveryCharge: deliveryCharge,
//                                                 quantity: quantity,
//                                               );
//                                               if (result != null) {
//                                                 cartValue.clearCart();
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         CardPaymentScreen(
//                                                       context: context,
//                                                       token: token,
//                                                       orderId: result,
//                                                       totalAmount: totalAmount,
//                                                     ),
//                                                   ),
//                                                 );
//                                               }
//                                             },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor:
//                                             const Color(0xFF00ACB3),
//                                         disabledBackgroundColor:
//                                             const Color(0xFF00ACB3)
//                                                 .withOpacity(0.5),
//                                         minimumSize: Size(
//                                           querySize.width * (160 / 375),
//                                           querySize.height * (48 / 812),
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                               querySize.width * 0.045),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Pay Now',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
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


