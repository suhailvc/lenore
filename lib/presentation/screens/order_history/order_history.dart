import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/order_detail_screen/order_detail_screen.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customOneSizedBox(querySize),
              customTopBar(querySize, context),
              customSizedBox(querySize),
              Text(
                "Order History",
                style: TextStyle(
                    fontSize: querySize.width * 0.06,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ElMessiri',
                    color: textColor),
              ),
              customSizedBox(querySize),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: querySize.width * 1,
                        height: querySize.height * 0.17,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(querySize.width * 0.03),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: querySize.width * 0.001,
                              blurRadius: querySize.width * 0.02,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(querySize.width * 0.03),
                              child: Container(
                                width: querySize.width * 0.3,
                                height: querySize.width * 0.28,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/carts/cart_image.png"),
                                      fit: BoxFit.cover),
                                  //  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                      querySize.width * 0.01),
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
                                      fontSize: querySize.height * 0.012),
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
                                      color: const Color(0xFF353E4D),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.014),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: querySize.width * 0.1,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const OrderDetailScreen(),
                                            ));
                                      },
                                      child: Text(
                                        'Order Detail',
                                        style: TextStyle(
                                          fontSize: querySize.width * 0.028,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Jost',
                                          color: const Color(0xFF667080),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: querySize.height * 0.02,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: querySize.height * 0.02,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
