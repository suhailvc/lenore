import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/home_provider/collection_provider/collection_provider.dart';
import 'package:provider/provider.dart';

class CollectionFilter extends StatefulWidget {
  const CollectionFilter({super.key});

  @override
  State<CollectionFilter> createState() => _CollectionFilterState();
}

class _CollectionFilterState extends State<CollectionFilter> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CollectionProvider>(context, listen: false)
          .collectionProviderMethod();
    });
    // Provider.of<CollectionProvider>(context, listen: false)
    //     .collectionProviderMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer2<CollectionProvider, FilterProvider>(
      builder: (context, collectionProvider, filterProvider, child) {
        double itemHeight = querySize.height * 0.05;
        double calculatedHeight =
            itemHeight * (collectionProvider.collectionItems.data?.length ?? 0);

        if (collectionProvider.collectionItems.data!.isEmpty) {
          return SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Collection",
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
                itemCount: collectionProvider.collectionItems.data!.length,
                itemBuilder: (context, index) {
                  int collectionId =
                      collectionProvider.collectionItems.data![index].id!;

                  return Row(
                    children: [
                      Transform.scale(
                        scale: querySize.height * 0.0014,
                        child: Checkbox(
                          visualDensity: VisualDensity.compact,
                          value: filterProvider.selectedCollectionIds
                              .contains(collectionId),
                          activeColor: Colors.black,
                          onChanged: (value) {
                            if (value == true) {
                              filterProvider.updateCollectionIds([
                                ...filterProvider.selectedCollectionIds,
                                collectionId
                              ]);
                            } else {
                              filterProvider.updateCollectionIds(
                                filterProvider.selectedCollectionIds
                                    .where((id) => id != collectionId)
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
                        collectionProvider.collectionItems.data![index].name ??
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
}// class CollectionFilter extends StatefulWidget {
//   const CollectionFilter({super.key});

//   @override
//   State<CollectionFilter> createState() => _CollectionFilterState();
// }

// class _CollectionFilterState extends State<CollectionFilter> {
//   final List<int> _selectedIndices = [];

//   @override
//   void initState() {
//     Provider.of<CollectionProvider>(context, listen: false)
//         .collectionProviderMethod();
//     super.initState();
//   }

//   void _onCheckboxChanged(bool? value, int index, int collectionId) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(collectionId);
//       } else {
//         _selectedIndices.remove(collectionId);
//       }
//       Provider.of<FilterProvider>(context, listen: false)
//           .updateCollectionIds(_selectedIndices);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer<CollectionProvider>(builder: (context, subValue, child) {
//       double itemHeight = querySize.height * 0.05;
//       double calculatedHeight =
//           itemHeight * (subValue.collectionItems.data?.length ?? 0);
//       if (subValue.collectionItems.data!.isEmpty) {
//         return SizedBox();
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Collection",
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
//               itemCount: subValue.collectionItems.data!.length,
//               itemBuilder: (context, index) {
//                 int collectionId = subValue.collectionItems.data![index].id!;
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(collectionId),
//                         activeColor: Colors.black,
//                         onChanged: (value) =>
//                             _onCheckboxChanged(value, index, collectionId),
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
//                       subValue.collectionItems.data![index].name ?? '',
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
