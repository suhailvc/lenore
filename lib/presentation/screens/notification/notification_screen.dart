import 'package:flutter/material.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    int num = 3;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customOneSizedBox(querySize),
              customTopBar(querySize, context),
              customSizedBox(querySize),
              Text(
                "Notifications",
                style: TextStyle(
                    fontSize: querySize.width * 0.06,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'ElMessiri',
                    color: textColor),
              ),
              customSizedBox(querySize),
              Text(
                "15 August 2024",
                style: TextStyle(
                    fontSize: querySize.width * 0.034,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Jost',
                    color: const Color(0xFF667080)),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: num,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: querySize.height * 0.01),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: querySize.width * 0.23,
                              height: querySize.width * 0.21,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/carts/check_out_image.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(
                                    querySize.width * 0.02),
                              ),
                            ),
                            SizedBox(width: querySize.width * 0.04),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: querySize.height * 0.01,
                                    ),
                                    Text('Lorem ipsum dolor sit amet',
                                        style: TextStyle(
                                          color: const Color(0xFF2F2F2F),
                                          fontFamily: 'Segoe',
                                          fontSize: querySize.width * 0.032,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    SizedBox(
                                      height: querySize.height * 0.005,
                                    ),
                                    Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, ",
                                      style: TextStyle(
                                        fontFamily: 'Segoe',
                                        fontSize: querySize.width * 0.03,
                                        color: const Color(0xFFC2C2C2),
                                      ),
                                    ),
                                  ]),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: querySize.height * 0.036,
                                ),
                                Text(
                                  "10:10 am",
                                  style: TextStyle(
                                    fontFamily: 'Segoe',
                                    fontSize: querySize.width * 0.034,
                                    color: const Color(0xFFC2C2C2),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: querySize.height * 0.01,
                        ),
                        const Divider(
                          color: Color(0x2E667080),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
