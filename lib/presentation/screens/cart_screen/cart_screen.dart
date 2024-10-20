import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/check_out_screen/check_out_screen.dart';
import 'package:lenore/presentation/widgets/cart_top_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customOneSizedBox(querySize),
                  cartTopBar(querySize, context, "Cart"),
                  // customTopBar(querySize, context),
                  SizedBox(
                    height: querySize.height * 0.03,
                  ),
                  customCartProductContainer(querySize),
                  SizedBox(
                    height: querySize.height * 0.03,
                  ),
                  customCartProductContainer(querySize),
                  customHeightThree(querySize),
                  Row(
                    children: [
                      Container(
                        width: querySize.width * (0.58),
                        height: querySize.height * 0.06,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(querySize.width * 0.03)),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter Promo Code",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: querySize.height * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const EditProfileScreen(),
                          //     ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00ACB3),
                          minimumSize: Size(
                            querySize.width * 0.29,
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
                                "QAR 450.00",
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
                                "-QAR 150.00",
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
                                "QAR 300.00",
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
                              Text('QAR 300.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF667080),
                                      fontFamily: 'Segoe',
                                      fontSize: querySize.height * 0.022))
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
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
        )),
      ),
    );
  }

  Container customCartProductContainer(Size querySize) {
    return Container(
      width: querySize.width * 1,
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
            children: [
              SizedBox(
                height: querySize.height * 0.055,
              ),
              Row(
                children: [
                  SizedBox(
                    width: querySize.width * 0.04,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEF1F4),
                      shape: BoxShape.circle, // Makes the container circular
                    ),
                    width: querySize.width * 0.08, // Width of the circle
                    height: querySize.width *
                        0.08, // Height of the circle (same as width)
                    child: Center(
                      child: Icon(
                        Icons.remove,
                        size: querySize.width * 0.05,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: querySize.width * 0.03,
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFC3C6C9),
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.024),
                  ),
                  SizedBox(
                    width: querySize.width * 0.03,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEF1F4),
                      shape: BoxShape.circle, // Makes the container circular
                    ),
                    width: querySize.width * 0.08, // Width of the circle
                    height: querySize.width *
                        0.08, // Height of the circle (same as width)
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: querySize.width * 0.05,
                      ),
                    ),
                  )
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xFFEEF1F4),
                  //     borderRadius:
                  //         BorderRadius.circular(querySize.width * 0.01),
                  //   ),
                  //   width: querySize.width * 0.08,
                  //   height: querySize.width * 0.08,
                  //   child: Icon(size: querySize.height * 0.029, Icons.add),
                  // ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
