import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(querySize.width * 0.06),
            color: Colors.white),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: querySize.width * 0.04,
                  right: querySize.width * 0.04,
                  bottom: querySize.height * 0.1,
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
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Segoe',
                            fontSize: querySize.height * 0.022,
                          ),
                        ),
                        Text(
                          'Reset All',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Segoe',
                            fontSize: querySize.height * 0.022,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    buildFilterSection(
                      querySize: querySize,
                      title: 'Gift By Event',
                      options: [
                        'Birthday',
                        'Love',
                        'Wedding',
                        'Graduation',
                        'Qatar National Day'
                      ],
                      selectedIndices: [1],
                    ),
                    buildFilterSection(
                      querySize: querySize,
                      title: 'Product Types',
                      options: [
                        'Bangle',
                        'Earring',
                        'Ring',
                        'Necklace',
                        'Sets',
                      ],
                      selectedIndices: [1],
                    ),
                    buildFilterSection(
                      querySize: querySize,
                      title: 'Budget',
                      options: ['500 QR', '1000 QR', '1500 QR', '2000 QR'],
                      selectedIndices: [1],
                    ),
                    buildFilterSection(
                      querySize: querySize,
                      title: 'Gold',
                      options: ['18 QR', '21 QR'],
                      selectedIndices: [1],
                    ),
                    buildFilterSection(
                      querySize: querySize,
                      title: 'Diamond',
                      options: ['18 QR', '21 QR'],
                      selectedIndices: [1],
                    ),
                    SizedBox(
                      height: querySize.height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
            // Fixed Apply Filter button
            Positioned(
              bottom: querySize.height * 0.03,
              left: querySize.width * 0.25,
              right: querySize.width * 0.25,
              child: SizedBox(
                width: querySize.width * 0.5,
                height: querySize.height * 0.055,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(querySize.height * 0.03),
                  ),
                  onPressed: () {
                    // Handle the Apply Filter action
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
      ),
    );
  }
}
// class FilterScreen extends StatelessWidget {
//   const FilterScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   customSizedBox(querySize),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Filters',
//                         style: TextStyle(
//                           color: textColor,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Segoe',
//                           fontSize: querySize.height * 0.022,
//                         ),
//                       ),
//                       Text(
//                         'Reset All',
//                         style: TextStyle(
//                           color: textColor,
//                           fontWeight: FontWeight.bold,
//                           fontFamily: 'Segoe',
//                           fontSize: querySize.height * 0.022,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   buildFilterSection(
//                     querySize: querySize,
//                     title: 'Gift By Event',
//                     options: [
//                       'Birthday',
//                       'Love',
//                       'Wedding',
//                       'Graduation',
//                       'Qatar Natinal Day'
//                     ],
//                     selectedIndices: [1],
//                   ),
//                   buildFilterSection(
//                     querySize: querySize,
//                     title: 'Product Types',
//                     options: [
//                       'Bangle',
//                       'Earing',
//                       'Ring',
//                       'Necklase',
//                       'Sets',
//                     ],
//                     selectedIndices: [1],
//                   ),
//                   buildFilterSection(
//                     querySize: querySize,
//                     title: 'Budget',
//                     options: ['500 QR', '1000 QR', '1500 QR', '2000 QR'],
//                     selectedIndices: [1],
//                   ),
//                   buildFilterSection(
//                     querySize: querySize,
//                     title: 'Gold',
//                     options: ['18 QR', '21 QR'],
//                     selectedIndices: [1],
//                   ),
//                   buildFilterSection(
//                     querySize: querySize,
//                     title: 'Diamond',
//                     options: ['18 QR', '21 QR'],
//                     selectedIndices: [1],
//                   ),
//                   SizedBox(
//                     height: querySize.height * 0.07,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         floatingActionButton: SizedBox(
//           width: querySize.width * 0.5,
//           height: querySize.height * 0.055,
//           child: FloatingActionButton(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(querySize.height * 0.03),
//             ),
//             onPressed: () {},
//             backgroundColor: const Color(0xFF00ACB3),
//             child: const Text(
//               "Apply Filter",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'ElMessiri',
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
//   }
// }

Widget buildFilterSection({
  required String title,
  required List<String> options,
  required List<int> selectedIndices,
  required Size querySize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontFamily: 'Segoe',
          fontSize: querySize.height * 0.021,
        ),
      ),
      SizedBox(height: querySize.height * 0.01),
//       List.generate(options.length, (index)){
//         child: Row(
//           children: [
//             Checkbox(
//               value: true,
//               onChanged: (value) {},
//             ),
//             Text(title)
//           ],
//         );
// },
      Column(
        children: List.generate(options.length, (index) {
          return Row(
            children: [
              Transform.scale(
                scale: querySize.height * 0.0014,
                child: Checkbox(
                  visualDensity: VisualDensity.compact,
                  value: false,
                  activeColor: textColor,
                  onChanged: (value) {},
                  side: WidgetStateBorderSide.resolveWith(
                    (states) => BorderSide(
                      width: querySize.width * 0.003,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: querySize.width * 0.03,
              ),
              Text(
                options[index],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Segoe',
                  fontSize: querySize.height * 0.018,
                ),
              )
            ],
          );
        }),
      ),
      // Column(
      //   children: List.generate(options.length, (index) {
      //     return CheckboxListTile(
      //       title: Text(options[index]),
      //       value: selectedIndices.contains(index),
      //       onChanged: (bool? value) {},
      //       activeColor: const Color(0xFF08777B),
      //     );
      //   }),
      // ),
      // if (title == 'Budget')
      //   const Align(
      //     alignment: Alignment.centerRight,
      //     child: Icon(Icons.expand_more),
      //   ),
      const Divider(),
    ],
  );
}
