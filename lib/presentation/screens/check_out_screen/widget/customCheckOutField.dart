import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lenore/core/constant.dart';

Column customCheckOutField(BuildContext context, String assetName,
    String fieldText, String name, TextEditingController controller,
    {String? errorMessage}) {
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
        height: sizeQuery.height * 0.062,
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
                keyboardType:
                    name == "Mobile Number" || name == 'Giftee Mobile Number'
                        ? TextInputType.number
                        : null,
                controller: controller,
                inputFormatters:
                    name == "Mobile Number" || name == 'Giftee Mobile Number'
                        ? [
                            LengthLimitingTextInputFormatter(8),
                            FilteringTextInputFormatter.digitsOnly,
                          ]
                        : null,
                decoration: InputDecoration(
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
      if (errorMessage != null)
        Padding(
          padding: EdgeInsets.only(top: sizeQuery.height * 0.005),
          child: Text(
            errorMessage,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
    ],
  );
}
