import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/delivery_fee_provider/delivery_fee_provider.dart';

import 'package:lenore/application/provider/home_provider/collection_provider/collection_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_category/gift_by_category_provider.dart';

import 'package:lenore/application/provider/home_provider/gift_by_event_provider/gift_by_event_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_voucher_provider/gift_by_voucher_provider.dart';
import 'package:lenore/application/provider/home_provider/home_banner_provider/home_banner_provider.dart';
import 'package:lenore/application/provider/home_provider/best_seller_provider/best_seller_provider.dart';
import 'package:lenore/application/provider/new_aarival_provider/new_arrival_provider.dart';
import 'package:lenore/application/provider/wishlist_provider/whishlist_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/best_seller_new_arrival_listing_screen/best_seller_new_arrival_listing_screen.dart';
import 'package:lenore/presentation/screens/collection_screen/collection_screen.dart';
import 'package:lenore/presentation/screens/customise/customise.dart';
import 'package:lenore/presentation/screens/gift_by%20category_screen/gift_by_category_screen.dart';
import 'package:lenore/presentation/screens/gift_by_event_screen/gift_by_event_screen.dart';
import 'package:lenore/presentation/screens/gift_by_voucher_detail_screen.dart/gift_by_voucher_detail_screen.dart';
import 'package:lenore/presentation/screens/gift_by_voucher_screen/gift_by_voucher_screen.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_event_card.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_home_section_title.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_home_top_bar.dart';
import 'package:lenore/presentation/screens/home/widgets/custom_new_arrival_home.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:lenore/presentation/screens/repair_screen/repair_screen.dart';

import 'package:lenore/presentation/screens/sub_category_product_listing_screen/sub_category_product_listing_screen.dart';
import 'package:lenore/presentation/screens/sub_category_screen/sub_category_screen.dart';
import 'package:lenore/presentation/widgets/custom_profile_top_bar.dart';
import 'package:lenore/presentation/widgets/custom_snack_bar.dart';
import 'package:lenore/presentation/widgets/cutom_bottom_bar_top_bar.dart';
import 'package:lenore/presentation/widgets/shimmer_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int activeIndex = 0;
//   int giftActiveIndex = 0;
//   int collectionActiveIndex = 0;
//   Map<int, VideoPlayerController> videoControllers = {};
//   @override
//   void initState() {
//     super.initState();
//     print('hiiiiiiiiiiiiiiiiiiiiiiiiii');

//     //  Fetch data as soon as the screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<GiftByCategoryProvider>(context, listen: false)
//           .giftByCategoryProviderMethod();
//     });
//     Provider.of<DeliveryFeeProvider>(context, listen: false).fetchDeliveryFee();
//     Provider.of<GiftByVoucherProvider>(context, listen: false)
//         .fetchGiftByVoucherItems();
//     Provider.of<GiftByEventProvider>(context, listen: false)
//         .giftByEventProviderMethod();
//     Provider.of<BestSellerProvider>(context, listen: false)
//         .bestSellerProviderMethod(pageNo: '1', eventName: 'best-sellers');
//     Provider.of<NewArrivalProvider>(context, listen: false)
//         .newArrivalProviderMethod(pageNo: '1', eventName: 'new-arrivals');

//     // Provider.of<NewArrivalProvider>(context, listen: false)
//     //     .fetchNewArrivalItems();
//     // Provider.of<CollectionProvider>(context, listen: false)
//     //     .collectionProviderMethod();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<CollectionProvider>(context, listen: false)
//           .collectionProviderMethod();
//     });
//     Provider.of<HomeBannerProvider>(context, listen: false)
//         .fetchHomeBannerItems();
//     _fetchWishlist();
//   }

//   @override
//   void dispose() {
//     // Dispose all video controllers when widget is disposed
//     videoControllers.forEach((_, controller) {
//       controller.dispose();
//     });
//     super.dispose();
//   }

//   Future<VideoPlayerController> initializeVideoController(
//       String videoUrl, int index) async {
//     if (videoControllers.containsKey(index)) {
//       return videoControllers[index]!;
//     }

//     final controller = VideoPlayerController.network(videoUrl);
//     videoControllers[index] = controller;

//     await controller.initialize();
//     controller.setLooping(true);
//     return controller;
//   }

//   Future<void> _fetchWishlist() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final token = await authProvider.getToken();
//     if (token != null) {
//       Provider.of<WishlistProvider>(context, listen: false)
//           .fetchWishlist(token);
//     } else {
//       // Handle case where token is null, e.g., show an error or prompt login
//       print("Token not available");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return RefreshIndicator(
//       onRefresh: () async {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           Provider.of<GiftByCategoryProvider>(context, listen: false)
//               .giftByCategoryProviderMethod();
//         });
//         Provider.of<GiftByVoucherProvider>(context, listen: false)
//             .fetchGiftByVoucherItems();
//         Provider.of<GiftByEventProvider>(context, listen: false)
//             .giftByEventProviderMethod();
//         Provider.of<BestSellerProvider>(context, listen: false)
//             .bestSellerProviderMethod(pageNo: '1', eventName: 'best-sellers');
//         Provider.of<NewArrivalProvider>(context, listen: false)
//             .newArrivalProviderMethod(pageNo: '1', eventName: 'new-arrivals');
//         // Provider.of<DeliveryFeeProvider>(context, listen: false)
//         //     .fetchDeliveryFee();

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           Provider.of<CollectionProvider>(context, listen: false)
//               .collectionProviderMethod();
//         });
//         Provider.of<HomeBannerProvider>(context, listen: false)
//             .fetchHomeBannerItems();
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//             child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//               padding: EdgeInsets.all(querySize.height * 0.02),
//               child: Column(
//                 children: [
//                   customHomeTopBar(querySize, context),
//                   customSizedBox(querySize),
//                   // customEventMessageField(querySize),
//                   Consumer<HomeBannerProvider>(
//                     builder: (context, homeBannerProvidervalue, child) {
//                       if (homeBannerProvidervalue.isLoading) {
//                         // Show loading spinner while fetching data
//                         return ShimmerLoading(
//                             containerHeight: querySize.height * 0.04);
//                       } else if (homeBannerProvidervalue
//                                   .giftByVoucherItems.data ==
//                               null ||
//                           homeBannerProvidervalue
//                               .giftByVoucherItems.data!.isEmpty) {
//                         return SizedBox();
//                       } else {
//                         return Column(
//                           children: [
//                             CarouselSlider.builder(
//                               itemCount: homeBannerProvidervalue
//                                   .giftByVoucherItems.data!.length,
//                               itemBuilder: (context, index, realIndex) {
//                                 final item = homeBannerProvidervalue
//                                     .giftByVoucherItems.data![index];
//                                 final hasVideo = item.video != null &&
//                                     item.video!.isNotEmpty;

//                                 return Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: querySize.width * 0.02),
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       String? screen = item.screen;

//                                       if (screen == "best-seller" ||
//                                           screen == "new-arrival") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 BestSellerNewArrivalListingScreen(
//                                               eventName: screen!,
//                                               productListingScreenName:
//                                                   item.screenName ?? '',
//                                             ),
//                                           ),
//                                         );
//                                       } else if (screen == "gift-by-event" ||
//                                           screen == "sub-category" ||
//                                           screen == "collections") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 SubCategoryProductListingScreen(
//                                               eventId:
//                                                   int.parse(item.screenId!),
//                                               eventName: item.screen!,
//                                               productListingScreenName:
//                                                   item.screenName ?? '',
//                                             ),
//                                           ),
//                                         );
//                                       } else if (screen == "products") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ProductDetailScreen(
//                                               productId:
//                                                   int.parse(item.screenId!),
//                                             ),
//                                           ),
//                                         );
//                                       } else if (screen == "customisation") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 CustomisationScreen(
//                                               widgetName: customProfileTopBar(
//                                                   querySize,
//                                                   context,
//                                                   "Customize"),
//                                             ),
//                                           ),
//                                         );
//                                       } else if (screen == "repair") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => RepairScreen(
//                                               widgetName: customProfileTopBar(
//                                                   querySize, context, "Repair"),
//                                             ),
//                                           ),
//                                         );
//                                       } else if (screen == "gift-voucher") {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 GiftByVoucherScreen(
//                                               giftByVoucherProvider: Provider
//                                                   .of<GiftByVoucherProvider>(
//                                                       context,
//                                                       listen: false),
//                                             ),
//                                           ),
//                                         );
//                                       } else {
//                                         // Handle unknown or null screen values
//                                         debugPrint("Unknown screen: $screen");
//                                       }
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(
//                                           querySize.height * 0.02),
//                                       child: Container(
//                                         width: double.infinity,
//                                         height: querySize.height * 0.24,
//                                         child: Stack(
//                                           fit: StackFit.expand,
//                                           children: [
//                                             // Content: either video or image
//                                             hasVideo
//                                                 ? FutureBuilder<
//                                                     VideoPlayerController>(
//                                                     future:
//                                                         initializeVideoController(
//                                                             item.video!, index),
//                                                     builder:
//                                                         (context, snapshot) {
//                                                       if (snapshot.connectionState ==
//                                                               ConnectionState
//                                                                   .done &&
//                                                           snapshot.hasData) {
//                                                         // Auto-play when this item becomes active
//                                                         if (activeIndex ==
//                                                                 index &&
//                                                             !snapshot
//                                                                 .data!
//                                                                 .value
//                                                                 .isPlaying) {
//                                                           snapshot.data!.play();
//                                                         } else if (activeIndex !=
//                                                                 index &&
//                                                             snapshot.data!.value
//                                                                 .isPlaying) {
//                                                           snapshot.data!
//                                                               .pause();
//                                                         }

//                                                         return AspectRatio(
//                                                           aspectRatio: snapshot
//                                                               .data!
//                                                               .value
//                                                               .aspectRatio,
//                                                           child: VideoPlayer(
//                                                               snapshot.data!),
//                                                         );
//                                                       } else {
//                                                         return Center(
//                                                             child:
//                                                                 CircularProgressIndicator());
//                                                       }
//                                                     },
//                                                   )
//                                                 : Container(
//                                                     decoration: BoxDecoration(
//                                                       image: DecorationImage(
//                                                         image: NetworkImage(
//                                                             item.image!),
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                   ),

//                                             // Text overlay
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(16.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(
//                                                       height: querySize.height *
//                                                           0.05),
//                                                   Row(
//                                                     children: [
//                                                       SizedBox(
//                                                           width:
//                                                               querySize.width *
//                                                                   0.02),
//                                                       Flexible(
//                                                         child: Text(
//                                                           item.titleOne ?? "",
//                                                           style: TextStyle(
//                                                             fontFamily:
//                                                                 'ElMessiri',
//                                                             color: Colors.white,
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             shadows: [
//                                                               Shadow(
//                                                                 blurRadius: 5.0,
//                                                                 color: Colors
//                                                                     .black
//                                                                     .withOpacity(
//                                                                         0.7),
//                                                                 offset: Offset(
//                                                                     2.0, 2.0),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 3,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       SizedBox(
//                                                           width:
//                                                               querySize.width *
//                                                                   0.02),
//                                                       Flexible(
//                                                         child: Text(
//                                                           item.description ??
//                                                               '',
//                                                           style: TextStyle(
//                                                             fontFamily:
//                                                                 'ElMessiri',
//                                                             color: Colors.white,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             shadows: [
//                                                               Shadow(
//                                                                 blurRadius: 5.0,
//                                                                 color: Colors
//                                                                     .black
//                                                                     .withOpacity(
//                                                                         0.7),
//                                                                 offset: Offset(
//                                                                     2.0, 2.0),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           maxLines: 3,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               options: CarouselOptions(
//                                 onPageChanged: (index, reason) {
//                                   setState(() {
//                                     activeIndex = index;
//                                   });
//                                 },
//                                 viewportFraction: 1,
//                                 height: querySize.height * 0.24,
//                                 autoPlay: true,
//                                 autoPlayInterval: const Duration(seconds: 5),
//                               ),
//                             ),
//                             SizedBox(height: querySize.height * 0.01),
//                             AnimatedSmoothIndicator(
//                               activeIndex: activeIndex,
//                               count: homeBannerProvidervalue
//                                   .giftByVoucherItems.data!.length,
//                               effect: SlideEffect(
//                                 dotHeight: querySize.height * 0.008,
//                                 dotWidth: querySize.width * 0.018,
//                                 activeDotColor: appColor,
//                               ),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                   customSizedBox(querySize),
//                   Consumer<GiftByEventProvider>(
//                     builder: (context, eventProvider, child) {
//                       if (eventProvider.isLoading) {
//                         // Show loading spinner while fetching data
//                         return ShimmerLoading(
//                             containerHeight: querySize.height * 0.04);
//                       } else if (eventProvider.cachedResponse == null) {
//                         // Handle case where data fetching failed
//                         return Center(
//                             child: Text('Failed to load event categories'));
//                       } else {
//                         // Display the event data when available
//                         return giftByEventSection(
//                             querySize, context, eventProvider);
//                       }
//                     },
//                   ),
//                   // giftByEventSection(querySize, context),
//                   customSizedBox(querySize),
//                   giftByCategorySection(querySize, context),
//                   customHeightThree(querySize),
//                   Consumer<BestSellerProvider>(
//                     builder: (context, bestSeller, child) {
//                       if (bestSeller.isLoading) {
//                         // Show loading spinner while fetching data
//                         return ShimmerLoading(
//                             containerHeight: querySize.height * 0.04);
//                       } else {
//                         return bestSellerNewArrivalSection(querySize,
//                             "Best Seller", "All Best Sellers", context,
//                             bestSellerProvider: bestSeller);
//                       }
//                     },
//                   ),

//                   customSizedBox(querySize),
//                   Consumer<GiftByVoucherProvider>(
//                     builder: (context, giftByVoucherProviderValue, child) {
//                       if (giftByVoucherProviderValue.isLoading) {
//                         // Show loading spinner while fetching data
//                         return ShimmerLoading(
//                             containerHeight: querySize.height * 0.04);
//                       } else if (giftByVoucherProviderValue
//                               .giftByVoucherItems ==
//                           null) {
//                         return SizedBox();
//                       } else {
//                         // Display the event data when available
//                         return giftByVoucherSection(
//                             querySize, context, giftByVoucherProviderValue);
//                       }
//                     },
//                   ),

//                   customSizedBox(querySize),
//                   Consumer<NewArrivalProvider>(
//                     builder: (context, newArrival, child) {
//                       if (newArrival.isLoading) {
//                         return ShimmerLoading(
//                             containerHeight: querySize.height * 0.04);
//                       } else {
//                         return customHomeNewArrivalSection(querySize,
//                             "New Arrival", "All New Arrivals", context,
//                             newArrivalProvider: newArrival);
//                       }
//                     },
//                   ),
//                   // bestSellerNewArrivalSection(
//                   //     querySize, "New Arrivals", "All New Arrivals", context),
//                   customSizedBox(querySize),
//                   Consumer<CollectionProvider>(
//                     builder: (context, collectionValue, child) {
//                       print(
//                           'cccccccccccccccccooooooooooooooooooooollllllllllllllll');
//                       if (collectionValue.isLoading) {
//                         return ShimmerLoading(
//                             containerHeight: querySize.height * 0.04);
//                       }
//                       if (collectionValue.collectionItems.data == null ||
//                           collectionValue.collectionItems.data!.isEmpty) {
//                         return SizedBox();
//                       } else {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             homeSectionTitle(
//                                 querySize,
//                                 'Collections',
//                                 context,
//                                 CollectionScreen(
//                                   collections: collectionValue,
//                                 )),
//                             customSizedBox(querySize),
//                             Column(
//                               children: [
//                                 CarouselSlider.builder(
//                                     itemCount: collectionValue
//                                                 .collectionItems.data!.length >
//                                             5
//                                         ? 5
//                                         : collectionValue
//                                             .collectionItems.data!.length,
//                                     itemBuilder: (context, index, realIndex) {
//                                       return GestureDetector(
//                                           onTap: () {
//                                             // if (index == 0) {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         SubCategoryProductListingScreen(
//                                                             eventId: collectionValue
//                                                                 .collectionItems
//                                                                 .data![index]
//                                                                 .id!,
//                                                             eventName:
//                                                                 'collections',
//                                                             productListingScreenName:
//                                                                 collectionValue
//                                                                     .collectionItems
//                                                                     .data![
//                                                                         index]
//                                                                     .name!)));
//                                           },
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 margin: EdgeInsets.only(
//                                                     right: querySize.width *
//                                                         0.025),
//                                                 width: 127.16 /
//                                                     375.0 *
//                                                     querySize.width,
//                                                 height: 108.7 /
//                                                     812.0 *
//                                                     querySize.height,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           12.0),
//                                                   image: DecorationImage(
//                                                     image: NetworkImage(
//                                                         collectionValue
//                                                             .collectionItems
//                                                             .data![index]
//                                                             .logo!),
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 collectionValue.collectionItems
//                                                     .data![index].name!,
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                   fontSize: 13.69 /
//                                                       375.0 *
//                                                       querySize.width,
//                                                   fontWeight: FontWeight.w500,
//                                                   fontFamily: 'Segoe',
//                                                   color:
//                                                       const Color(0xFF00ACB3),
//                                                   decoration:
//                                                       TextDecoration.underline,
//                                                   decorationColor:
//                                                       const Color(0xFF00ACB3),
//                                                 ),
//                                               ),
//                                             ],
//                                           ));
//                                     },
//                                     options: CarouselOptions(
//                                         onPageChanged: (index, reason) {
//                                           setState(() {
//                                             collectionActiveIndex = index;
//                                           });
//                                         },
//                                         viewportFraction:
//                                             querySize.width * 0.00087,
//                                         // viewportFraction: 1,
//                                         height: querySize.height * 0.18,
//                                         autoPlay: true,
//                                         autoPlayInterval:
//                                             const Duration(seconds: 4))),
//                                 AnimatedSmoothIndicator(
//                                   activeIndex: collectionActiveIndex,
//                                   count: 5,
//                                   effect: SlideEffect(
//                                       dotHeight: querySize.height * 0.008,
//                                       dotWidth: querySize.width * 0.018,
//                                       activeDotColor: appColor),
//                                 )
//                               ],
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   )
//                 ],
//               )),
//         )),
//       ),
//     );
//   }

//   Column giftByVoucherSection(Size querySize, BuildContext context,
//       GiftByVoucherProvider? giftByVoucherProvider) {
//     return Column(
//       children: [
//         homeSectionTitle(
//           querySize,
//           "Gift by Voucher",
//           context,
//           GiftByVoucherScreen(
//             giftByVoucherProvider: giftByVoucherProvider!,
//           ),
//         ),
//         customSizedBox(querySize),
//         SizedBox(
//           height: 0.15 * querySize.height,
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => GiftByVoucherDetailScreen(
//                           id: giftByVoucherProvider
//                               .giftByVoucherItems!.data![index].id!,
//                         ),
//                       ));
//                 },
//                 child: Container(
//                   width: querySize.width * 0.75,
//                   height: querySize.height * 0.13,
//                   color: Colors.white,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: querySize.height * 0.0286,
//                         top: querySize.height * 0.00,
//                         child: Container(
//                           width: querySize.width * 0.65,
//                           height: querySize.height * 0.13,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 0,
//                                 blurRadius: 2,
//                                 offset: const Offset(2, 3),
//                               ),
//                             ],
//                             border: Border.all(
//                               color: const Color(0xFFF3BC8B),
//                               width: querySize.width * 0.008,
//                             ),
//                             color: const Color(0xFFFBE8DC),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                           left: querySize.height * 0,
//                           top: querySize.height * 0.028,
//                           child: Container(
//                             width: querySize.height * 0.08,
//                             height: querySize.height * 0.08,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: const Color(0xFFF3BC8B),
//                                 width: querySize.width * 0.008,
//                               ),
//                               color: Colors.white,
//                               shape: BoxShape.circle,
//                             ),
//                           )),
//                       Positioned(
//                           left: querySize.height * 0.0,
//                           top: querySize.height * 0.00,
//                           child: Container(
//                             color: Colors.white,
//                             width: querySize.width * 0.06,
//                             height: querySize.height * 0.15,
//                           )),
//                       Positioned(
//                         left: querySize.width * 0.29,
//                         top: querySize.width * 0.07,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "${giftByVoucherProvider.giftByVoucherItems!.data![index].amount!} QR",
//                               style: TextStyle(
//                                   fontSize: querySize.height * 0.035,
//                                   fontFamily: 'Segoe',
//                                   color: const Color(0xFF00ACB3)),
//                             ),
//                             Text(
//                               giftByVoucherProvider
//                                   .giftByVoucherItems!.data![index].name!,
//                               style: TextStyle(
//                                   fontSize: querySize.height * 0.015,
//                                   fontWeight: FontWeight.w600,
//                                   fontFamily: 'Segoe',
//                                   color: const Color(0xFF00ACB3)),
//                             )
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                           left: querySize.width * 0.23,
//                           top: querySize.width * 0.01,
//                           child: DottedLine(
//                             direction: Axis.vertical,
//                             alignment: WrapAlignment.center,
//                             lineLength: querySize.height * 0.12,
//                             lineThickness: querySize.width * 0.004,
//                             dashLength: 4.0,
//                             dashColor: const Color(0xFFFBE8DC),
//                             dashRadius: 0.0,
//                             dashGapLength: 4.0,
//                             dashGapColor: Colors.black,
//                             dashGapRadius: 0.0,
//                           ))
//                     ],
//                   ),
//                 ),
//               );
//             },
//             itemCount:
//                 giftByVoucherProvider!.giftByVoucherItems!.data!.length > 4
//                     ? 4
//                     : giftByVoucherProvider.giftByVoucherItems!.data!.length,
//           ),
//         )
//       ],
//     );
//   }

//   bestSellerNewArrivalSection(
//       Size querySize, sectionTitle, String buttonName, BuildContext context,
//       {BestSellerProvider? bestSellerProvider}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         homeSectionTitle(
//           querySize,
//           sectionTitle,
//           context,
//           BestSellerNewArrivalListingScreen(
//             eventName: 'best-sellers',
//             productListingScreenName: 'Best Sellers',
//           ),
//         ),
//         customSizedBox(querySize),
//         GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: bestSellerProvider!.productListItems.data!.length > 4
//               ? 4
//               : bestSellerProvider.productListItems.data!.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: querySize.height * 0.017,
//             childAspectRatio: 0.78,
//           ),
//           itemBuilder: (context, index) {
//             final product = bestSellerProvider.productListItems.data![index];
//             final isInWishlist =
//                 Provider.of<WishlistProvider>(context, listen: false)
//                     .isProductInWishlist(product.id!);

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ProductDetailScreen(
//                           productId: product.id!,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Stack(
//                     children: [
//                       Container(
//                         height: querySize.height * 0.2,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.04),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               offset: const Offset(0, 7),
//                               blurRadius: querySize.width * 0.008,
//                               spreadRadius: -2,
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius:
//                               BorderRadius.circular(querySize.width * 0.04),
//                           child: Image.network(
//                             product.thumbImage!,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: querySize.height * 0.008,
//                         right: querySize.height * 0.012,
//                         child: Consumer<WishlistProvider>(
//                           builder: (context, wishlistProvider, child) {
//                             final isInWishlist = wishlistProvider
//                                 .isProductInWishlist(product.id!);

//                             return GestureDetector(
//                               onTap: () async {
//                                 final authProvider = Provider.of<AuthProvider>(
//                                     context,
//                                     listen: false);
//                                 final token = await authProvider.getToken();

//                                 if (token == null) {
//                                   customSnackBar(context, 'Please SignIn');
//                                   return;
//                                 }

//                                 // Toggle wishlist status for this specific product
//                                 await wishlistProvider.toggleWishlist(
//                                     token, product.id!);
//                               },
//                               child: CircleAvatar(
//                                 radius: querySize.width * 0.033,
//                                 backgroundColor: Colors.white,
//                                 child: isInWishlist
//                                     ? Image.asset(
//                                         'assets/images/love (1).png',
//                                         width: querySize.width * 0.048,
//                                         height: querySize.height * 0.018,
//                                       )
//                                     : Image.asset(
//                                         'assets/images/home/favourite.png',
//                                         width: querySize.width * 0.075,
//                                         height: querySize.height * 0.037,
//                                       ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: querySize.height * 0.01),
//                 Row(
//                   children: [
//                     Text(
//                       "QAR  ",
//                       style: TextStyle(
//                         fontFamily: 'ElMessiri',
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: querySize.width * 0.029,
//                       ),
//                     ),
//                     Text(
//                       product.price.toString(),
//                       style: TextStyle(
//                         color: const Color(0xFF000000),
//                         fontSize: querySize.width * 0.035,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   product.name!,
//                   style: TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Segoe',
//                     fontSize: querySize.width * 0.027,
//                     color: const Color(0xFF525252),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   giftByCategorySection(Size querySize, BuildContext context) {
//     final giftProvider = Provider.of<GiftByCategoryProvider>(context);
//     return Column(
//       children: [
//         if (giftProvider.isLoading)
//           // Show loading indicator while fetching
//           ShimmerLoading(containerHeight: querySize.height * 0.36)
//         else if (giftProvider.cachedResponse == null)
//           // Handle case where data is null (failed to fetch)
//           Center(child: Text('Failed to load categories'))
//         else
//           // Display fetched data
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Gift by category',
//                     style: TextStyle(
//                         color: const Color(0xFF008186),
//                         fontSize: querySize.width * 0.05,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'ElMessiri'),
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                     onTap: () {
//                       PersistentNavBarNavigator.pushNewScreen(
//                         context,
//                         screen: GiftByCategoryScreen(
//                           widget: customBottomBarTopBar(querySize, context),
//                         ),
//                         withNavBar: true, // OPTIONAL VALUE. True by default.
//                         pageTransitionAnimation:
//                             PageTransitionAnimation.cupertino,
//                       );
//                     },
//                     child: Text(
//                       "View More",
//                       style: TextStyle(
//                           color: const Color(0xFF00ACB3),
//                           fontSize: querySize.width * 0.033,
//                           fontWeight: FontWeight.w600,
//                           decoration: TextDecoration.underline,
//                           decorationColor: const Color(0xFF00ACB3),
//                           fontFamily: 'Segoe'),
//                     ),
//                   ),
//                 ],
//               ),
//               customSizedBox(querySize),
//               CarouselSlider.builder(
//                   itemCount: giftProvider.cachedResponse!.data!.length > 4
//                       ? 4
//                       : giftProvider.cachedResponse!.data!.length,
//                   itemBuilder: (context, index, realIndex) {
//                     final category = giftProvider.cachedResponse!.data![index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SubCategoryScreen(
//                               categoryName: 'gift-by-category',
//                               id: category.id!,
//                               screenName: category.name!,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(right: querySize.width * 0.025),
//                         width: 255.16 / 375.0 * querySize.width,
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               BorderRadius.circular(querySize.height * 0.01),
//                           image: DecorationImage(
//                             image: NetworkImage(category.image!),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         child: Stack(
//                           children: [
//                             // Add a gradient overlay to darken the bottom of the image
//                             Positioned.fill(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(
//                                       querySize.height * 0.01),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: [
//                                       Colors.transparent,
//                                       Colors.black.withOpacity(
//                                           0.6), // Darken bottom part
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Text displayed on top of the image with shadow
//                             Positioned(
//                               bottom: querySize.height *
//                                   0.004, // Adjust position of the text
//                               left: 0,
//                               right: 0,
//                               child: Text(
//                                 category.name ?? 'No Name',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 13.69 / 375.0 * querySize.width,
//                                   fontFamily: 'NunitoSans',
//                                   color: Colors.white,
//                                   shadows: [
//                                     Shadow(
//                                       offset: Offset(0, 1),
//                                       blurRadius: 4,
//                                       color: Colors.black
//                                           .withOpacity(0.7), // Text shadow
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   options: CarouselOptions(
//                       viewportFraction: 0.45,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           giftActiveIndex = index;
//                         });
//                       },
//                       height: querySize.height * 0.24,
//                       autoPlay: true,
//                       autoPlayInterval: const Duration(seconds: 4))),
//               SizedBox(
//                 height: querySize.height * 0.01,
//               ),
//               AnimatedSmoothIndicator(
//                 activeIndex: giftActiveIndex,
//                 count: giftProvider.cachedResponse!.data!.length > 4
//                     ? 4
//                     : giftProvider.cachedResponse!.data!.length,
//                 effect: SlideEffect(
//                     dotHeight: querySize.height * 0.008,
//                     dotWidth: querySize.width * 0.018,
//                     activeDotColor: appColor),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   Column giftByEventSection(
//       Size querySize, BuildContext context, GiftByEventProvider eventProvider) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(
//               'Gift by event',
//               style: TextStyle(
//                 color: const Color(0xFF008186),
//                 fontSize: querySize.width * 0.05,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'ElMessiri',
//               ),
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         GiftByEventScreen(eventProvider: eventProvider),
//                   ),
//                 );
//               },
//               child: Text(
//                 "View More",
//                 style: TextStyle(
//                   color: appColor,
//                   fontSize: querySize.width * 0.033,
//                   fontWeight: FontWeight.w600,
//                   decoration: TextDecoration.underline,
//                   decorationColor: const Color(0xFF00ACB3),
//                   fontFamily: 'Segoe',
//                 ),
//               ),
//             ),
//           ],
//         ),
//         customSizedBox(querySize),
//         GridView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4, // Number of columns
//             crossAxisSpacing: 1.0,
//             mainAxisSpacing: 16.0,
//             childAspectRatio: 1.1,
//           ),
//           itemCount: eventProvider.cachedResponse!.data!.length > 8
//               ? 8
//               : eventProvider.cachedResponse!.data!
//                   .length, // Show only 8 items or less if data has fewer items
//           itemBuilder: (context, index) {
//             final event = eventProvider.cachedResponse!.data![index];
//             return buildEventCard(
//                 event.image ?? '',
//                 event.eventCategory ?? 'No Name',
//                 querySize,
//                 context,
//                 event.id!);
//           },
//         ),
//         customHeightThree(querySize),
//         Divider(
//           color: const Color(0xFFFFD99D),
//           endIndent: querySize.width * 0.09,
//           indent: querySize.width * 0.09,
//         ),
//         customSizedBox(querySize),
//       ],
//     );
//   }
// }
