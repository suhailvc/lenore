import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';

import 'package:lenore/application/provider/product_listing_provider/product_listing_provder.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/best_seller_new_arrival_listing_screen/widget/constants.dart';
import 'package:lenore/presentation/screens/filter_screen/filter_screen.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/multiple_shimmer.dart';
import 'package:provider/provider.dart';

class SubCategoryProductListingScreen extends StatefulWidget {
  final int eventId;
  final String productListingScreenName;
  final String eventName;
  const SubCategoryProductListingScreen(
      {required this.eventId,
      required this.eventName,
      required this.productListingScreenName,
      super.key});

  @override
  State<SubCategoryProductListingScreen> createState() =>
      _SubCategoryProductListingScreenState();
}

class _SubCategoryProductListingScreenState
    extends State<SubCategoryProductListingScreen> {
  int pageNo = 1;

  @override
  void initState() {
    print("eevvveeennnttttnnaammmmeee${widget.eventName}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FilterProvider>(context, listen: false).resetFilters();
      Provider.of<ProductListProvider>(context, listen: false)
          .productListProviderMethod(
              eventName: widget.eventName,
              id: widget.eventId,
              pageNo: pageNo.toString(),
              isPagination: false); // False because it's the initial load
      _fetchWishlist();
    });
    // Load the first page when the screen is initialized
    // Provider.of<FilterProvider>(context, listen: false).resetFilters();
    // Provider.of<ProductListProvider>(context, listen: false)
    //     .productListProviderMethod(
    //         eventName: widget.eventName,
    //         id: widget.eventId,
    //         pageNo: pageNo.toString(),
    //         isPagination: false); // False because it's the initial load
    // _fetchWishlist();
    super.initState();
  }

  Future<void> _fetchWishlist() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();
    if (token != null) {
      Provider.of<WishlistProvider>(context, listen: false)
          .fetchWishlist(token);
    } else {
      // Handle case where token is null, e.g., show an error or prompt login
      print("Token not available");
    }
  }
  // @override
  // void initState() {
  //   Provider.of<ProductListProvider>(context, listen: false)
  //       .productListProviderMethod(
  //           eventId: widget.eventId.toString(), pageNo: pageNo.toString());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('............iiidddddd......${widget.eventId}');
    print('.....iiidddddd......${widget.eventName}');
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customOneSizedBox(querySize),
                Padding(
                  padding: EdgeInsets.only(
                      left: querySize.height * 0.014,
                      right: querySize.height * 0.014),
                  child: customTopBar(querySize, context),
                ),
                customSizedBox(querySize),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: querySize.width * 0.04),
                    child: Consumer2<ProductListProvider, FilterProvider>(
                      builder: (context, productListvalue, filterValue, child) {
                        if (productListvalue.isLoading && pageNo == 1) {
                          return multipleShimmerLoading(
                              containerHeight: querySize.height * 0.06);
                          // return lenoreGif(querySize);
                        } else if ( //productListvalue.productListItems.data ==
                            //  null ||
                            //  productListvalue.productListItems.data!.isEmpty
                            newAllrivalList.data == null ||
                                newAllrivalList.data!.isEmpty) {
                          return Container(
                            height: querySize.height * 0.77,
                            child: Center(
                              child: Text('Product Coming Soon'),
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productListingScreenName,
                                style: TextStyle(
                                    color: const Color(0xFF008186),
                                    fontSize: querySize.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ElMessiri'),
                              ),
                              customSizedBox(querySize),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: newAllrivalList
                                    .data!.length, //productListvalue
                                //.productListItems.data!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: querySize.height * 0.015,
                                  // mainAxisSpacing: querySize.height * 001,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                        productId: newAllrivalList
                                                            .data![index]
                                                            .id! // productListvalue
                                                        // .productListItems
                                                        // .data![index]
                                                        // .id!,
                                                        ),
                                              ));
                                        },
                                        child: Container(
                                          height: querySize.height * 0.2,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE7E7E7),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  newAllrivalList.data![index]
                                                          .thumbImage ??
                                                      ''
                                                  // productListvalue
                                                  //     .productListItems
                                                  //     .data![index]
                                                  // .thumbImage!
                                                  ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: querySize.height *
                                                        0.008,
                                                    right: querySize.height *
                                                        0.012),
                                                child:
                                                    Consumer<WishlistProvider>(
                                                  builder: (context,
                                                      wishlistProvider, child) {
                                                    final isInWishlist = wishlistProvider
                                                        .isProductInWishlist(
                                                            // productListvalue
                                                            //     .productListItems
                                                            //     .data![
                                                            //         index]
                                                            //     .id! //
                                                            newAllrivalList
                                                                .data![index]
                                                                .id!);

                                                    return GestureDetector(
                                                      onTap: () async {
                                                        final authProvider =
                                                            Provider.of<
                                                                    AuthProvider>(
                                                                context,
                                                                listen: false);
                                                        final token =
                                                            await authProvider
                                                                .getToken();

                                                        if (token == null) {
                                                          customSnackBar(
                                                              context,
                                                              'Please SignIn');
                                                          return;
                                                        }

                                                        // Toggle wishlist status for this specific product
                                                        await wishlistProvider
                                                            .toggleWishlist(
                                                                token,
                                                                newAllrivalList
                                                                    .data![
                                                                        index]
                                                                    .id!
                                                                // productListvalue
                                                                //     .productListItems
                                                                //     .data![index]
                                                                // .id!
                                                                );
                                                      },
                                                      child: CircleAvatar(
                                                        radius:
                                                            querySize.width *
                                                                0.033,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: isInWishlist
                                                            ? Image.asset(
                                                                'assets/images/love (1).png',
                                                                width: querySize
                                                                        .width *
                                                                    0.048,
                                                                height: querySize
                                                                        .height *
                                                                    0.018,
                                                              )
                                                            : Image.asset(
                                                                'assets/images/home/favourite.png',
                                                                width: querySize
                                                                        .width *
                                                                    0.075,
                                                                height: querySize
                                                                        .height *
                                                                    0.037,
                                                              ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                // Image.asset(
                                                //   'assets/images/home/favourite.png',
                                                //   width: querySize.width * 0.075,
                                                //   height: querySize.height * 0.035,
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: querySize.height * 0.01),
                                      Row(
                                        children: [
                                          Text(
                                            "QAR ",
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 10.0,
                                            ),
                                          ),
                                          Text(
                                            newAllrivalList.data![index].price
                                                .toString(),
                                            // productListvalue.productListItems
                                            //     .data![index].price
                                            //     .toString(),
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        newAllrivalList.data![index].name!,
                                        // productListvalue.productListItems
                                        //     .data![index].name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.width * 0.032,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              if (pageNo < newAllrivalList.lastPage!
                                  // productListvalue.productListItems.lastPage!
                                  )
                                Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        //setState(() {
                                        pageNo++; // Increment the page number
                                        //  });
                                        Provider.of<ProductListProvider>(
                                                context,
                                                listen: false)
                                            .productListProviderMethod(
                                                eventName: widget.eventName,
                                                id: widget.eventId,
                                                pageNo: pageNo.toString(),
                                                isPagination: true);

                                        // Provider.of<ProductListProvider>(
                                        //         context,
                                        //         listen: false)
                                        //     .productListProviderMethod(
                                        //         eventId:
                                        //             widget.eventId.toString(),
                                        //         pageNo:
                                        //             (pageNo + 1).toString());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(querySize.width * 0.8,
                                            querySize.height * 0.05),
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: querySize.width * 0.15,
                                          vertical: querySize.height * 0.017,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            querySize.width * 0.08,
                                          ),
                                          side: BorderSide(
                                            color: const Color(0xFF00ACB3),
                                            width: querySize.height * 0.0018,
                                          ),
                                        ),
                                      ),
                                      child: productListvalue.isLoading &&
                                              pageNo > 1
                                          ? SizedBox(
                                              height: querySize.height * 0.02,
                                              width: querySize.height * 0.02,
                                              child: CircularProgressIndicator(
                                                color: appColor,
                                              ),
                                            )
                                          : Text(
                                              "View More",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF00ACB3),
                                                  fontSize:
                                                      querySize.height * 0.017,
                                                  fontFamily: 'Segoe'),
                                            ),
                                    )),
                              SizedBox(
                                height: querySize.height * 0.08,
                              ),
                            ],
                          );
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          width: querySize.width * 0.5,
          height: querySize.height * 0.055,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(querySize.height * 0.03),
            ),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                showDragHandle: true,
                enableDrag: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(querySize.width * 0.05),
                  ),
                ),
                builder: (context) => FilterScreen(
                  onResetFilters: () {
                    Provider.of<ProductListProvider>(context, listen: false)
                        .productListProviderMethod(
                            eventName: widget.eventName,
                            id: widget.eventId,
                            pageNo: 1.toString(),
                            isPagination: false);
                  },
                ),
              );
            },
            backgroundColor: const Color(0xFF00ACB3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/product_list/filter.png',
                  width: querySize.width * 0.06,
                ),
                SizedBox(
                  width: querySize.height * 0.01,
                ),
                const Text(
                  "Filter",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
// class ProductListingScreen extends StatefulWidget {
//   final int eventId;
//   final String productListingScreenName;
//   final String eventName;
//   // final NewArrivalProvider? newArrivalProvider;
//   const ProductListingScreen(
//       {required this.eventName,
//       required this.productListingScreenName,
//       required this.eventId,
//       //  this.newArrivalProvider,
//       super.key});

//   @override
//   State<ProductListingScreen> createState() => _ProductListingScreenState();
// }

// class _ProductListingScreenState extends State<ProductListingScreen> {}
