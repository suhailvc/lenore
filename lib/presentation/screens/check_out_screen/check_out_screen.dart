import 'package:flutter/material.dart';
import 'package:lenore/application/provider/check_out_provider/check_box_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/check_out_screen/widget/customCheckOutField.dart';
import 'package:lenore/presentation/screens/payment_screen/payment_screen.dart';
import 'package:lenore/presentation/widgets/cart_top_bar.dart';

import 'package:provider/provider.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customOneSizedBox(querySize),
                  cartTopBar(querySize, context, 'Check Out'),
                  customSizedBox(querySize),
                  Container(
                    width: querySize.width * 1,
                    height: querySize.height * 0.2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(querySize.width * 0.03)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(querySize.width * 0.03),
                          child: Container(
                            width: querySize.width * 0.31,
                            height: querySize.width * 0.33,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/carts/check_out_image.png"),
                                  fit: BoxFit.cover),
                              // color: Colors.red,
                              borderRadius:
                                  BorderRadius.circular(querySize.width * 0.02),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: querySize.height * 0.022,
                            ),
                            Text(
                              'QAR 756',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                  fontFamily: 'ElMessiri',
                                  fontSize: querySize.height * 0.025),
                            ),
                            Text(
                              'Product | Name and prices laura ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF353E4D),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.013),
                            ),
                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                            Text(
                              "Lorem Ipsum is simply dummy text of the printing and \ntypesetting industry. Lorem Ipsum has been the \nindustry's standard.Lorem Ipsum is simply dummy text \nof the printing and typesetting industry. Lorem Ipsum \nhas been the industry's standard.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF667080),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.01),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                            SizedBox(
                              height: querySize.height * 0.01,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  customSizedBox(querySize),
                  Text(
                    'Send Message',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF667080),
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.017),
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
                                  fontSize: querySize.height * 0.016),
                            )
                          ],
                        ),
                        //  SizedBox(height: querySize.height * 0.005),
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
                                  fontSize: querySize.height * 0.016),
                            )
                          ],
                        ),
                        if (checkBox.giftMySelfChecked)
                          giftMySelfSection(querySize, context),

                        // Show Container2 when 'Send As Gift' is checked
                        if (checkBox.sendAsGift)
                          sendAsGiftSection(querySize, context),
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Column sendAsGiftSection(Size querySize, BuildContext context) {
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
            'Your Name'),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/qatar_flag_icon.png",
            'Enter Your Number',
            'Mobile Number'),
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
            'Giftee Name'),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/qatar_flag_icon.png",
            'Enter Giftee Number',
            'Giftee Mobile Number'),
        SizedBox(
          height: querySize.width * 0.01,
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
              value: false,
              onChanged: (value) {},
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
                  checkOutMessageColumn(querySize, 'To'),
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
                  checkOutMessageColumn(querySize, 'From'),
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
            pickADateWidget(querySize, 'Today'),
            pickADateWidget(querySize, 'Tomorrow'),
            pickADateWidget(querySize, 'Pick a date'),
          ],
        ),
        customSizedBox(querySize),
        Text(
          'Select Delivery Time',
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
            pickATime(querySize, '8:30 AM-11:00 AM'),
            pickATime(querySize, '11:00 AM-1:30 PM'),
          ],
        ),
        customOneSizedBox(querySize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pickATime(querySize, '2:00 PM-4:30 PM'),
            pickATime(querySize, '5:00 AM-7:30 PM'),
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
                  "QAR 750",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: appColor,
                      fontFamily: 'Segoe',
                      fontSize: querySize.height * 0.026),
                )
              ],
            ),
            const Spacer(),
            Container(
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
            )
          ],
        ),
        SizedBox(
          height: querySize.height * 0.04,
        ),
      ],
    );
  }

  Column giftMySelfSection(Size querySize, BuildContext context) {
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
            'Your Name'),
        customOneSizedBox(querySize),
        customCheckOutField(
            context,
            "assets/images/profile/qatar_flag_icon.png",
            'Enter Your Number',
            'Mobile Number'),
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
                  checkOutMessageColumn(querySize, 'To'),
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
                  checkOutMessageColumn(querySize, 'From'),
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
            pickADateWidget(querySize, 'Today'),
            pickADateWidget(querySize, 'Tomorrow'),
            pickADateWidget(querySize, 'Pick a date'),
          ],
        ),
        customSizedBox(querySize),
        Text(
          'Select Delivery Time',
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
            pickATime(querySize, '8:30 AM-11:00 AM'),
            pickATime(querySize, '11:00 AM-1:30 PM'),
          ],
        ),
        customOneSizedBox(querySize),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            pickATime(querySize, '2:00 PM-4:30 PM'),
            pickATime(querySize, '5:00 AM-7:30 PM'),
          ],
        ),
        SizedBox(
          height: querySize.height * 0.04,
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
                  "QAR 750",
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ));
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

  Container pickADateWidget(Size querySize, String day) {
    return Container(
      width: querySize.width * 0.28,
      height: querySize.height * 0.045,
      decoration: BoxDecoration(
        color: appColor,
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

  Container checkOutMessageColumn(Size querySize, String hintText) {
    return Container(
      width: querySize.width * 0.88,
      height: querySize.width * 0.13,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEEEE),
        borderRadius: BorderRadius.circular(querySize.width * 0.02),
      ),
      child: TextFormField(
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
