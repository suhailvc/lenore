import 'package:flutter/material.dart';
import 'package:lenore/application/provider/home_provider/collection_provider/collection_provider.dart';
import 'package:lenore/application/provider/product_listing_provider/product_listing_provder.dart';
import 'package:lenore/core/constant.dart';

import 'package:lenore/presentation/screens/product_listng_screen/product_listing_screen.dart';
import 'package:lenore/presentation/screens/sub_category_product_listing_screen/sub_category_product_listing_screen.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class CollectionScreen extends StatefulWidget {
  final CollectionProvider collections;
  const CollectionScreen({required this.collections, super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
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
                    itemCount: widget.collections.collectionItems.data!.length,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubCategoryProductListingScreen(
                                            eventId: widget
                                                .collections
                                                .collectionItems
                                                .data![index]
                                                .id!,
                                            eventName: 'collections',
                                            productListingScreenName: widget
                                                .collections
                                                .collectionItems
                                                .data![index]
                                                .name!)));
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
                                    image: NetworkImage(widget.collections
                                        .collectionItems.data![index].logo!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                widget.collections.collectionItems.data![index]
                                    .name!,
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
