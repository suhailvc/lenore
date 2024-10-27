import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:lenore/application/provider/home_provider/gift_by_voucher_provider/gift_by_voucher_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/gift_by_voucher_detail_screen.dart/gift_by_voucher_detail_screen.dart';

import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class GiftByVoucherScreen extends StatelessWidget {
  final GiftByVoucherProvider giftByVoucherProvider;
  const GiftByVoucherScreen({required this.giftByVoucherProvider, super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customOneSizedBox(querySize),
                      customTopBar(querySize, context),
                    ],
                  ),
                ),
                customHeightThree(querySize),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gift By Voucher',
                        style: TextStyle(
                            color: const Color(0xFF008186),
                            fontSize: querySize.width * 0.05,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'ElMessiri'),
                      ),
                      customSizedBox(querySize),
                      GridView.builder(
                        itemCount: giftByVoucherProvider
                            .giftByVoucherItems!.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: querySize.height * 0.02,
                          mainAxisSpacing: querySize.height * 0.02,
                          childAspectRatio: 2.2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GiftByVoucherDetailScreen(),
                                  ));
                            },
                            child: Container(
                              width: querySize.width * 0.42,
                              height: querySize.height * 0.03,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: const Offset(2, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: const Color(0xFFF3BC8B),
                                  width: querySize.width * 0.007,
                                ),
                                color: const Color(0xFFFBE8DC),
                                borderRadius: BorderRadius.circular(
                                    querySize.width * 0.04),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: querySize.width * 0.1,
                                  ),
                                  DottedLine(
                                    direction: Axis.vertical,
                                    alignment: WrapAlignment.center,
                                    lineLength: querySize.height * 0.08,
                                    lineThickness: querySize.width * 0.0035,
                                    dashLength: 4.0,
                                    dashColor: const Color(0xFFFBE8DC),
                                    dashRadius: 0.0,
                                    dashGapLength: 5.0,
                                    dashGapColor: Colors.black,
                                    dashGapRadius: 0.0,
                                  ),
                                  SizedBox(
                                    width: querySize.width * 0.04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: querySize.height * 0.02,
                                      ),
                                      Text(
                                        '${giftByVoucherProvider.giftByVoucherItems!.data![index].amount} QR',
                                        style: TextStyle(
                                            fontSize: querySize.height * 0.025,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Segoe',
                                            color: const Color(0xFF00ACB3)),
                                      ),
                                      Text(
                                        giftByVoucherProvider
                                            .giftByVoucherItems!
                                            .data![index]
                                            .name!,
                                        style: TextStyle(
                                            fontSize: querySize.height * 0.013,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Segoe',
                                            color: const Color(0xFF00ACB3)),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
