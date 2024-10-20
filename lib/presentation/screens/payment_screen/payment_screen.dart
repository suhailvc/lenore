import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/payment_screen/widget/cutom_payment_list_tile.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.06),
          child: Column(
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
                  borderRadius: BorderRadius.circular(querySize.width * 0.03),
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
                          const Spacer(),
                          Image.asset(
                            'assets/images/edit_icon.png',
                            width: querySize.width * 0.049,
                            height: querySize.width * 0.049,
                          ),
                          SizedBox(width: querySize.width * 0.01),
                          Text(
                            "Edit",
                            style: TextStyle(
                              fontFamily: 'Segoe',
                              fontSize: querySize.width * 0.03,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF87A5A6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: querySize.height * 0.02,
                      ),
                      Text(
                        "Mohammed Suhail",
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: querySize.width * 0.039,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF858585),
                        ),
                      ),
                      SizedBox(
                        height: querySize.height * 0.01,
                      ),
                      Text(
                        "+971 71837374",
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: querySize.width * 0.037,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF858585),
                        ),
                      )
                    ],
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
                width: querySize.width * 0.88,
                height: querySize.height * 0.14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(querySize.width * 0.03),
                ),
                child: Padding(
                  padding: EdgeInsets.all(querySize.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customPaymentListTile(
                          querySize,
                          'assets/images/pay online.png',
                          'Pay Online',
                          "assets/images/selected_tick.png"),
                      customSizedBox(querySize),
                      customPaymentListTile(
                          querySize,
                          'assets/images/apple.png',
                          'Apple Pay',
                          "assets/images/un_selected_tick.png")
                    ],
                  ),
                ),
              ),
              customSizedBox(querySize),
              Container(
                padding: EdgeInsets.all(querySize.width * 0.046),
                width: querySize.width * 0.9,
                height: querySize.height * 0.21,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(querySize.width * 0.03),
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
                          "90 QAR",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFC3C6C9),
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
                              color: const Color(0xFF667080),
                              fontFamily: 'Segoe',
                              fontSize: querySize.height * 0.017),
                        ),
                        const Spacer(),
                        Text(
                          "-10 QAR",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFC3C6C9),
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
                          "Delivery Fee",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF667080),
                              fontFamily: 'Segoe',
                              fontSize: querySize.height * 0.017),
                        ),
                        const Spacer(),
                        Text(
                          "10 QAR",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFC3C6C9),
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
                          "Total",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF667080),
                              fontFamily: 'Segoe',
                              fontSize: querySize.height * 0.019),
                        ),
                        const Spacer(),
                        Text(
                          "100 QAR",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF667080),
                              fontFamily: 'Segoe',
                              fontSize: querySize.height * 0.019),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: querySize.height * 0.04,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: querySize.width * 0.058),
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
                        Text('QAR 300.00',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF00ACB3),
                                fontFamily: 'Segoe',
                                fontSize: querySize.height * 0.022))
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           const ,
                        //     ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00ACB3),
                        minimumSize: Size(
                          querySize.width * (160 / 375),
                          querySize.height * (48 / 812),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.045),
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
          ),
        ),
      ),
    );
  }
}
