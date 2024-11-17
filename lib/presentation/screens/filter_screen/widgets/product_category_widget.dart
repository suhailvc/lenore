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
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    Provider.of<GiftByCategoryProvider>(context, listen: false)
        .giftByCategoryProviderMethod();
  }

  void _onCheckboxChanged(bool? value, int index, int categoryId) {
    setState(() {
      _selectedIndex = value == true ? index : null;
      if (value == true) {
        Provider.of<FilterProvider>(context, listen: false)
            .updateCategoryId(categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer2<GiftByCategoryProvider, FilterProvider>(
        builder: (context, categoryValue, filterValue, child) {
      double itemHeight = querySize.height * 0.05;
      double calculatedHeight =
          itemHeight * categoryValue.cachedResponse!.data!.length;

      if (categoryValue.cachedResponse!.data!.isEmpty) {
        return SizedBox();
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: categoryValue.cachedResponse!.data!.length,
              itemBuilder: (context, index) {
                int categoryId = categoryValue.cachedResponse!.data![index].id!;
                return Row(
                  children: [
                    Transform.scale(
                      scale: querySize.height * 0.0014,
                      child: Checkbox(
                        visualDensity: VisualDensity.compact,
                        value: _selectedIndex == index,
                        activeColor: Colors.black,
                        onChanged: (value) =>
                            _onCheckboxChanged(value, index, categoryId),
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
                      categoryValue.cachedResponse!.data![index].name ?? '',
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
//   @override
//   void initState() {
//     Provider.of<GiftByCategoryProvider>(context, listen: false)
//         .giftByCategoryProviderMethod();
//     super.initState();
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

//   final String title = "Product Type"; // Title defined directly in state
//   int? _selectedIndex; // Track only a single selected checkbox

//   // void _onCheckboxChanged(bool? value, int index, int categoryId) {
//   //   setState(() {
//   //     _selectedIndex = value == true ? index : null;
//   //     if (value == true) {
//   //       Provider.of<FilterProvider>(context, listen: false)
//   //           .updateCategoryId(categoryId);
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer<GiftByCategoryProvider>(
//         builder: (context, categoryValue, child) {
//       print(categoryValue.cachedResponse!.data!.length);
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
//             title,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//               fontFamily: 'Segoe',
//               fontSize: querySize.height * 0.021,
//             ),
//           ),
//           SizedBox(height: querySize.height * 0.01),
//           SizedBox(
//             height: /*querySize.height * 0.4,*/
//                 calculatedHeight < querySize.height * 0.3
//                     ? calculatedHeight
//                     : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: 7,
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
