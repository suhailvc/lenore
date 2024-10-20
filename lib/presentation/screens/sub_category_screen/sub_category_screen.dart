import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/presentation/screens/sub_category_screen/widget/sub_category_product_card.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class SubCategoryScreen extends StatelessWidget {
  final String screenName;
  const SubCategoryScreen({required this.screenName, super.key});

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
              customHeightThree(querySize),
              Text(
                screenName,
                style: TextStyle(
                    color: const Color(0xFF008186),
                    fontSize: querySize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri'),
              ),
              customSizedBox(querySize),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.1,
                children: [
                  subCategoryCard("assets/images/sub_category_product/ring.png",
                      "Rings", querySize, context),
                  subCategoryCard(
                      "assets/images/sub_category_product/earing.png",
                      "Earings",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/pendants.png",
                      "Pendants",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/necklase.png",
                      "Necklaces",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/bangles.png",
                      "Bangles",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/bracelet.png",
                      "Bracelet",
                      querySize,
                      context),
                  subCategoryCard("assets/images/sub_category_product/ring.png",
                      "Rings", querySize, context),
                  subCategoryCard(
                      "assets/images/sub_category_product/earing.png",
                      "Earings",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/pendants.png",
                      "Pendants",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/necklase.png",
                      "Necklaces",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/bangles.png",
                      "Bangles",
                      querySize,
                      context),
                  subCategoryCard(
                      "assets/images/sub_category_product/bracelet.png",
                      "Bracelet",
                      querySize,
                      context),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
