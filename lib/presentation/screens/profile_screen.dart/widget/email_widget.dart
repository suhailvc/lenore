import 'package:flutter/material.dart';

emailColumn(
    {required BuildContext context,
    required String assetName,
    required String columnName}) {
  var sizeQuery = MediaQuery.of(context).size;
  return SizedBox(
    width: sizeQuery.width * .68,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email ID",
          style: TextStyle(
              fontFamily: 'Jost',
              color: const Color(0xFF008186),
              fontSize: sizeQuery.height * 0.021,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: sizeQuery.height * 0.01,
        ),
        Container(
          height: sizeQuery.height * 0.07,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF00ACB3), width: 1.5),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(sizeQuery.height * 0.015),
                child: Image.asset(
                  assetName,
                  width: sizeQuery.width * 0.1,
                  height: sizeQuery.height * 0.09,
                ),
              ),
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  columnName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: sizeQuery.height * 0.015,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
