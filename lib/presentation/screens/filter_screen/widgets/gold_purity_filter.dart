import 'package:flutter/material.dart';
import 'package:lenore/application/provider/filter_provider/filter_provider.dart';
import 'package:lenore/application/provider/gold_purity_provider/gold_purity_provider.dart';
import 'package:provider/provider.dart';

class GoldPurityFilter extends StatefulWidget {
  const GoldPurityFilter({super.key});

  @override
  State<GoldPurityFilter> createState() => _GoldPurityFilterState();
}

class _GoldPurityFilterState extends State<GoldPurityFilter> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GoldPurityProvider>(context, listen: false).loadGoldPurity();
    });
    // Provider.of<GoldPurityProvider>(context, listen: false).loadGoldPurity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer2<GoldPurityProvider, FilterProvider>(
      builder: (context, goldPurityProvider, filterProvider, child) {
        double itemHeight = querySize.height * 0.05;
        double calculatedHeight =
            itemHeight * (goldPurityProvider.goldPurityData?.data.length ?? 0);

        if (goldPurityProvider.goldPurityData?.data.isEmpty ?? true) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gold Purity",
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
                itemCount: goldPurityProvider.goldPurityData!.data.length,
                itemBuilder: (context, index) {
                  int goldId =
                      goldPurityProvider.goldPurityData!.data[index].id;
                  int goldPurity = int.parse(
                      goldPurityProvider.goldPurityData!.data[index].purity);

                  return Row(
                    children: [
                      Transform.scale(
                        scale: querySize.height * 0.0014,
                        child: Checkbox(
                          visualDensity: VisualDensity.compact,
                          value: filterProvider.selectedGoldPurities
                              .contains(goldId),
                          activeColor: Colors.black,
                          onChanged: (value) {
                            if (value == true) {
                              filterProvider.updateGoldPurities([
                                ...filterProvider.selectedGoldPurities,
                                goldId
                              ]);
                            } else {
                              filterProvider.updateGoldPurities(
                                filterProvider.selectedGoldPurities
                                    .where((id) => id != goldId)
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
                        "$goldPurity k",
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
// class GoldPurityFilter extends StatefulWidget {
//   const GoldPurityFilter({super.key});

//   @override
//   State<GoldPurityFilter> createState() => _GoldPurityFilterState();
// }

// class _GoldPurityFilterState extends State<GoldPurityFilter> {
//   final List<int> _selectedIndices = [];

//   @override
//   void initState() {
//     Provider.of<GoldPurityProvider>(context, listen: false).loadGoldPurity();
//     super.initState();
//   }

//   void _onCheckboxChanged(bool? value, int index, int goldPurity) {
//     setState(() {
//       if (value == true) {
//         _selectedIndices.add(goldPurity);
//       } else {
//         _selectedIndices.remove(goldPurity);
//       }
//       Provider.of<FilterProvider>(context, listen: false)
//           .updateGoldPurities(_selectedIndices);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size querySize = MediaQuery.of(context).size;

//     return Consumer<GoldPurityProvider>(builder: (context, subValue, child) {
//       double itemHeight = querySize.height * 0.05;
//       double calculatedHeight =
//           itemHeight * (subValue.goldPurityData?.data.length ?? 0);
//       if (subValue.goldPurityData!.data.isEmpty) {
//         return SizedBox();
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Gold Purity",
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
//               itemCount: subValue.goldPurityData!.data.length,
//               itemBuilder: (context, index) {
//                 int goldPurity =
//                     int.parse(subValue.goldPurityData!.data[index].purity);
//                 ;
//                 return Row(
//                   children: [
//                     Transform.scale(
//                       scale: querySize.height * 0.0014,
//                       child: Checkbox(
//                         visualDensity: VisualDensity.compact,
//                         value: _selectedIndices.contains(goldPurity),
//                         activeColor: Colors.black,
//                         onChanged: (value) =>
//                             _onCheckboxChanged(value, index, goldPurity),
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
//                       "$goldPurity k",
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
