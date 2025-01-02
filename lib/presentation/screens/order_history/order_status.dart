import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/order_status_provider/order_status_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/widgets/name_top_bar.dart';
import 'package:provider/provider.dart';

class OrderStatusScreen extends StatefulWidget {
  final String orderId;
  const OrderStatusScreen({required this.orderId, super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  void initState() {
    _fetchOrderHistory();
    super.initState();
  }

  Future<void> _fetchOrderHistory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();
    if (token != null) {
      Provider.of<OrderStatusProvider>(context, listen: false)
          .fetchOrderStatus(widget.orderId, token);
    }
  }

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
            child: Column(
              children: [
                customOneSizedBox(querySize),
                nameTopBar(querySize, context, 'Order Tracking'),
                customOneSizedBox(querySize),
                Consumer<OrderStatusProvider>(
                  builder: (context, statusValue, child) {
                    int? num = statusValue.orderStatus?.data?.orderStatus;
                    if (num == null) {
                      return Center(child: Text("No order status available"));
                    }

                    // Define statuses and corresponding images
                    List<Map<String, String>> statusesWithImages = [];
                    switch (num) {
                      case 0:
                        statusesWithImages = [
                          {
                            "status": "Pending",
                            "image": "assets/images/order_status/pending.png"
                          },
                        ];
                        break;
                      case 1:
                        statusesWithImages = [
                          {
                            "status": "Pending",
                            "image": "assets/images/order_status/pending.png"
                          },
                          {
                            "status": "Confirmed",
                            "image": "assets/images/order_status/confirmed.png"
                          },
                        ];
                        break;
                      case 2:
                        statusesWithImages = [
                          {
                            "status": "Pending",
                            "image": "assets/images/order_status/pending.png"
                          },
                          {
                            "status": "Confirmed",
                            "image": "assets/images/order_status/confirmed.png"
                          },
                          {
                            "status": "Packing",
                            "image": "assets/images/order_status/packing.png"
                          },
                        ];
                        break;
                      case 3:
                        statusesWithImages = [
                          {
                            "status": "Pending",
                            "image": "assets/images/order_status/pending.png"
                          },
                          {
                            "status": "Confirmed",
                            "image": "assets/images/order_status/confirmed.png"
                          },
                          {
                            "status": "Packing",
                            "image": "assets/images/order_status/packing.png"
                          },
                          {
                            "status": "Out for delivery",
                            "image":
                                "assets/images/order_status/out-for-delivery.png"
                          },
                        ];
                        break;
                      case 4:
                        statusesWithImages = [
                          {
                            "status": "Pending",
                            "image": "assets/images/order_status/pending.png"
                          },
                          {
                            "status": "Confirmed",
                            "image": "assets/images/order_status/confirmed.png"
                          },
                          {
                            "status": "Packing",
                            "image": "assets/images/order_status/packing.png"
                          },
                          {
                            "status": "Out for delivery",
                            "image":
                                "assets/images/order_status/out-for-delivery.png"
                          },
                          {
                            "status": "Delivered",
                            "image": "assets/images/order_status/delivered.png"
                          },
                        ];
                        break;
                      case 5:
                        statusesWithImages = [
                          {
                            "status": "Declined",
                            "image": "assets/images/order_status/cancel.png"
                          },
                        ];
                        break;
                      default:
                        statusesWithImages = [
                          {
                            "status": "Unknown status",
                            "image": "assets/images/splash_screen.png"
                          },
                        ];
                    }

                    return Column(
                      children: statusesWithImages
                          .map(
                            (statusWithImage) => Column(
                              children: [
                                Container(
                                  width: querySize.width * 0.4,
                                  height: querySize.height * 0.17,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: statusWithImage["status"]! ==
                                              'Declined'
                                          ? Colors.red
                                          : appColor,
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        querySize.width *
                                            0.02), // Rounded corners
                                  ),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: querySize.height * 0.01,
                                        ),
                                        Image.asset(
                                          statusWithImage["image"]!,
                                          width: querySize.width * 0.3,
                                          height: querySize.height * 0.1,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: querySize.height * 0.01,
                                        ),
                                        Text(
                                          statusWithImage["status"]!,
                                          style: TextStyle(
                                              fontSize: querySize.width * 0.04,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: querySize.height * 0.01,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class OrderStatusScreen extends StatefulWidget {
//   final String orderId;
//   const OrderStatusScreen({required this.orderId, super.key});

//   @override
//   State<OrderStatusScreen> createState() => _OrderStatusScreenState();
// }

// class _OrderStatusScreenState extends State<OrderStatusScreen> {
//   @override
//   void initState() {
//     _fetchOrderHistory();
//     super.initState();
//   }

//   Future<void> _fetchOrderHistory() async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     final token = await authProvider.getToken();
//     print(token);
//     if (token != null) {
//       Provider.of<OrderStatusProvider>(context, listen: false)
//           .fetchOrderStatus(widget.orderId, token);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//           child: Column(
//             children: [
//               customOneSizedBox(querySize),
//               nameTopBar(querySize, context, 'Order Tracking'),
//               Consumer<OrderStatusProvider>(
//                 builder: (context, statusValue, child) {
//                   int? num = statusValue.orderStatus?.data?.orderStatus;
//                   if (num == null) {
//                     return Center(child: Text("No order status available"));
//                   }

//                   List<String> statuses = [];
//                   switch (num) {
//                     case 0:
//                       statuses = ["Pending"];
//                       break;
//                     case 1:
//                       statuses = ["Pending", "Confirmed"];
//                       break;
//                     case 2:
//                       statuses = ["Pending", "Confirmed", "Packing"];
//                       break;
//                     case 3:
//                       statuses = [
//                         "Pending",
//                         "Confirmed",
//                         "Packing",
//                         "Out for delivery"
//                       ];
//                       break;
//                     case 4:
//                       statuses = [
//                         "Pending",
//                         "Confirmed",
//                         "Packing",
//                         "Out for delivery",
//                         "Delivered"
//                       ];
//                       break;
//                     case 5:
//                       statuses = ["Declined"];
//                       break;
//                     default:
//                       statuses = ["Unknown status"];
//                   }

//                   return Column(
//                     children: statuses
//                         .map((status) => Text(
//                               status,
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.bold),
//                             ))
//                         .toList(),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
