import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/sub_category_provider/sub_category_provider.dart';
import 'package:provider/provider.dart';

class ProductSubCategory extends StatefulWidget {
  final String categoryName;
  final int id;
  const ProductSubCategory(
      {required this.categoryName, required this.id, Key? key})
      : super(key: key);

  @override
  _ProductSubCategoryState createState() => _ProductSubCategoryState();
}

class _ProductSubCategoryState extends State<ProductSubCategory> {
  final List<int> _selectedIndices = [];
  int? _previousCategoryId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final selectedCategoryId = Provider.of<FilterProvider>(context).categoryId;

    if (selectedCategoryId != null &&
        selectedCategoryId != _previousCategoryId) {
      setState(() {
        _selectedIndices.clear();
      });
      Provider.of<SubCategoryProvider>(context, listen: false)
          .fetchSubCategoriesItems(
              categoryName: widget.categoryName,
              id: selectedCategoryId.toString());
      _previousCategoryId = selectedCategoryId;
    }
  }

  void _onCheckboxChanged(bool? value, int index, int subCategoryId) {
    setState(() {
      if (value == true) {
        _selectedIndices.add(subCategoryId);
      } else {
        _selectedIndices.remove(subCategoryId);
      }
      Provider.of<FilterProvider>(context, listen: false)
          .updateSubCategoryIds(_selectedIndices);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer<SubCategoryProvider>(builder: (context, subValue, child) {
      double itemHeight = querySize.height * 0.05;
      double calculatedHeight =
          itemHeight * subValue.subCategoryItems!.data!.length;
      if (subValue.subCategoryItems!.data!.isEmpty) {
        return SizedBox();
      }
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: subValue.subCategoryItems!.data!.length,
              itemBuilder: (context, index) {
                int subCategoryId = subValue.subCategoryItems!.data![index].id!;
                return Row(
                  children: [
                    Transform.scale(
                      scale: querySize.height * 0.0014,
                      child: Checkbox(
                        visualDensity: VisualDensity.compact,
                        value: _selectedIndices.contains(subCategoryId),
                        activeColor: Colors.black,
                        onChanged: (value) =>
                            _onCheckboxChanged(value, index, subCategoryId),
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
                      subValue.subCategoryItems!.data![index].name ?? '',
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
// class ProductSubCategory extends StatefulWidget {
//   final String categoryName;
//   final int id;
//   const ProductSubCategory(
//       {required this.categoryName, required this.id, Key? key})
//       : super(key: key);

//   @override
//   _ProductSubCategoryState createState() => _ProductSubCategoryState();
// }

// class _ProductSubCategoryState extends State<ProductSubCategory> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final selectedCategoryId = Provider.of<FilterProvider>(context).categoryId;
//     if (selectedCategoryId != null) {
//       Provider.of<SubCategoryProvider>(context, listen: false)
//           .fetchSubCategoriesItems(
//               categoryName: widget.categoryName,
//               id: selectedCategoryId.toString());
//     }
//   }

//   final String title = "Product Sub Category";
//   final List<int> _selectedIndices = [];

//   void _onCheckboxChanged(bool? value, int index) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(index);
//       } else {
//         _selectedIndices.remove(index);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer<SubCategoryProvider>(builder: (context, subValue, child) {
//       double itemHeight = querySize.height * 0.05;
//       double calculatedHeight =
//           itemHeight * subValue.subCategoryItems!.data!.length;
//       if (subValue.subCategoryItems!.data!.isEmpty) {
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
//             height: calculatedHeight < querySize.height * 0.3
//                 ? calculatedHeight
//                 : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: subValue.subCategoryItems!.data!.length,
//               itemBuilder: (context, index) {
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(index),
//                         activeColor: Colors.black,
//                         onChanged: (value) => _onCheckboxChanged(value, index),
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
// class ProductSubCategory extends StatefulWidget {
//   final String categoryName;
//   final int id;
//   const ProductSubCategory(
//       {required this.categoryName, required this.id, Key? key})
//       : super(key: key);

//   @override
//   _ProductSubCategoryState createState() => _ProductSubCategoryState();
// }

// class _ProductSubCategoryState extends State<ProductSubCategory> {
//   @override
//   void initState() {
//     // Provider.of<SubCategoryProvider>(context, listen: false)
//     //     .fetchSubCategoriesItems(
//     //         categoryName: widget.categoryName,
//     //         id: cateogryid.toString() /*widget.id.toString()*/);
//     super.initState();
//   }

//   final String title =
//       "Product Sub Category"; // Title defined directly in state

//   final List<int> _selectedIndices = []; // Tracks selected checkboxes

//   void _onCheckboxChanged(bool? value, int index) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(index);
//       } else {
//         _selectedIndices.remove(index);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize =
//         MediaQuery.of(context).size; // Screen size for responsiveness

//     return Consumer<SubCategoryProvider>(builder: (context, subValue, child) {
//       // Calculate dynamic height based on item count
//       double itemHeight =
//           querySize.height * 0.05; // approximate height of each item row
//       double calculatedHeight =
//           itemHeight * subValue.subCategoryItems!.data!.length;
//       if (subValue.subCategoryItems!.data!.length == 0) {
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
//             height: calculatedHeight < querySize.height * 0.3
//                 ? calculatedHeight
//                 : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: subValue.subCategoryItems!.data!.length,
//               itemBuilder: (context, index) {
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(index),
//                         activeColor: Colors.black,
//                         onChanged: (value) => _onCheckboxChanged(value, index),
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
// class ProductType extends StatefulWidget {
//   final String categoryName;
//   final int id;
//   const ProductType({required this.categoryName, required this.id, Key? key})
//       : super(key: key);

//   @override
//   _ProductTypeState createState() => _ProductTypeState();
// }

// class _ProductTypeState extends State<ProductType> {
//   @override
//   void initState() {
//     // Provider.of<SubCategoryProvider>(context, listen: false)
//     //     .fetchSubCategoriesItems(
//     //         categoryName: widget.categoryName,
//     //         id: cateogryid.toString() /*widget.id.toString()*/);
//     super.initState();
//   }

//   final String title =
//       "Product Sub Category"; // Title defined directly in state

//   final List<int> _selectedIndices = []; // Tracks selected checkboxes

//   void _onCheckboxChanged(bool? value, int index) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(index);
//       } else {
//         _selectedIndices.remove(index);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize =
//         MediaQuery.of(context).size; // Screen size for responsiveness

//     return Consumer<SubCategoryProvider>(builder: (context, subValue, child) {
//       // Calculate dynamic height based on item count
//       double itemHeight =
//           querySize.height * 0.05; // approximate height of each item row
//       double calculatedHeight =
//           itemHeight * subValue.subCategoryItems!.data!.length;
//       if (subValue.subCategoryItems!.data!.length == 0) {
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
//             height: calculatedHeight < querySize.height * 0.3
//                 ? calculatedHeight
//                 : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: subValue.subCategoryItems!.data!.length,
//               itemBuilder: (context, index) {
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(index),
//                         activeColor: Colors.black,
//                         onChanged: (value) => _onCheckboxChanged(value, index),
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

int? cateogryid;
