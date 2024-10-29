import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

Row customCustomisationCheckBox(
  Size querySize,
  String checkBoxName,
  bool isChecked,
  ValueChanged<bool?> onChanged,
) {
  return Row(
    children: [
      Transform.scale(
        scale: querySize.height * 0.0014,
        child: Checkbox(
          visualDensity: VisualDensity.compact,
          value: isChecked,
          activeColor: textColor,
          onChanged: onChanged,
          side: BorderSide(
            width: querySize.width * 0.003,
            color: textColor,
          ),
        ),
      ),
      SizedBox(width: querySize.width * 0.004),
      Text(
        checkBoxName,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontFamily: 'Segoe',
          fontSize: querySize.height * 0.019,
        ),
      ),
    ],
  );
}

// import 'package:flutter/material.dart';
// import 'package:lenore/core/constant.dart';

// Row customCustomisationCheckBox(Size querySize, String checkBoxName) {
//   return Row(
//     children: [
//       Transform.scale(
//         scale: querySize.height * 0.0014,
//         child: Checkbox(
//           visualDensity: VisualDensity.compact,
//           value: false,
//           activeColor: textColor,
//           onChanged: (value) {},
//           side: WidgetStateBorderSide.resolveWith(
//             (states) => BorderSide(
//               width: querySize.width * 0.003,
//               color: textColor,
//             ),
//           ),
//         ),
//       ),
//       SizedBox(width: querySize.width * 0.004),
//       Text(
//         checkBoxName,
//         style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.019),
//       )
//     ],
//   );
// }
