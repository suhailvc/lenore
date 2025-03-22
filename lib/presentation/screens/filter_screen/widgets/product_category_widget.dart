import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/home_provider/gift_by_category/gift_by_category_provider.dart';
import 'package:lenore/application/provider/sub_category_provider/sub_category_provider.dart';
import 'package:provider/provider.dart';

class ProductCategoryWidget extends StatefulWidget {
  const ProductCategoryWidget({super.key});

  @override
  State<ProductCategoryWidget> createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends State<ProductCategoryWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GiftByCategoryProvider>(context, listen: false)
          .giftByCategoryProviderMethod();
    });
    // Provider.of<GiftByCategoryProvider>(context, listen: false)
    //     .giftByCategoryProviderMethod();
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer2<GiftByCategoryProvider, FilterProvider>(
        builder: (context, categoryProvider, filterProvider, child) {
      double itemHeight = querySize.height * 0.05;
      double calculatedHeight =
          itemHeight * (categoryProvider.cachedResponse?.data?.length ?? 0);

      if (categoryProvider.cachedResponse?.data?.isEmpty ?? true) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Type",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Segoe',
              fontSize: querySize.height * 0.021,
            ),
          ),
          SizedBox(height: querySize.height * 0.01),
          SizedBox(
            height: calculatedHeight < querySize.height * 0.3
                ? calculatedHeight
                : querySize.height * 0.3,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categoryProvider.cachedResponse!.data!.length,
              itemBuilder: (context, index) {
                int categoryId =
                    categoryProvider.cachedResponse!.data![index].id!;
                return Row(
                  children: [
                    Transform.scale(
                      scale: querySize.height * 0.0014,
                      child: Checkbox(
                        visualDensity: VisualDensity.compact,
                        value: filterProvider.categoryId == categoryId,
                        activeColor: Colors.black,
                        onChanged: (value) {
                          if (value == true) {
                            filterProvider.updateCategoryId(categoryId);
                          } else {
                            filterProvider.updateCategoryId(null);
                          }
                        },
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                            width: querySize.width * 0.003,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: querySize.width * 0.03),
                    Text(
                      categoryProvider.cachedResponse!.data![index].name ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Segoe',
                        fontSize: querySize.height * 0.018,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(),
        ],
      );
    });
  }
}
// class ProductCategoryWidget extends StatefulWidget {
//   const ProductCategoryWidget({super.key});

//   @override
//   State<ProductCategoryWidget> createState() => _ProductCategoryWidgetState();
// }

// class _ProductCategoryWidgetState extends State<ProductCategoryWidget> {
//   int? _selectedIndex;

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<GiftByCategoryProvider>(context, listen: false)
//         .giftByCategoryProviderMethod();
//   }

//   void _onCheckboxChanged(bool? value, int index, int categoryId) {
//     setState(() {
//       _selectedIndex = value == true ? index : null;
//       if (value == true) {
//         Provider.of<FilterProvider>(context, listen: false)
//             .updateCategoryId(categoryId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer2<GiftByCategoryProvider, FilterProvider>(
//         builder: (context, categoryValue, filterValue, child) {
//       double itemHeight = querySize.height * 0.05;
//       double calculatedHeight =
//           itemHeight * categoryValue.cachedResponse!.data!.length;

//       if (categoryValue.cachedResponse!.data!.isEmpty) {
//         return SizedBox();
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Product Type",
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Segoe',
//               fontSize: querySize.height * 0.021,
//             ),
//           ),
//           SizedBox(height: querySize.height * 0.01),
//           SizedBox(
//             height: calculatedHeight < querySize.height * 0.3
//                 ? calculatedHeight
//                 : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: categoryValue.cachedResponse!.data!.length,
//               itemBuilder: (context, index) {
//                 int categoryId = categoryValue.cachedResponse!.data![index].id!;
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndex == index,
//                         activeColor: Colors.black,
//                         onChanged: (value) =>
//                             _onCheckboxChanged(value, index, categoryId),
//                         side: MaterialStateBorderSide.resolveWith(
//                           (states) => BorderSide(
//                             width: querySize.width * 0.003,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: querySize.width * 0.03),
//                     Text(
//                       categoryValue.cachedResponse!.data![index].name ?? '',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontFamily: 'Segoe',
//                         fontSize: querySize.height * 0.018,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           const Divider(),
//         ],
//       );
//     });
//   }
// }
