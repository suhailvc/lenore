// import 'package:flutter/material.dart';
// import 'package:lenore/application/provider/product_listing_provider/product_listing_provider.dart';
// import 'package:provider/provider.dart';

// class HomeScreen1 extends StatefulWidget {
//   const HomeScreen1({super.key});

//   @override
//   State<HomeScreen1> createState() => _HomeScreen1State();
// }

// class _HomeScreen1State extends State<HomeScreen1> {
//   @override
//   void initState() {
//     Provider.of<ProductListingProvider>(context, listen: false)
//         .productListProviderMethod(pageNo: '1', eventName: 'new-arrivals');
//     Provider.of<ProductListingProvider>(context, listen: false)
//         .productListProviderMethod(pageNo: '1', eventName: 'best-sellers');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Column(
//         children: [
//           Consumer<ProductListingProvider>(
//             builder: (context, newArrival, child) {
//               if (newArrival.isLoading) {
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 return customHomeNewArrivalSection(
//                     querySize, "New Arrival", "All New Arrivals", context,
//                     newArrivalProvider: newArrival);
//               }
//             },
//           ),
//           Consumer<ProductListingProvider>(
//             builder: (context, bestSeller, child) {
//               if (bestSeller.isLoading) {
//                 // Show loading spinner while fetching data
//                 return Center(child: CircularProgressIndicator());
//               } else {
//                 return bestSellerSection(
//                     querySize, "Best Seller", "All Best Sellers", context,
//                     bestSellerProvider: bestSeller);
//               }
//             },
//           ),
//         ],
//       )),
//     );
//   }
// }

// customHomeNewArrivalSection(
//     Size querySize, sectionTitle, String buttonName, BuildContext context,
//     {ProductListingProvider? newArrivalProvider}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       homeSectionTitle(
//           querySize,
//           sectionTitle,
//           context,
//           BestSellerNewArrivalListingScreen(
//             eventName: 'new-arrivals',
//             productListingScreenName: 'New Arrivals',
//           )),
//       customSizedBox(querySize),
//       GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: newArrivalProvider!.productListItems.data!.length > 4
//             ? 4
//             : newArrivalProvider.productListItems.data!.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: querySize.height * 0.017,
//           //mainAxisSpacing: querySize.height * 001,
//           childAspectRatio: 0.78,
//         ),
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ProductDetailScreen(),
//                         ));
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
//                             newArrivalProvider
//                                 .productListItems.data![index].thumbImage!,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                       ),

//                       // Favorite icon positioned in the top right corner
//                       Positioned(
//                         top: querySize.height * 0.008,
//                         right: querySize.height * 0.012,
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: CircleAvatar(
//                             radius: querySize.width * 0.033,
//                             backgroundColor: Colors.white,
//                             child: Image.asset(
//                               'assets/images/home/favourite.png',
//                               width: querySize.width * 0.075,
//                               height: querySize.height * 0.035,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//               SizedBox(height: querySize.height * 0.01),
//               Row(
//                 children: [
//                   Text(
//                     "QAR",
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.029,
//                     ),
//                   ),
//                   Text(
//                     ' 99',
//                     style: TextStyle(
//                       color: const Color(0xFF000000),
//                       fontSize: querySize.width * 0.035,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Text(
//                 newArrivalProvider.productListItems.data![index].name!,
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Segoe',
//                   fontSize: querySize.width * 0.027,
//                   color: const Color(0xFF525252),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     ],
//   );
// }

// bestSellerSection(
//     Size querySize, sectionTitle, String buttonName, BuildContext context,
//     {ProductListingProvider? bestSellerProvider}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       homeSectionTitle(
//           querySize,
//           sectionTitle,
//           context,
//           BestSellerNewArrivalListingScreen(
//             eventName: 'best-sellers',
//             productListingScreenName: 'Best Sellers',
//           )),
//       customSizedBox(querySize),
//       GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: bestSellerProvider!.productListItems.data!.length > 4
//             ? 4
//             : bestSellerProvider.productListItems.data!.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: querySize.height * 0.017,
//           //mainAxisSpacing: querySize.height * 001,
//           childAspectRatio: 0.78,
//         ),
//         itemBuilder: (context, index) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ProductDetailScreen(),
//                         ));
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
//                             bestSellerProvider
//                                 .productListItems.data![index].thumbImage!,

//                             fit: BoxFit
//                                 .cover, // Ensure the image covers the entire container
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         ),
//                       ),

//                       // Favorite icon positioned in the top right corner
//                       Positioned(
//                         top: querySize.height * 0.008,
//                         right: querySize.height * 0.012,
//                         child: GestureDetector(
//                           onTap: () {},
//                           child: CircleAvatar(
//                             radius: querySize.width * 0.033,
//                             backgroundColor: Colors.white,
//                             child: Image.asset(
//                               'assets/images/home/favourite.png',
//                               width: querySize.width * 0.075,
//                               height: querySize.height * 0.035,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//               SizedBox(height: querySize.height * 0.01),
//               Row(
//                 children: [
//                   Text(
//                     "QAR",
//                     style: TextStyle(
//                       fontFamily: 'ElMessiri',
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                       fontSize: querySize.width * 0.029,
//                     ),
//                   ),
//                   Text(
//                     '99',
//                     style: TextStyle(
//                       color: const Color(0xFF000000),
//                       fontSize: querySize.width * 0.035,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               Text(
//                 bestSellerProvider.productListItems.data![index].name!,
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Segoe',
//                   fontSize: querySize.width * 0.027,
//                   color: const Color(0xFF525252),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     ],
//   );
// }
