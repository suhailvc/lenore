import 'package:flutter/material.dart';

import 'package:lenore/application/provider/sub_category_provider/sub_category_provider.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/presentation/screens/sub_category_screen/widget/sub_category_product_card.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/multiple_shimmer.dart';

import 'package:provider/provider.dart';

class SubCategoryScreen extends StatefulWidget {
  final String screenName;
  final String categoryName;
  final int id;
  const SubCategoryScreen(
      {required this.categoryName,
      required this.id,
      required this.screenName,
      super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  void initState() {
    Provider.of<SubCategoryProvider>(context, listen: false)
        .fetchSubCategoriesItems(
            categoryName: widget.categoryName, id: widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("------------------------------------${widget.categoryName}");
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
              customHeightThree(querySize),
              Text(
                widget.screenName,
                style: TextStyle(
                    color: const Color(0xFF008186),
                    fontSize: querySize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri'),
              ),
              customSizedBox(querySize),
              Consumer<SubCategoryProvider>(
                builder: (context, subCategoryvalue, child) {
                  if (subCategoryvalue.isLoading) {
                    return multipleShimmerLoading(
                        containerHeight: querySize.height * 0.04);
                    //  return lenoreGif(querySize);
                  } else if (subCategoryvalue.error ==
                      "No data available for this category") {
                    return Container(
                      child: Center(
                        child: Text('"No data available for this category"'),
                      ),
                    );
                  } else if (subCategoryvalue.subCategoryItems == null) {
                    return Container(
                      child: Center(
                        child: Text('"No data available for this category"'),
                      ),
                    );
                  }
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: subCategoryvalue.subCategoryItems!.data!.length,
                    itemBuilder: (context, index) {
                      // return GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) =>
                      //               SubCategoryProductListingScreen(
                      //                   eventId: subCategoryvalue
                      //                       .subCategoryItems!.data![index].id!,
                      //                   eventName: 'sub-category',
                      //                   productListingScreenName:
                      //                       subCategoryvalue.subCategoryItems!
                      //                           .data![index].name!),
                      //         ));
                      //   },
                      //child:
                      return subCategoryCard(
                          subCategoryvalue
                              .subCategoryItems!.data![index].image!,
                          subCategoryvalue.subCategoryItems!.data![index].name!,
                          querySize,
                          context,
                          subCategoryvalue.subCategoryItems!.data![index].id!,
                          'sub-category');
                      //  );
                    },
                  );
                },
              )
              // GridView.count(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   crossAxisCount: 4,
              //   crossAxisSpacing: 10.0,
              //   mainAxisSpacing: 16.0,
              //   childAspectRatio: 1.1,
              //   children: [
              //     subCategoryCard("assets/images/sub_category_product/ring.png",
              //         "Rings", querySize, context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/earing.png",
              //         "Earings",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/pendants.png",
              //         "Pendants",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/necklase.png",
              //         "Necklaces",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/bangles.png",
              //         "Bangles",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/bracelet.png",
              //         "Bracelet",
              //         querySize,
              //         context),
              //     subCategoryCard("assets/images/sub_category_product/ring.png",
              //         "Rings", querySize, context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/earing.png",
              //         "Earings",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/pendants.png",
              //         "Pendants",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/necklase.png",
              //         "Necklaces",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/bangles.png",
              //         "Bangles",
              //         querySize,
              //         context),
              //     subCategoryCard(
              //         "assets/images/sub_category_product/bracelet.png",
              //         "Bracelet",
              //         querySize,
              //         context),
              //   ],
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
