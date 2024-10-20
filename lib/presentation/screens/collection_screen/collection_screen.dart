import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/presentation/screens/product_listng_screen/product_listing_screen.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

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
                customSizedBox(querySize),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
                  child: Text(
                    'Collection',
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
                  child: GridView.builder(
                    itemCount: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // crossAxisSpacing: querySize.height * 0.0,
                      mainAxisSpacing: querySize.height * 0.02,
                      childAspectRatio: .9,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListingScreen(
                                            productListingScreenName: 'Laura'),
                                  ));
                            }
                            if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductListingScreen(
                                              productListingScreenName:
                                                  "ZRI")));
                            }
                            if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListingScreen(
                                            productListingScreenName: "WARDA"),
                                  ));
                            }
                            if (index == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListingScreen(
                                            productListingScreenName: "ZRI"),
                                  ));
                            }
                            if (index == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListingScreen(
                                            productListingScreenName: "WARDA"),
                                  ));
                            }
                            if (index == 5) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListingScreen(
                                            productListingScreenName: "LAURA"),
                                  ));
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: querySize.width * 0.025),
                                //  width: 127.16 / 375.0 * querySize.width,
                                height: querySize.height * 0.13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      querySize.width * 0.03),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(collectionListPhotos[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                collectionListName[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.69 / 375.0 * querySize.width,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Segoe',
                                    color: const Color(0xFF00ACB3)),
                              ),
                            ],
                          ));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
