import 'package:flutter/material.dart';
import 'package:lenore/application/provider/search_provider/search_provider.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:lenore/application/provider/search_provider/search_provider.dart';
import 'package:lenore/presentation/screens/product_detail_screen/product_detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/images/back_blue_icon.png',
                      height: querySize.height * 0.035,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: querySize.height * 0.01),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      height: querySize.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(querySize.width * 0.1),
                        border: Border.all(
                          color: const Color(0x38F3FFFF),
                          width: 1.1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: const Color(0xFF00ACB3)),
                          SizedBox(width: querySize.width * 0.03),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              onChanged: (value) {
                                Provider.of<SearchProvider>(context,
                                        listen: false)
                                    .fetchSearchResults(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontWeight: FontWeight.w600,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
                  if (searchProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (searchProvider.searchList.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: searchProvider.searchList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: querySize.width * 0.02,
                        mainAxisSpacing: querySize.height * 0.02,
                        childAspectRatio: 0.8,
                      ),
                      itemBuilder: (context, index) {
                        final product = searchProvider.searchList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(
                                  productId: product.id,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: querySize.height * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(product.thumbImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "QAR ${product.price}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                product.name,
                                style:
                                    const TextStyle(color: Color(0xFF525252)),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     // Request focus on the search field when the screen is displayed
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(_focusNode);
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       // PersistentNavBarNavigator.pushNewScreen(
//                       //   context,
//                       //   screen: PersistantBottomNavBarScreen(),
//                       //   withNavBar: false, // OPTIONAL VALUE. True by default.
//                       //   pageTransitionAnimation:
//                       //       PageTransitionAnimation.cupertino,
//                       // );
//                     },
//                     child: Image.asset(
//                       'assets/images/back_blue_icon.png',
//                       height: querySize.height * 0.035,
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                           horizontal: querySize.height * 0.01),
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       height: querySize.height * 0.05,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius:
//                             BorderRadius.circular(querySize.width * 0.1),
//                         border: Border.all(
//                           color: const Color(0x38F3FFFF),
//                           width: 1.1,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 1,
//                             blurRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Icon(
//                               Icons.search,
//                               color: const Color(0xFF00ACB3),
//                               size: querySize.height * 0.034,
//                             ),
//                           ),
//                           SizedBox(width: querySize.width * 0.03),
//                           Expanded(
//                             child: TextField(
//                               controller: _searchController,
//                               focusNode: _focusNode,
//                               onChanged: (value) {
//                                 Provider.of<SearchProvider>(context,
//                                         listen: false)
//                                     .fetchSearchResults(_searchController.text);
//                               },
//                               decoration: InputDecoration(
//                                 hintText: 'Search',
//                                 hintStyle: TextStyle(
//                                     color: Color(0xFF7A7A7A),
//                                     fontWeight: FontWeight.w600),
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Consumer<SearchProvider>(
//                 builder: (context, searchProvider, child) {
//                   if (searchProvider.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (searchProvider.searchList.isEmpty) {
//                     return const Center(child: Text('No products found'));
//                   }
//                   return Expanded(
//                     child: GridView.builder(
//                       itemCount: searchProvider.searchList.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: querySize.width * 0.02,
//                         mainAxisSpacing: querySize.height * 0.02,
//                         childAspectRatio: 0.8,
//                       ),
//                       itemBuilder: (context, index) {
//                         final product = searchProvider.searchList[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailScreen(
//                                   productId: product.id,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 height: querySize.height * 0.2,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[200],
//                                   borderRadius: BorderRadius.circular(10),
//                                   image: DecorationImage(
//                                     image: NetworkImage(product.thumbImage),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 "QAR ${product.price}",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 product.name,
//                                 style:
//                                     const TextStyle(color: Color(0xFF525252)),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
