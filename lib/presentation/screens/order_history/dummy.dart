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
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: querySize.width * 0.04),
//             child: Column(
//               children: [
//                 customOneSizedBox(querySize),
//                 nameTopBar(querySize, context, 'Order History'),
//                 Consumer<OrderStatusProvider>(
//                   builder: (context, statusValue, child) {
//                     int? num = statusValue.orderStatus?.data?.orderStatus;
//                     if (num == null) {
//                       return Center(child: Text("No order status available"));
//                     }

//                     // Define statuses and corresponding images
//                     List<Map<String, String>> statusesWithImages = [];
//                     switch (num) {
//                       case 0:
//                         statusesWithImages = [
//                           {"status": "Pending", "image": "assets/pending.png"},
//                         ];
//                         break;
//                       case 1:
//                         statusesWithImages = [
//                           {"status": "Pending", "image": "assets/pending.png"},
//                           {
//                             "status": "Confirmed",
//                             "image": "assets/confirmed.png"
//                           },
//                         ];
//                         break;
//                       case 2:
//                         statusesWithImages = [
//                           {"status": "Pending", "image": "assets/pending.png"},
//                           {
//                             "status": "Confirmed",
//                             "image": "assets/confirmed.png"
//                           },
//                           {"status": "Packing", "image": "assets/packing.png"},
//                         ];
//                         break;
//                       case 3:
//                         statusesWithImages = [
//                           {"status": "Pending", "image": "assets/pending.png"},
//                           {
//                             "status": "Confirmed",
//                             "image": "assets/confirmed.png"
//                           },
//                           {"status": "Packing", "image": "assets/packing.png"},
//                           {
//                             "status": "Out for delivery",
//                             "image": "assets/out_for_delivery.png"
//                           },
//                         ];
//                         break;
//                       case 4:
//                         statusesWithImages = [
//                           {"status": "Pending", "image": "assets/pending.png"},
//                           {
//                             "status": "Confirmed",
//                             "image": "assets/confirmed.png"
//                           },
//                           {"status": "Packing", "image": "assets/packing.png"},
//                           {
//                             "status": "Out for delivery",
//                             "image": "assets/out_for_delivery.png"
//                           },
//                           {
//                             "status": "Delivered",
//                             "image": "assets/delivered.png"
//                           },
//                         ];
//                         break;
//                       case 5:
//                         statusesWithImages = [
//                           {
//                             "status": "Declined",
//                             "image": "assets/declined.png"
//                           },
//                         ];
//                         break;
//                       default:
//                         statusesWithImages = [
//                           {
//                             "status": "Unknown status",
//                             "image": "assets/unknown.png"
//                           },
//                         ];
//                     }

//                     return Column(
//                       children: statusesWithImages
//                           .map(
//                             (statusWithImage) => Row(
//                               children: [
//                                 Image.asset(
//                                   statusWithImage["image"]!,
//                                   width: 30,
//                                   height: 30,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 SizedBox(width: 10),
//                                 Text(
//                                   statusWithImage["status"]!,
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           )
//                           .toList(),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
