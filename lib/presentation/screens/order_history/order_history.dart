import 'package:flutter/material.dart';
import 'package:lenore/application/provider/auth_provider/auth_provider.dart';
import 'package:lenore/application/provider/order_history_provider/order_history_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/order_detail_screen/order_detail_screen.dart';
import 'package:lenore/presentation/widgets/custom_top_bar.dart';
import 'package:lenore/presentation/widgets/name_top_bar.dart';
import 'package:lenore/presentation/widgets/sign_out_widget.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();
    _fetchOrderHistory();
  }

  Future<void> _fetchOrderHistory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = await authProvider.getToken();
    print(token);
    if (token != null) {
      Provider.of<OrderHistoryProvider>(context, listen: false)
          .fetchOrderHistory(token);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customOneSizedBox(querySize),
                nameTopBar(querySize, context, 'Order History'),
                //  customTopBar(querySize, context),
                // customSizedBox(querySize),
                // Text(
                //   "Order History",
                //   style: TextStyle(
                //     fontSize: querySize.width * 0.06,
                //     fontWeight: FontWeight.w600,
                //     fontFamily: 'ElMessiri',
                //     color: textColor,
                //   ),
                // ),
                customSizedBox(querySize),
                !Provider.of<AuthProvider>(context).hasToken
                    ? askSignIn(querySize)
                    : Consumer<OrderHistoryProvider>(
                        builder: (context, orderHistoryProvider, child) {
                          if (orderHistoryProvider.isLoading) {
                            return lenoreGif(querySize);
                          }
                          if (orderHistoryProvider.orderitems == null ||
                              orderHistoryProvider.orderitems!.data!.isEmpty) {
                            return Center(child: Text("No orders found"));
                          }
                          return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                orderHistoryProvider.orderitems!.data!.length,
                            itemBuilder: (context, index) {
                              final order =
                                  orderHistoryProvider.orderitems!.data![index];
                              return Column(
                                children: [
                                  Container(
                                    width: querySize.width,
                                    height: querySize.height * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          querySize.width * 0.03),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: querySize.width * 0.001,
                                          blurRadius: querySize.width * 0.02,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              querySize.width * 0.03),
                                          child: Container(
                                            width: querySize.width * 0.2,
                                            height: querySize.width * 0.22,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/app icon.png"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      querySize.width * 0.01),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height:
                                                    querySize.height * 0.035),
                                            Text(
                                              "Order Id: ${order.orderId}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF353E4D),
                                                  fontFamily: 'Segoe',
                                                  fontSize:
                                                      querySize.height * 0.015),
                                            ),
                                            SizedBox(
                                                height:
                                                    querySize.height * 0.01),
                                            Text(
                                              "Order Status: ${order.orderStatus}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF353E4D),
                                                  fontFamily: 'Segoe',
                                                  fontSize: querySize.height *
                                                      0.0128),
                                            ),
                                            SizedBox(
                                                height:
                                                    querySize.height * 0.01),
                                            Text(
                                              order.date ?? '',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      const Color(0xFF667080),
                                                  fontFamily: 'Segoe',
                                                  fontSize:
                                                      querySize.height * 0.014),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          children: [
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom:
                                                      querySize.height * 0.015),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrderDetailScreen(
                                                        orderId:
                                                            order.orderId ?? '',
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Order Detail',
                                                  style: TextStyle(
                                                    fontSize:
                                                        querySize.width * 0.028,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Jost',
                                                    color:
                                                        const Color(0xFF667080),
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: querySize.width * 0.03),
                                          ],
                                        ),
                                        SizedBox(
                                            width: querySize.height * 0.02),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: querySize.height * 0.02),
                                ],
                              );
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class OrderHistory extends StatelessWidget {
//   const OrderHistory({super.key});

//   Future<String?> _getToken(AuthProvider authProvider) async {
//     return await authProvider.getToken();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customOneSizedBox(querySize),
//                 customTopBar(querySize, context),
//                 customSizedBox(querySize),
//                 Text(
//                   "Order History",
//                   style: TextStyle(
//                     fontSize: querySize.width * 0.06,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'ElMessiri',
//                     color: textColor,
//                   ),
//                 ),
//                 customSizedBox(querySize),
//                 // Using FutureBuilder to check if the user is signed in
//                 FutureBuilder<String?>(
//                   future: _getToken(
//                       Provider.of<AuthProvider>(context, listen: false)),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return lenoreGif(querySize);
//                     }

//                     final token = snapshot.data;
//                     if (token == null) {
//                       return Center(
//                         child: Text(
//                           'You are not signed in',
//                           style: TextStyle(
//                             fontSize: querySize.width * 0.05,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Fetch order history if signed in
//                       Provider.of<OrderHistoryProvider>(context, listen: false)
//                           .fetchOrderHistory(token);

//                       // Display Order History using Consumer
//                       return Consumer<OrderHistoryProvider>(
//                         builder: (context, orderHistoryProvider, child) {
//                           if (orderHistoryProvider.isLoading) {
//                             return lenoreGif(querySize);
//                           }
//                           if (orderHistoryProvider.orderitems == null ||
//                               orderHistoryProvider.orderitems!.data!.isEmpty) {
//                             return Center(child: Text("No orders found"));
//                           }
//                           return ListView.builder(
//                             reverse: true,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount:
//                                 orderHistoryProvider.orderitems!.data!.length,
//                             itemBuilder: (context, index) {
//                               final order =
//                                   orderHistoryProvider.orderitems!.data![index];
//                               return Column(
//                                 children: [
//                                   Container(
//                                     width: querySize.width,
//                                     height: querySize.height * 0.15,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(
//                                           querySize.width * 0.03),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.25),
//                                           spreadRadius: querySize.width * 0.001,
//                                           blurRadius: querySize.width * 0.02,
//                                           offset: const Offset(0, 3),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.all(
//                                               querySize.width * 0.03),
//                                           child: Container(
//                                             width: querySize.width * 0.2,
//                                             height: querySize.width * 0.22,
//                                             decoration: BoxDecoration(
//                                               image: const DecorationImage(
//                                                 image: AssetImage(
//                                                     "assets/images/app icon.png"),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       querySize.width * 0.01),
//                                             ),
//                                           ),
//                                         ),
//                                         Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                                 height:
//                                                     querySize.height * 0.035),
//                                             Text(
//                                               "Order Id: ${order.orderId}",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   color:
//                                                       const Color(0xFF353E4D),
//                                                   fontFamily: 'Segoe',
//                                                   fontSize:
//                                                       querySize.height * 0.015),
//                                             ),
//                                             SizedBox(
//                                               height: querySize.height * 0.01,
//                                             ),
//                                             Text(
//                                               "Order Status: ${order.orderStatus}",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   color:
//                                                       const Color(0xFF353E4D),
//                                                   fontFamily: 'Segoe',
//                                                   fontSize: querySize.height *
//                                                       0.0128),
//                                             ),
//                                             SizedBox(
//                                                 height:
//                                                     querySize.height * 0.01),
//                                             Text(
//                                               order.date ?? '',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.w700,
//                                                   color:
//                                                       const Color(0xFF667080),
//                                                   fontFamily: 'Segoe',
//                                                   fontSize:
//                                                       querySize.height * 0.014),
//                                             ),
//                                           ],
//                                         ),
//                                         Spacer(),
//                                         Column(
//                                           children: [
//                                             Spacer(),
//                                             Padding(
//                                               padding: EdgeInsets.only(
//                                                   bottom:
//                                                       querySize.height * 0.015),
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           OrderDetailScreen(
//                                                         orderId:
//                                                             order.orderId ?? '',
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                                 child: Text(
//                                                   'Order Detail',
//                                                   style: TextStyle(
//                                                     fontSize:
//                                                         querySize.width * 0.028,
//                                                     fontWeight: FontWeight.w600,
//                                                     fontFamily: 'Jost',
//                                                     color:
//                                                         const Color(0xFF667080),
//                                                     decoration: TextDecoration
//                                                         .underline,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: querySize.width * 0.03,
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                             width: querySize.height * 0.02),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(height: querySize.height * 0.02),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class OrderHistory extends StatelessWidget {
//   const OrderHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     bool isSignedIn = false;

//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final token = await authProvider.getToken();
//       if (token != null) {
//         isSignedIn = true;
//         Provider.of<OrderHistoryProvider>(context).fetchOrderHistory(token);
//       } else {
//         isSignedIn = false;
//       }
//     });
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               customOneSizedBox(querySize),
//               customTopBar(querySize, context),
//               customSizedBox(querySize),
//               Text(
//                 "Order History",
//                 style: TextStyle(
//                     fontSize: querySize.width * 0.06,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'ElMessiri',
//                     color: textColor),
//               ),
//               customSizedBox(querySize),
//               Consumer<OrderHistoryProvider>(
//                   builder: (context, orderHistoryvalue, child) {
//                 if (orderHistoryvalue.isLoading) {
//                   return lenoreGif(querySize);
//                 }
//                 if (orderHistoryvalue.orderitems!.data == null ||
//                     orderHistoryvalue.orderitems!.data == []) {
//                   return SizedBox();
//                 }
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: orderHistoryvalue.orderitems!.data!.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Container(
//                           width: querySize.width * 1,
//                           height: querySize.height * 0.17,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                                 BorderRadius.circular(querySize.width * 0.03),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.25),
//                                 spreadRadius: querySize.width * 0.001,
//                                 blurRadius: querySize.width * 0.02,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.all(querySize.width * 0.03),
//                                 child: Container(
//                                   width: querySize.width * 0.3,
//                                   height: querySize.width * 0.28,
//                                   decoration: BoxDecoration(
//                                     image: const DecorationImage(
//                                         image: NetworkImage(
//                                             "assets/images/carts/cart_image.png"),
//                                         fit: BoxFit.cover),
//                                     //  color: Colors.red,
//                                     borderRadius: BorderRadius.circular(
//                                         querySize.width * 0.01),
//                                   ),
//                                 ),
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: querySize.height * 0.022,
//                                   ),
//                                   Text(
//                                     orderHistoryvalue
//                                         .orderitems!.data![index].orderId,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(0xFF353E4D),
//                                         fontFamily: 'Segoe',
//                                         fontSize: querySize.height * 0.012),
//                                   ),
//                                   Text(
//                                     orderHistoryvalue
//                                         .orderitems!.data![index].orderStatus,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(0xFF353E4D),
//                                         fontFamily: 'Segoe',
//                                         fontSize: querySize.height * 0.014),
//                                   ),
//                                   SizedBox(
//                                     height: querySize.height * 0.01,
//                                   ),
//                                   Text(
//                                     orderHistoryvalue
//                                         .orderitems!.data![index].date,
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                         color: const Color(0xFF667080),
//                                         fontFamily: 'Segoe',
//                                         fontSize: querySize.height * 0.016),
//                                   ),
//                                   SizedBox(
//                                     height: querySize.height * 0.01,
//                                   ),
//                                   Text(
//                                     'Size: US 7',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         color: const Color(0xFF353E4D),
//                                         fontFamily: 'Segoe',
//                                         fontSize: querySize.height * 0.014),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: querySize.width * 0.1,
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     const OrderDetailScreen(),
//                                               ));
//                                         },
//                                         child: Text(
//                                           'Order Detail',
//                                           style: TextStyle(
//                                             fontSize: querySize.width * 0.028,
//                                             fontWeight: FontWeight.w600,
//                                             fontFamily: 'Jost',
//                                             color: const Color(0xFF667080),
//                                             decoration:
//                                                 TextDecoration.underline,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: querySize.height * 0.02,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: querySize.height * 0.02,
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               })
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
