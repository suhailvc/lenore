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
  final List<int> _selectedIndices = [];

  @override
  void initState() {
    Provider.of<GoldPurityProvider>(context, listen: false).loadGoldPurity();
    super.initState();
  }

  void _onCheckboxChanged(bool? value, int index, int goldPurity) {
    setState(() {
      if (value == true) {
        _selectedIndices.add(goldPurity);
      } else {
        _selectedIndices.remove(goldPurity);
      }
      Provider.of<FilterProvider>(context, listen: false)
          .updateGoldPurities(_selectedIndices);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size querySize = MediaQuery.of(context).size;

    return Consumer<GoldPurityProvider>(builder: (context, subValue, child) {
      double itemHeight = querySize.height * 0.05;
      double calculatedHeight =
          itemHeight * (subValue.goldPurityData?.data.length ?? 0);
      if (subValue.goldPurityData!.data.isEmpty) {
        return SizedBox();
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
              physics: NeverScrollableScrollPhysics(),
              itemCount: subValue.goldPurityData!.data.length,
              itemBuilder: (context, index) {
                int goldPurity =
                    int.parse(subValue.goldPurityData!.data[index].purity);
                ;
                return Row(
                  children: [
                    Transform.scale(
                      scale: querySize.height * 0.0014,
                      child: Checkbox(
                        visualDensity: VisualDensity.compact,
                        value: _selectedIndices.contains(goldPurity),
                        activeColor: Colors.black,
                        onChanged: (value) =>
                            _onCheckboxChanged(value, index, goldPurity),
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
    });
  }
}
// class GoldPurityFilter extends StatefulWidget {
//   const GoldPurityFilter({super.key});

//   @override
//   State<GoldPurityFilter> createState() => _GoldPurityFilterState();
// }

// class _GoldPurityFilterState extends State<GoldPurityFilter> {
//   @override
//   void initState() {
//     Provider.of<GoldPurityProvider>(context, listen: false).loadGoldPurity();

//     super.initState();
//   }

//   final String title = "Gold"; // Title defined directly in state

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

//     return Consumer<GoldPurityProvider>(builder: (context, subValue, child) {
//       // Calculate dynamic height based on item count
//       double itemHeight =
//           querySize.height * 0.05; // approximate height of each item row
//       double calculatedHeight =
//           itemHeight * (subValue.goldPurityData?.data.length ?? 0);
//       if (subValue.goldPurityData!.data.length == 0) {
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
//             height: querySize.height * 0.4,
//             //calculatedHeight < querySize.height * 0.3
//             //     ? calculatedHeight
//             //     : querySize.height * 0.3,
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: subValue.goldPurityData!.data.length,
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
//                       "${subValue.goldPurityData!.data[index].purity} k",
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
