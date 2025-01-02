import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/home_provider/best_seller_provider/best_seller_provider.dart';

import 'package:lenore/presentation/screens/filter_screen/widgets/collection_filter.dart';
import 'package:lenore/presentation/screens/filter_screen/widgets/gift_by_event_filter.dart';
import 'package:lenore/presentation/screens/filter_screen/widgets/gold_purity_filter.dart';
import 'package:lenore/presentation/screens/filter_screen/widgets/product_category_widget.dart';
import 'package:lenore/presentation/screens/filter_screen/widgets/product_type_widget.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  final VoidCallback onResetFilters;
  const FilterScreen({required this.onResetFilters, super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    // Provider.of<GiftByCategoryProvider>(context, listen: false)
    //     .giftByCategoryProviderMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(querySize.width * 0.06),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: querySize.width * 0.04,
                vertical: querySize.height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Segoe',
                          fontSize: querySize.height * 0.022,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Provider.of<FilterProvider>(context, listen: false)
                              .resetFilters();
                          widget.onResetFilters();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Reset All',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Segoe',
                            fontSize: querySize.height * 0.022,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  ProductCategoryWidget(),
                  ProductSubCategory(categoryName: 'gift-by-category', id: 1),
                  GiftByEventFilter(),
                  GoldPurityFilter(),
                  CollectionFilter(),
                  SizedBox(height: querySize.height * 0.03),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: querySize.height * 0.03,
            left: querySize.width * 0.25,
            right: querySize.width * 0.25,
            child: SizedBox(
              width: querySize.width * 0.5,
              height: querySize.height * 0.055,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(querySize.height * 0.03),
                ),
                onPressed: () async {
                  final filterProvider =
                      Provider.of<FilterProvider>(context, listen: false);
                  await filterProvider.fetchFilteredProducts(
                    // token: 'qasxcdes',
                    categoryId: filterProvider.categoryId?.toString(),
                    subcategoryId: filterProvider.selectedSubCategoryIds,
                    eventId: filterProvider.selectedEventIds,
                    collectionId: filterProvider.selectedCollectionIds,
                    gold: filterProvider.selectedGoldPurities,
                  );
                },
                backgroundColor: const Color(0xFF00ACB3),
                child: const Text(
                  "Apply Filter",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class FilterScreen extends StatefulWidget {
//   const FilterScreen({super.key});

//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {
//   @override
//   void initState() {
//     Provider.of<GiftByCategoryProvider>(context, listen: false)
//         .giftByCategoryProviderMethod();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Consumer<GiftByCategoryProvider>(
//           builder: (context, giftByCategoryValue, child) {
//         List<String> options = giftByCategoryValue.cachedResponse?.data
//                 ?.map((dataItem) => dataItem.name ?? 'Unknown')
//                 .toList() ??
//             [];
//         return Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(querySize.width * 0.06),
//               color: Colors.white),
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     left: querySize.width * 0.04,
//                     right: querySize.width * 0.04,
//                     bottom: querySize.height * 0.1,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Filters',
//                             style: TextStyle(
//                               color: textColor,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Segoe',
//                               fontSize: querySize.height * 0.022,
//                             ),
//                           ),
//                           Text(
//                             'Reset All',
//                             style: TextStyle(
//                               color: textColor,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: 'Segoe',
//                               fontSize: querySize.height * 0.022,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(),
//                       ProductCategoryWidget(),
//                       ProductSubCategory(
//                         categoryName: 'gift-by-category',
//                         id: 1,
//                       ),
//                       GiftByEventFilter(),
//                       GoldPurityFilter(),
//                       CollectionFilter(),
//                       SizedBox(
//                         height: querySize.height * 0.03,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Fixed Apply Filter button
//               Positioned(
//                 bottom: querySize.height * 0.03,
//                 left: querySize.width * 0.25,
//                 right: querySize.width * 0.25,
//                 child: SizedBox(
//                   width: querySize.width * 0.5,
//                   height: querySize.height * 0.055,
//                   child: FloatingActionButton(
//                     shape: RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.circular(querySize.height * 0.03),
//                     ),
//                     onPressed: () async {
//                        await Provider.of<FilterProvider>(context)
//                             .fetchFilteredProducts(
//                           token: 'qasxcdes',
//                         categoryId: ,collectionId: ,eventId: ,gold: ,subcategoryId: );
//                     },
//                     backgroundColor: const Color(0xFF00ACB3),
//                     child: const Text(
//                       "Apply Filter",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'ElMessiri',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

// Widget buildFilterSection({
//   required String title,
//   required List<String> options,
//   required List<int> selectedIndices,
//   required Size querySize,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         title,
//         style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//           fontFamily: 'Segoe',
//           fontSize: querySize.height * 0.021,
//         ),
//       ),
//       SizedBox(height: querySize.height * 0.01),
// //       List.generate(options.length, (index)){
// //         child: Row(
// //           children: [
// //             Checkbox(
// //               value: true,
// //               onChanged: (value) {},
// //             ),
// //             Text(title)
// //           ],
// //         );
// // },
//       Column(
//         children: List.generate(options.length, (index) {
//           return Row(
//             children: [
//               Transform.scale(
//                 scale: querySize.height * 0.0014,
//                 child: Checkbox(
//                   visualDensity: VisualDensity.compact,
//                   value: false,
//                   activeColor: textColor,
//                   onChanged: (value) {},
//                   side: WidgetStateBorderSide.resolveWith(
//                     (states) => BorderSide(
//                       width: querySize.width * 0.003,
//                       color: textColor,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: querySize.width * 0.03,
//               ),
//               Text(
//                 options[index],
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Segoe',
//                   fontSize: querySize.height * 0.018,
//                 ),
//               )
//             ],
//           );
//         }),
//       ),
//       // Column(
//       //   children: List.generate(options.length, (index) {
//       //     return CheckboxListTile(
//       //       title: Text(options[index]),
//       //       value: selectedIndices.contains(index),
//       //       onChanged: (bool? value) {},
//       //       activeColor: const Color(0xFF08777B),
//       //     );
//       //   }),
//       // ),
//       // if (title == 'Budget')
//       //   const Align(
//       //     alignment: Alignment.centerRight,
//       //     child: Icon(Icons.expand_more),
//       //   ),
//       const Divider(),
//     ],
//   );
// }
