import 'package:flutter/material.dart';
import 'package:lenore/application/provider/notification_provider/notification_provider.dart';
import 'package:lenore/application/provider/profile_provider/profile_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/multiple_shimmer.dart';
import 'package:lenore/presentation/widgets/name_top_bar.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () => Provider.of<NotificationProvider>(context, listen: false)
          .fetchNotification(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customOneSizedBox(querySize),
                nameTopBar(querySize, context, 'Notifications'),
                // customTopBar(querySize, context),
                // customSizedBox(querySize),
                // Text(
                //   "Notifications",
                //   style: TextStyle(
                //       fontSize: querySize.width * 0.06,
                //       fontWeight: FontWeight.w600,
                //       fontFamily: 'ElMessiri',
                //       color: textColor),
                // ),
                customSizedBox(querySize),
                // Text(
                //   "15 August 2024",
                //   style: TextStyle(
                //       fontSize: querySize.width * 0.034,
                //       fontWeight: FontWeight.w500,
                //       fontFamily: 'Jost',
                //       color: const Color(0xFF667080)),
                // ),
                Consumer<NotificationProvider>(
                  builder: (context, notificationValue, child) {
                    if (notificationValue.showGif) {
                      return multipleShimmerLoading(
                          containerHeight: querySize.height * 0.06);
                      // return lenoreGif(querySize);
                    } else if (notificationValue.profile == null) {
                      return SizedBox();
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: notificationValue.profile!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: querySize.height * 0.01),
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
                                              "assets/images/app icon.png"),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            querySize.width * 0.02),
                                      ),
                                    ),
                                    SizedBox(width: querySize.width * 0.04),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: querySize.height * 0.01,
                                            ),
                                            Text(
                                                notificationValue.profile!
                                                        .data![index].title ??
                                                    '',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF2F2F2F),
                                                  fontFamily: 'Segoe',
                                                  fontSize:
                                                      querySize.width * 0.032,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            SizedBox(
                                              height: querySize.height * 0.005,
                                            ),
                                            Text(
                                              notificationValue
                                                      .profile!
                                                      .data![index]
                                                      .description ??
                                                  '',
                                              style: TextStyle(
                                                fontFamily: 'Segoe',
                                                fontSize:
                                                    querySize.width * 0.03,
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
                                        // Text(
                                        //   "10:10 am",
                                        //   style: TextStyle(
                                        //     fontFamily: 'Segoe',
                                        //     fontSize: querySize.width * 0.034,
                                        //     color: const Color(0xFFC2C2C2),
                                        //   ),
                                        // ),
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
                            ));
                      },
                    );
                  },
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
