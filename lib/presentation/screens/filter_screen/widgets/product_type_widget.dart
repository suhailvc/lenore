import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/sub_category_provider/sub_category_provider.dart';
import 'package:provider/provider.dart';

class ProductSubCategory extends StatefulWidget {
  final String? categoryName;
  final int? id;

  const ProductSubCategory({this.categoryName, this.id, Key? key})
      : super(key: key);

  @override
  _ProductSubCategoryState createState() => _ProductSubCategoryState();
}

class _ProductSubCategoryState extends State<ProductSubCategory> {
  int? _previousCategoryId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedCategoryId = Provider.of<FilterProvider>(context).categoryId;

    if (selectedCategoryId != null &&
        selectedCategoryId != _previousCategoryId) {
      if (widget.categoryName != null && selectedCategoryId != null) {
        Provider.of<SubCategoryProvider>(context, listen: false)
            .fetchSubCategoriesItems(
          categoryName: widget.categoryName!,
          id: selectedCategoryId.toString(),
        );
      }
      _previousCategoryId = selectedCategoryId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer2<SubCategoryProvider, FilterProvider>(
      builder: (context, subCategoryProvider, filterProvider, child) {
        if (subCategoryProvider.subCategoryItems == null ||
            subCategoryProvider.subCategoryItems!.data == null ||
            subCategoryProvider.subCategoryItems!.data!.isEmpty) {
          return const SizedBox();
        }

        double itemHeight = querySize.height * 0.05;
        double calculatedHeight =
            itemHeight * subCategoryProvider.subCategoryItems!.data!.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Sub Category",
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
                itemCount: subCategoryProvider.subCategoryItems!.data!.length,
                itemBuilder: (context, index) {
                  int subCategoryId =
                      subCategoryProvider.subCategoryItems!.data![index].id ??
                          0;

                  return Row(
                    children: [
                      Transform.scale(
                        scale: querySize.height * 0.0014,
                        child: Checkbox(
                          visualDensity: VisualDensity.compact,
                          value: filterProvider.selectedSubCategoryIds
                              .contains(subCategoryId),
                          activeColor: Colors.black,
                          onChanged: (value) {
                            if (value == true) {
                              filterProvider.updateSubCategoryIds([
                                ...filterProvider.selectedSubCategoryIds,
                                subCategoryId,
                              ]);
                            } else {
                              filterProvider.updateSubCategoryIds(
                                filterProvider.selectedSubCategoryIds
                                    .where((id) => id != subCategoryId)
                                    .toList(),
                              );
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
                        subCategoryProvider
                                .subCategoryItems!.data![index].name ??
                            '',
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
      },
    );
  }
}
// class ProductSubCategory extends StatefulWidget {
//   final String? categoryName;
//   final int? id;
//   const ProductSubCategory({this.categoryName, this.id, Key? key})
//       : super(key: key);

//   @override
//   _ProductSubCategoryState createState() => _ProductSubCategoryState();
// }

// class _ProductSubCategoryState extends State<ProductSubCategory> {
//   final List<int> _selectedIndices = [];
//   int? _previousCategoryId;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final selectedCategoryId = Provider.of<FilterProvider>(context).categoryId;

//     if (selectedCategoryId != null &&
//         selectedCategoryId != _previousCategoryId) {
//       setState(() {
//         _selectedIndices.clear();
//       });
//       if (widget.categoryName != null && selectedCategoryId != null)
//         Provider.of<SubCategoryProvider>(context, listen: false)
//             .fetchSubCategoriesItems(
//                 categoryName: widget.categoryName!,
//                 id: selectedCategoryId.toString());
//       _previousCategoryId = selectedCategoryId;
//     }
//   }

//   void _onCheckboxChanged(bool? value, int index, int subCategoryId) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(subCategoryId);
//       } else {
//         _selectedIndices.remove(subCategoryId);
//       }
//       Provider.of<FilterProvider>(context, listen: false)
//           .updateSubCategoryIds(_selectedIndices);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer<SubCategoryProvider>(builder: (context, subValue, child) {
//       if (subValue.subCategoryItems == null ||
//           subValue.subCategoryItems!.data == null ||
//           subValue.subCategoryItems!.data!.isEmpty) {
//         return SizedBox();
//       }
//       double itemHeight = querySize.height * 0.05;
//       double calculatedHeight =
//           itemHeight * subValue.subCategoryItems!.data!.length;
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Product Sub Category",
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
//               itemCount: subValue.subCategoryItems!.data!.length,
//               itemBuilder: (context, index) {
//                 int subCategoryId =
//                     subValue.subCategoryItems!.data![index].id ?? 0;
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(subCategoryId),
//                         activeColor: Colors.black,
//                         onChanged: (value) =>
//                             _onCheckboxChanged(value, index, subCategoryId),
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
//                       subValue.subCategoryItems!.data![index].name ?? '',
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

//int? cateogryid;
