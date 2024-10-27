import 'package:flutter/material.dart';
import 'package:lenore/application/provider/home_provider/gift_by_category/gift_by_category_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/gift_by%20category_screen/widget/constants.dart';

import 'package:lenore/presentation/screens/sub_category_screen/sub_category_screen.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/cutom_bottom_bar_top_bar.dart';
import 'package:provider/provider.dart';

class GiftByCategoryScreen extends StatefulWidget {
  final Row widget;
  const GiftByCategoryScreen({required this.widget, super.key});

  @override
  State<GiftByCategoryScreen> createState() => _GiftByCategoryScreenState();
}

class _GiftByCategoryScreenState extends State<GiftByCategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GiftByCategoryProvider>(context, listen: false)
          .giftByCategoryProviderMethod();
    });
    super.initState();
  }

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
                    children: [customOneSizedBox(querySize), widget.widget],
                  ),
                ),
                customSizedBox(querySize),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                  child: Text(
                    'Gift By Category',
                    style: TextStyle(
                        color: const Color(0xFF008186),
                        fontSize: querySize.width * 0.05,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ElMessiri'),
                  ),
                ),
                customSizedBox(querySize),
                Padding(
                    padding: EdgeInsets.only(
                      left: querySize.width * 0.04,
                      right: querySize.width * 0.03,
                    ),
                    child: Consumer<GiftByCategoryProvider>(
                      builder: (context, giftByCategoryValue, child) {
                        if (giftByCategoryValue.isLoading) {
                          return CircularProgressIndicator();
                        } else if (giftByCategoryValue.cachedResponse!.data ==
                                null ||
                            giftByCategoryValue.cachedResponse!.data!.isEmpty) {
                          return SizedBox();
                        }
                        return GridView.builder(
                          itemCount:
                              giftByCategoryValue.cachedResponse!.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // crossAxisSpacing: querySize.height * 0.0,
                            mainAxisSpacing: querySize.height * 0.02,
                            childAspectRatio: 1,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                //if (index == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SubCategoryScreen(
                                          categoryName: "gift-by-category",
                                          id: giftByCategoryValue
                                              .cachedResponse!.data![index].id!,
                                          screenName: giftByCategoryValue
                                              .cachedResponse!
                                              .data![index]
                                              .name!),
                                    ));
                                // }
                                // if (index == 1) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               const SubCategoryScreen(
                                //                   screenName: "Gold")));
                                // }
                                // if (index == 2) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const SubCategoryScreen(
                                //                 screenName: "Silver"),
                                //       ));
                                // }
                                // if (index == 3) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const SubCategoryScreen(
                                //                 screenName: "Pearl"),
                                //       ));
                                // }
                                // if (index == 4) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const SubCategoryScreen(
                                //                 screenName: "Sets"),
                                //       ));
                                // }
                                // if (index == 5) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const SubCategoryScreen(
                                //                 screenName: "Diamond"),
                                //       ));
                                // }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: querySize.width * 0.025),
                                width: 150.16 / 375.0 * querySize.width,
                                // height: 200.7 / 812.0 * querySize.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      querySize.height * 0.01),
                                  image: DecorationImage(
                                    image: NetworkImage(giftByCategoryValue
                                        .cachedResponse!.data![index].image!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              querySize.height * 0.01),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(
                                                  0.6), // Darken bottom part
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: querySize.height * 0.004,
                                      left: 0,
                                      right: 0,
                                      child: Text(
                                        giftByCategoryValue.cachedResponse!
                                                .data![index].name ??
                                            'No Name',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                              13.69 / 375.0 * querySize.width,
                                          fontFamily: 'NunitoSans',
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 4,
                                              color: Colors.black.withOpacity(
                                                  0.7), // Text shadow
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // child: Container(
                              //   margin: EdgeInsets.only(
                              //       right: querySize.width * 0.025),
                              //   width: 150.16 / 375.0 * querySize.width,
                              //   // height: 200.7 / 812.0 * querySize.height,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(
                              //         querySize.height * 0.01),
                              //     image: DecorationImage(
                              //       image: NetworkImage(giftByCategoryValue
                              //           .cachedResponse!.data![index].image!),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       Text(
                              //         giftByCategoryValue
                              //             .cachedResponse!.data![index].name!,
                              //         textAlign: TextAlign.center,
                              //         style: TextStyle(
                              //             fontSize:
                              //                 13.69 / 375.0 * querySize.width,
                              //             fontFamily: 'NunitoSans',
                              //             color: Colors.white),
                              //       ),
                              //       SizedBox(
                              //         height: querySize.height * 0.004,
                              //       )
                              //     ],
                              //   ),
                              //)
                            );
                          },
                        );
                      },
                    ))
                // GridView.count(
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   crossAxisCount: 4,
                //   crossAxisSpacing: 10.0,
                //   mainAxisSpacing: 16.0,
                //   childAspectRatio: 1.1,
                //   children: [],
                // ),
              ],
            ),
          ),
        ));
  }
}
