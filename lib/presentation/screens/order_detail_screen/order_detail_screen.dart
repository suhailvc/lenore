import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/order_detail_provider/order_detail_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/domain/order_detail_model/order_detail_model.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/widgets/multiple_shimmer.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailScreen({required this.orderId, super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOrderDetail();
  }

  Future<void> _fetchOrderDetail() async {
    final authProvider =
        await Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();

    if (token != null) {
      Provider.of<OrderDetailProvider>(context, listen: false)
          .fetchOrderHistory(token, widget.orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customSizedBox(querySize),
              customProfileTopBar(querySize, context, "Order Details"),
              customSizedBox(querySize),
              Consumer<OrderDetailProvider>(
                  builder: (context, orderDetailValue, child) {
                if (orderDetailValue.isLoading) {
                  return multipleShimmerLoading(
                      containerHeight: querySize.height * 0.06);
                  // return lenoreGif(querySize);
                } else if (orderDetailValue.orderDetail == null ||
                    orderDetailValue
                        .orderDetail!.data!.productDetails!.isEmpty) {
                  return SizedBox();
                }
                return Container(
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
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderDetailValue
                            .orderDetail!.data!.productDetails!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              orderItem(querySize,
                                  orderDetailValue.orderDetail!, index),
                              // index !=
                              //         orderDetailValue.orderDeatil!.data!
                              //             .productDetails!.length
                              //     ? DottedLine(
                              //         dashColor: const Color(0x6670802E),
                              //         lineLength: querySize.width * .8,
                              //       )
                              //     : SizedBox()
                            ],
                          );
                        },
                      ),
                      // orderItem(querySize),
                      // orderItem(querySize),
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
                                Text(
                                    orderDetailValue
                                            .orderDetail!.data!.orderDate ??
                                        "",
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
                                  orderDetailValue
                                          .orderDetail!.data!.couponCode ??
                                      '',
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
                                  orderDetailValue
                                          .orderDetail!.data!.deliveryDate ??
                                      "",
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
                                  orderDetailValue
                                          .orderDetail!.data!.paymentMode ??
                                      '',
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
                                  "${orderDetailValue.orderDetail!.data!.amount} QAR",
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
                                  "${orderDetailValue.orderDetail!.data!.discount ?? ''} QAR",
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
                                  "${orderDetailValue.orderDetail!.data!.deliveryCharge} QAR",
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
                            // SizedBox(
                            //   height: querySize.height * 0.01,
                            // ),
                            // Container(
                            //   width: double.infinity,
                            //   height: querySize.height * 0.053,
                            //   decoration: BoxDecoration(
                            //     color: appColor,
                            //     borderRadius: BorderRadius.circular(
                            //         querySize.width * 0.08),
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       'Share Reciept',
                            //       style: TextStyle(
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.white,
                            //           fontFamily: 'Segoe',
                            //           fontSize: querySize.height * 0.017),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: querySize.height * 0.03,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      )),
    );
  }

  orderItem(Size querySize, OrderDetailModel orderDetail, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(querySize.width * 0.03),
          child: Container(
            width: querySize.width * 0.3,
            height: querySize.width * 0.28,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      orderDetail.data!.productDetails![index].image ?? ''),
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
              orderDetail.data!.productDetails![index].name ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF353E4D),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.014),
            ),
            Text(
              orderDetail.data!.productDetails![index].id.toString(),
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
              'QAR ${orderDetail.data!.productDetails![index].amount}',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF667080),
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.016),
            ),
            SizedBox(
              height: querySize.height * 0.01,
            ),
            // Text(
            //   'Size: US 7',
            //   style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       color: const Color.fromARGB(53, 2, 42, 68),
            //       fontFamily: 'Segoe',
            //       fontSize: querySize.height * 0.014),
            // ),
          ],
        ),
      ],
    );
  }
}
