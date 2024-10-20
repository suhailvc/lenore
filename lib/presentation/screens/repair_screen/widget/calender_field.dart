import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

class CalenderField extends StatefulWidget {
  const CalenderField({
    super.key,
    required this.querySize,
  });

  final Size querySize;

  @override
  State<CalenderField> createState() => _CalenderFieldState();
}

class _CalenderFieldState extends State<CalenderField> {
  TextEditingController dateController = TextEditingController();
  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Estimated Date",
          style: TextStyle(
              fontFamily: 'Jost',
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: widget.querySize.height * 0.01,
        ),
        Container(
          height: widget.querySize.height * 0.059,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
            borderRadius: BorderRadius.circular(widget.querySize.width * 0.08),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(widget.querySize.height * 0.015),
                child: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                      //  print("Selected Date: ${pickedDate.toString()}");
                    }
                  },
                  child: Image.asset(
                    'assets/images/date_icon.png',
                    width: widget.querySize.width * 0.068,
                    height: widget.querySize.height * 0.028,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
                    border: InputBorder.none,
                    hintText: 'dd/mm/yy',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: widget.querySize.height * 0.015,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// Column calenderField(
//     BuildContext context, String assetName, String fieldText, String name) {
//   var sizeQuery = MediaQuery.of(context).size;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         name,
//         style: TextStyle(
//             fontFamily: 'Jost',
//             color: textColor,
//             fontSize: 14,
//             fontWeight: FontWeight.w400),
//       ),
//       SizedBox(
//         height: sizeQuery.height * 0.01,
//       ),
//       Container(
//         height: sizeQuery.height * 0.059,
//         decoration: BoxDecoration(
//           border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
//           borderRadius: BorderRadius.circular(sizeQuery.width * 0.08),
//         ),
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(sizeQuery.height * 0.015),
//               child: GestureDetector(
//                 onTap: () async {
//                   // Show the date picker when the calendar icon is tapped
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate:
//                         DateTime.now(), // Current date as the initial date
//                     firstDate: DateTime(2000), // Minimum selectable date
//                     lastDate: DateTime(2100), // Maximum selectable date
//                   );

//                   if (pickedDate != null) {
//                     // Do something with the picked date
//                     print("Selected Date: ${pickedDate.toString()}");
//                   }
//                 },
//                 child: Image.asset(
//                   assetName,
//                   width: sizeQuery.width * 0.068,
//                   height: sizeQuery.height * 0.028,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
//                   border: InputBorder.none,
//                   hintText: fieldText,
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: sizeQuery.height * 0.015,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
