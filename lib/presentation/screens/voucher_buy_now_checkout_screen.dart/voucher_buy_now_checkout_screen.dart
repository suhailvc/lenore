import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
import 'package:lenore/application/provider/product_detail_provider/product_detail_provider.dart';
import 'package:lenore/application/provider/voucher_detail_provider/voucher_detail_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/check_out_model/check_out_model.dart';
import 'package:lenore/domain/voucher_detail_model/voucher_detail_model.dart';
import 'package:lenore/presentation/screens/buy_now_voucher_payment.dart/buy_now_voucher_payment.dart.dart';
import 'package:lenore/presentation/screens/check_out_screen/widget/customCheckOutField.dart';
import 'package:lenore/presentation/widgets/cart_top_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class VoucherBuyNowCheckoutScreen extends StatefulWidget {
  final int productId;
  final int quantity;
  const VoucherBuyNowCheckoutScreen(
      {required this.quantity, required this.productId, super.key});

  @override
  State<VoucherBuyNowCheckoutScreen> createState() =>
      _VoucherBuyNowCheckoutScreenState();
}

class _VoucherBuyNowCheckoutScreenState
    extends State<VoucherBuyNowCheckoutScreen> {
  @override
  void initState() {
    Provider.of<VocherDetailProvider>(context, listen: false)
        .fetchVoucherDetail(widget.productId);

    super.initState();
  }

  var myNameController = TextEditingController();
  var myMobileNumberController = TextEditingController();
  var mySelfTo = TextEditingController();
  var mySelfMessage = TextEditingController();
  String? selectedDate;
  String? selfSelectedDate;
  var giftteeNameController = TextEditingController();
  var giftteemobileNumberController = TextEditingController();
  var giftteeTo = TextEditingController();
  var giftteeMessage = TextEditingController();
  String? selectedDay;
  String? selfSelectedDay;
  String anonymous = '0';
  bool isAnonymous = false;
  bool todaySelected = false;
  bool tommorrowSelected = false;
  bool pickAdate = false;
  bool selfTodaySelected = false;
  bool selfTommorrowSelected = false;
  bool selfPickAdate = false;
  String? nameError;
  String? numberError;
  String? giftMyNameError;
  String? giftMyNumberError;
  String? selfMyNameError;
  String? selfMyNumberError;
  void validateFields() {
    setState(() {
      selfMyNameError =
          myNameController.text.isEmpty ? 'Please enter your name' : null;
      selfMyNumberError = myMobileNumberController.text.isEmpty ||
              myMobileNumberController.text.length != 8
          ? 'Please enter your mobile number'
          : null;
    });
  }

  void giftValidateFields() {
    setState(() {
      giftMyNameError =
          myNameController.text.isEmpty ? 'Please enter your name' : null;
      giftMyNumberError = myMobileNumberController.text.isEmpty ||
              myMobileNumberController.text.length != 8
          ? 'Please enter your mobile number'
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final cartProvider = Provider.of<CartProvider>(context);
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: SafeArea(child: Consumer<VocherDetailProvider>(
            builder: (context, voucherValue, child) {
          return Consumer<ProductDetailProvider>(
              builder: (context, productValue, child) {
            return Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customOneSizedBox(querySize),
                      cartTopBar(querySize, context, 'Check Out'),
                      customSizedBox(querySize),

                      // Cart Item List (using ListView.builder within a fixed-height container)
                      Container(
                        width: querySize.width,
                        height: querySize.height * 0.15,
                        margin:
                            EdgeInsets.only(bottom: querySize.height * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.03),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(querySize.width * 0.03),
                              child: Container(
                                width: querySize.width * 0.25,
                                height: querySize.width * 0.25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: widget.quantity == 1
                                        ? NetworkImage(productValue
                                            .productDetails!.data!.images![0])
                                        : NetworkImage(voucherValue
                                            .voucherDetail!.data![0].image!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      querySize.width * 0.02),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: querySize.height * 0.03,
                                ),
                                Text(
                                  voucherValue.voucherDetail!.data![0].name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: querySize.height * 0.02,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: querySize.height * 0.009),
                                Text(
                                    "QAR ${voucherValue.voucherDetail!.data![0].amount}",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      customSizedBox(querySize),

                      // Message Section
                      Text(
                        'Send Message',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF667080),
                          fontFamily: 'Segoe',
                          fontSize: querySize.height * 0.017,
                        ),
                      ),
                      Consumer<CheckBoxProvider>(
                          builder: (context, checkBox, child) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  value: checkBox.giftMySelfChecked,
                                  activeColor: textColor,
                                  onChanged: (value) {
                                    checkBox.toggleMySelf();
                                  },
                                  side: WidgetStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                      width: querySize.width * 0.003,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: querySize.width * 0.004),
                                Text(
                                  'For Myself',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: 'Segoe',
                                    fontSize: querySize.height * 0.016,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  visualDensity: VisualDensity.compact,
                                  activeColor: textColor,
                                  side: WidgetStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                      width: querySize.width * 0.003,
                                      color: textColor,
                                    ),
                                  ),
                                  value: checkBox.sendAsGift,
                                  onChanged: (value) {
                                    checkBox.toggleSendAsGift();
                                  },
                                ),
                                SizedBox(width: querySize.width * 0.004),
                                Text(
                                  'Send As a Gift',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontFamily: 'Segoe',
                                    fontSize: querySize.height * 0.016,
                                  ),
                                ),
                              ],
                            ),
                            if (checkBox.giftMySelfChecked)
                              giftMySelfSection(
                                  querySize,
                                  context,
                                  voucherValue.voucherDetail,
                                  voucherValue.voucherDetail!.data![0].amount
                                      .toString(),
                                  myNameController,
                                  myMobileNumberController,
                                  mySelfTo,
                                  mySelfMessage),
                            if (checkBox.sendAsGift)
                              sendAsGiftSection(
                                  querySize,
                                  context,
                                  voucherValue.voucherDetail,
                                  voucherValue.voucherDetail!.data![0].amount
                                      .toString(),
                                  myNameController,
                                  myMobileNumberController,
                                  giftteeNameController,
                                  giftteemobileNumberController,
                                  giftteeTo,
                                  giftteeMessage),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ],
            );
          });
        })),
      ),
    );
  }

  // Other sections such as `sendAsGiftSection` and `giftMySelfSection` remain unchanged
  Column sendAsGiftSection(
    Size querySize,
    BuildContext context,
    VoucherDetailModel? voucher,
    String? voucherPrice,
    TextEditingController myName,
    TextEditingController myMobileNumber,
    TextEditingController giftteeName,
    TextEditingController giftteeMobileNumber,
    TextEditingController toContoller,
    TextEditingController message,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSizedBox(querySize),
        Text(
          'My Details',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF667080),
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.017),
        ),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/first_name_icon.png",
            'Enter Your Name',
            'Your Name',
            myName,
            errorMessage: giftMyNameError),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/qatar_flag_icon.png",
            'Enter Your Number',
            'Mobile Number',
            myMobileNumber,
            errorMessage: giftMyNumberError),
        customOneSizedBox(querySize),
        customSizedBox(querySize),
        Text(
          'Giftee Detail',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF667080),
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.017),
        ),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/first_name_icon.png",
            'Enter Giftee Name',
            'Giftee Name',
            giftteeName),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/qatar_flag_icon.png",
            'Enter Giftee Number',
            'Giftee Mobile Number',
            giftteeMobileNumber),
        SizedBox(
          height: querySize.width * 0.01,
        ),
        Row(
          children: [
            Checkbox(
              visualDensity: VisualDensity.compact,
              activeColor: textColor,
              side: BorderSide(
                width: querySize.width * 0.003,
                color: textColor,
              ),
              value: isAnonymous,
              onChanged: (value) {
                isAnonymous = value ?? false;
                anonymous = isAnonymous ? '1' : '0';
                setState(
                    () {}); // Update the state if this is within a StatefulWidget
              },
            ),
            Text(
              'Send as anonymous',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF858585),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.015),
            )
          ],
        ),
        customOneSizedBox(querySize),
        Container(
            width: querySize.width * 1,
            height: querySize.height * 0.385,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(querySize.width * 0.03)),
            child: Padding(
              padding: EdgeInsets.all(querySize.width * 0.038),
              child: Column(
                children: [
                  checkOutMessageColumn(querySize, 'To', toContoller),
                  customOneSizedBox(querySize),
                  Container(
                    width: querySize.width * 0.88,
                    height: querySize.height * 0.18,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEEEE),
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.02),
                    ),
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: querySize.height * 0.01,
                            horizontal: querySize.width * 0.04),
                        hintText: 'Card Message',
                        hintStyle: TextStyle(
                            fontSize: querySize.height * 0.02,
                            color: const Color(0xFFAAAEAE),
                            fontFamily: 'Segoe'),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  customOneSizedBox(querySize),
                  // checkOutMessageColumn(querySize, 'From'),
                ],
              ),
            )),
        customOneSizedBox(querySize),
        Text(
          'Pick a date',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF667080),
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.017),
        ),
        SizedBox(
          height: querySize.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  todaySelected = !todaySelected;
                  tommorrowSelected = false;
                });
                if (todaySelected == true) {
                  selectedDay = 'today';
                  selectedDate =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                print(todaySelected);
              },
              child: Container(
                width: querySize.width * 0.28,
                height: querySize.height * 0.045,
                decoration: BoxDecoration(
                  color: todaySelected ? Colors.blue : appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.02),
                ),
                child: Center(
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Segoe',
                      fontSize: querySize.height * 0.017,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  todaySelected = false;
                  tommorrowSelected = !tommorrowSelected;
                });
                if (todaySelected == true) {
                  selectedDay = 'tommorrow';
                  selectedDate = DateFormat('yyyy-MM-dd')
                      .format(DateTime.now().add(Duration(days: 1)));
                }
              },
              child: Container(
                width: querySize.width * 0.28,
                height: querySize.height * 0.045,
                decoration: BoxDecoration(
                  color: tommorrowSelected ? Colors.blue : appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.02),
                ),
                child: Center(
                  child: Text(
                    'Tommorrow',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () async {
                  setState(() {
                    todaySelected = false;
                    tommorrowSelected = false;
                  });
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 1)),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
                child: Container(
                  width: querySize.width * 0.28,
                  height: querySize.height * 0.045,
                  decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(querySize.width * 0.02),
                  ),
                  child: Center(
                    child: Text(
                      'Pick a date',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Segoe',
                          fontSize: querySize.height * 0.017),
                    ),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: querySize.height * 0.018,
        ),
        Text(
          'Note: Our team will contact the giftee for their location',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0xFFAAAEAE),
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.015),
        ),
        SizedBox(
          height: querySize.height * 0.03,
        ),
        Row(
          children: [
            SizedBox(
              width: querySize.width * 0.07,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Segoe',
                      fontSize: querySize.height * 0.02),
                ),
                Text(
                  "QAR ${voucherPrice}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: appColor,
                      fontFamily: 'Segoe',
                      fontSize: querySize.height * 0.026),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                String token = (await AuthProvider().getToken())!;
                giftValidateFields();
                if (giftMyNameError == null && giftMyNumberError == null) {
                  var response = await Provider.of<CheckOutProvider>(context,
                          listen: false)
                      .saveAddress(
                          CheckOutModel(
                              orderType: "gift",
                              myName: myNameController.text.trim(),
                              myPhone: myMobileNumberController.text.trim(),
                              to: toContoller.text.trim(),
                              message: message.text.trim(),
                              date: selectedDate.toString(),
                              makeAnonymous: anonymous,
                              deliveryType: selectedDay),
                          token);
                  print(response);
                  if (response != null) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return VoucherBuyNowPaymentScreen(
                            quantity: widget.quantity,
                            voucher: voucher!,
                            addressId: response.addressId.toString());
                      },
                    ));
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => BuyNowPaymentScreen(
                    //         quantity: widget.quantity,
                    //         product: item,
                    //         addressId: response.addressId.toString(),
                    //       ),
                    //     ));
                  }
                }
              },
              child: Container(
                width: querySize.width * 0.4,
                height: querySize.height * 0.055,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.08),
                ),
                child: Center(
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: querySize.height * 0.04,
        ),
      ],
    );
  }

  Column giftMySelfSection(
    Size querySize,
    BuildContext context,
    VoucherDetailModel? voucher,
    String? voucherPrice,
    TextEditingController myName,
    TextEditingController myMobileNumber,
    TextEditingController toContoller,
    TextEditingController message,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSizedBox(querySize),
        Text(
          'My Details',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF667080),
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.017),
        ),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/first_name_icon.png",
            'Enter Your Name',
            'Your Name',
            myName,
            errorMessage: selfMyNameError),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/qatar_flag_icon.png",
            'Enter Your Number',
            'Mobile Number',
            myMobileNumber,
            errorMessage: selfMyNumberError),
        customOneSizedBox(querySize),
        Container(
            width: querySize.width * 1,
            height: querySize.height * 0.385,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(querySize.width * 0.03)),
            child: Padding(
              padding: EdgeInsets.all(querySize.width * 0.038),
              child: Column(
                children: [
                  checkOutMessageColumn(querySize, 'To', toContoller),
                  customOneSizedBox(querySize),
                  Container(
                    width: querySize.width * 0.88,
                    height: querySize.height * 0.18,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEEEE),
                      borderRadius:
                          BorderRadius.circular(querySize.width * 0.02),
                    ),
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: querySize.height * 0.01,
                            horizontal: querySize.width * 0.04),
                        hintText: 'Card Message',
                        hintStyle: TextStyle(
                            fontSize: querySize.height * 0.02,
                            color: const Color(0xFFAAAEAE),
                            fontFamily: 'Segoe'),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  customOneSizedBox(querySize),
                ],
              ),
            )),
        customOneSizedBox(querySize),
        Text(
          'Pick a date',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF667080),
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.017),
        ),
        SizedBox(
          height: querySize.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selfTodaySelected = !selfTodaySelected;
                  selfTommorrowSelected = false;
                });
                if (todaySelected == true) {
                  selfSelectedDay = 'today';
                  selfSelectedDate =
                      DateFormat('yyyy-MM-dd').format(DateTime.now());
                }
                print(todaySelected);
              },
              child: Container(
                width: querySize.width * 0.28,
                height: querySize.height * 0.045,
                decoration: BoxDecoration(
                  color: selfTodaySelected ? Colors.blue : appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.02),
                ),
                child: Center(
                  child: Text(
                    'Today',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selfTodaySelected = false;
                  selfTommorrowSelected = !tommorrowSelected;
                });
                if (todaySelected == true) {
                  selfSelectedDay = 'tomorrow';
                  selfSelectedDate = DateFormat('yyyy-MM-dd')
                      .format(DateTime.now().add(Duration(days: 1)));
                }
              },
              child: Container(
                width: querySize.width * 0.28,
                height: querySize.height * 0.045,
                decoration: BoxDecoration(
                  color: selfTommorrowSelected ? Colors.blue : appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.02),
                ),
                child: Center(
                  child: Text(
                    'Tomorrow',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  selfTodaySelected = false;
                  selfTommorrowSelected = false;
                });
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(const Duration(days: 1)),
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  selfSelectedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                }
              },
              child: Container(
                width: querySize.width * 0.28,
                height: querySize.height * 0.045,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.02),
                ),
                child: Center(
                  child: Text(
                    'Pick a date',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ),
            ),
          ],
        ),
        customSizedBox(querySize),
        Row(
          children: [
            SizedBox(
              width: querySize.width * 0.07,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Segoe',
                      fontSize: querySize.height * 0.02),
                ),
                Text(
                  "QAR ${voucherPrice}",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: appColor,
                      fontFamily: 'Segoe',
                      fontSize: querySize.height * 0.026),
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                String token = (await AuthProvider().getToken())!;
                validateFields();
                if (selfMyNameError == null && selfMyNumberError == null) {
                  var response = await Provider.of<CheckOutProvider>(context,
                          listen: false)
                      .saveAddress(
                          CheckOutModel(
                              orderType: "myself",
                              myName: myNameController.text.trim(),
                              myPhone: myMobileNumberController.text.trim(),
                              gifteeName: giftteeNameController.text.trim(),
                              gifteePhone:
                                  giftteemobileNumberController.text.trim(),
                              to: toContoller.text.trim(),
                              message: message.text.trim(),
                              date: selectedDate.toString(),
                              makeAnonymous: '0',
                              deliveryType: selectedDay),
                          token);
                  if (response != null) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return VoucherBuyNowPaymentScreen(
                            quantity: widget.quantity,
                            voucher: voucher!,
                            addressId: response.addressId.toString());
                      },
                    ));
                  }
                }
              },
              child: Container(
                width: querySize.width * 0.4,
                height: querySize.height * 0.055,
                decoration: BoxDecoration(
                  color: appColor,
                  borderRadius: BorderRadius.circular(querySize.width * 0.08),
                ),
                child: Center(
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: querySize.height * 0.04,
        ),
      ],
    );
  }

  Container pickATime(Size querySize, String day) {
    return Container(
      width: querySize.width * 0.43,
      height: querySize.height * 0.045,
      decoration: BoxDecoration(
        color: const Color(0xFF939393),
        borderRadius: BorderRadius.circular(querySize.width * 0.02),
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.017),
        ),
      ),
    );
  }

  // Container pickADateWidget(Size querySize, String day) {
  //   return Container(
  //     width: querySize.width * 0.28,
  //     height: querySize.height * 0.045,
  //     decoration: BoxDecoration(
  //       color: appColor,
  //       borderRadius: BorderRadius.circular(querySize.width * 0.02),
  //     ),
  //     child: Center(
  //       child: Text(
  //         day,
  //         style: TextStyle(
  //             fontWeight: FontWeight.w600,
  //             color: Colors.white,
  //             fontFamily: 'Segoe',
  //             fontSize: querySize.height * 0.017),
  //       ),
  //     ),
  //   );
  // }

  Container checkOutMessageColumn(
      Size querySize, String hintText, TextEditingController controller) {
    return Container(
      width: querySize.width * 0.88,
      height: querySize.width * 0.13,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(querySize.width * 0.02),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: querySize.height * 0.01,
              horizontal: querySize.width * 0.04),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: querySize.height * 0.02,
              color: const Color(0xFFAAAEAE),
              fontFamily: 'Segoe'),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
