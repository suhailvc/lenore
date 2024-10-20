import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
        child: Column(
          children: [
            customSizedBox(querySize),
            customProfileTopBar(querySize, context, "Order Details"),
            customSizedBox(querySize),
            Container(
              width: double.infinity,
              //height: querySize.height * 0.72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(querySize.width * 0.03),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: querySize.width * 0.01,
                    offset: Offset(0, querySize.width * 0.013),
                  ),
                ],
              ),
              child: Column(
                children: [
                  orderItem(querySize),
                  DottedLine(
                    dashColor: const Color(0x6670802E),
                    lineLength: querySize.width * .8,
                  ),
                  orderItem(querySize),
                  customSizedBox(querySize),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: querySize.width * 0.035),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            const Spacer(),
                            Text("01-Aug-2024 . 6.06 AM",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF252525),
                                    fontFamily: 'Segoe',
                                    fontSize: querySize.height * 0.017))
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Promo Code",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            const Spacer(),
                            Text(
                              "AUGFD",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Delivery Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            const Spacer(),
                            Text(
                              "01-Aug-2024 . 6.06 AM",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Payment Mode",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            const Spacer(),
                            Text(
                              "Cash On Delivery",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Divider(
                          thickness: querySize.height * 0.0007,
                          color: const Color(0x6670802E),
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            Spacer(),
                            Text(
                              "99 QAR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Discount",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            Spacer(),
                            Text(
                              "-10 QAR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Row(
                          children: [
                            Text(
                              "Deliver Fee",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF252525),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                            Spacer(),
                            Text(
                              "10 QAR",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFFE5656),
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            )
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Divider(
                          thickness: querySize.height * 0.0007,
                          color: const Color(0x6670802E),
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        Container(
                          width: double.infinity,
                          height: querySize.height * 0.053,
                          decoration: BoxDecoration(
                            color: appColor,
                            borderRadius:
                                BorderRadius.circular(querySize.width * 0.08),
                          ),
                          child: Center(
                            child: Text(
                              'Share Reciept',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Segoe',
                                  fontSize: querySize.height * 0.017),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: querySize.height * 0.03,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  orderItem(Size querySize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(querySize.width * 0.03),
          child: Container(
            width: querySize.width * 0.3,
            height: querySize.width * 0.28,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/carts/cart_image.png"),
                  fit: BoxFit.cover),
              //  color: Colors.red,
              borderRadius: BorderRadius.circular(querySize.width * 0.01),
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
              'Engagement Tie Ring',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF353E4D),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.014),
            ),
            Text(
              '22kt Yellow Gold',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF353E4D),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.014),
            ),
            SizedBox(
              height: querySize.height * 0.01,
            ),
            Text(
              'QAR 249',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF667080),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.016),
            ),
            SizedBox(
              height: querySize.height * 0.01,
            ),
            Text(
              'Size: US 7',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(53, 2, 42, 68),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.014),
            ),
          ],
        ),
      ],
    );
  }
}
