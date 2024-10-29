import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';

Column customCustomiseField(
    {required BuildContext context,
    required String assetName,
    required String fieldText,
    required String name,
    required TextEditingController controller,
    required String? errorText}) {
  var sizeQuery = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: TextStyle(
            fontFamily: 'Jost',
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
      SizedBox(
        height: sizeQuery.height * 0.01,
      ),
      Container(
        height: sizeQuery.height * 0.059,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
          borderRadius: BorderRadius.circular(sizeQuery.width * 0.08),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(sizeQuery.height * 0.015),
              child: Image.asset(
                assetName,
                width: sizeQuery.width * 0.068,
                height: sizeQuery.height * 0.028,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  // errorText: errorText,
                  hintStyle: const TextStyle(color: Color(0xFFD0D0D0)),
                  border: InputBorder.none,
                  hintText: fieldText,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: sizeQuery.height * 0.015,
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
