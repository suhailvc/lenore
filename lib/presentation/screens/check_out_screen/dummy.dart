// import 'package:flutter/material.dart';

// class CheckOutScreen extends StatefulWidget {
//   const CheckOutScreen({super.key});

//   @override
//   State<CheckOutScreen> createState() => _CheckOutScreenState();
// }

// class _CheckOutScreenState extends State<CheckOutScreen> {
//   var myNameController = TextEditingController();
//   var myMobileNumberController = TextEditingController();
//   var mySelfTo = TextEditingController();
//   var mySelfMessage = TextEditingController();
//   String? selectedDate;
//   String? selfSelectedDate;
//   var giftteeNameController = TextEditingController();
//   var giftteemobileNumberController = TextEditingController();
//   var giftteeTo = TextEditingController();
//   var giftteeMessage = TextEditingController();
//   String? selectedDay;
//   String? selfSelectedDay;
//   String anonymous = '0';
//   bool isAnonymous = false;
//   bool todaySelected = true;
//   bool tommorrowSelected = false;
//   bool pickAdate = false;
//   bool selfTodaySelected = true;
//   bool selfTommorrowSelected = false;
//   bool selfPickAdate = false;
//   String? gifMyNameError;
//   String? giftMynumberError;
//   String? selfMyNameError;
//   String? selfMynumberError;
//   @override
//   Widget build(BuildContext context) {
//     var querySize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         children: [
//           giftMySelfSection(
//               querySize,
//               context,
//               cartValue.items,
//               cartValue.subTotal.toString(),
//               myNameController,
//               myMobileNumberController,
//               mySelfTo,
//               mySelfMessage),
//           sendAsGiftSection(
//               querySize,
//               context,
//               cartValue.items,
//               cartValue.subTotal.toString(),
//               myNameController,
//               myMobileNumberController,
//               giftteeNameController,
//               giftteemobileNumberController,
//               giftteeTo,
//               giftteeMessage),
//         ],
//       ),
//     );
//   }
// }

// Column sendAsGiftSection(
//   Size querySize,
//   BuildContext context,
//   List<HiveCartModel> item,
//   String total,
//   TextEditingController myName,
//   TextEditingController myMobileNumber,
//   TextEditingController giftteeName,
//   TextEditingController giftteeMobileNumber,
//   TextEditingController toContoller,
//   TextEditingController message,
// ) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       customSizedBox(querySize),
//       Text(
//         'My Details',
//         style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF667080),
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.017),
//       ),
//       customOneSizedBox(querySize),
//       customCheckOutField(context, "assets/images/profile/first_name_icon.png",
//           'Enter Your Name', 'Your Name', myName),
//       customOneSizedBox(querySize),
//       customCheckOutField(context, "assets/images/profile/qatar_flag_icon.png",
//           'Enter Your Number', 'Mobile Number', myMobileNumber),
//       customOneSizedBox(querySize),
//       customSizedBox(querySize),
//       Text(
//         'Giftee Detail',
//         style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF667080),
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.017),
//       ),
//       customOneSizedBox(querySize),
//       customCheckOutField(context, "assets/images/profile/first_name_icon.png",
//           'Enter Giftee Name', 'Giftee Name', giftteeName),
//       customOneSizedBox(querySize),
//       customCheckOutField(context, "assets/images/profile/qatar_flag_icon.png",
//           'Enter Giftee Number', 'Giftee Mobile Number', giftteeMobileNumber),
//       SizedBox(
//         height: querySize.width * 0.01,
//       ),
//       Row(
//         children: [
//           Checkbox(
//             visualDensity: VisualDensity.compact,
//             activeColor: textColor,
//             side: BorderSide(
//               width: querySize.width * 0.003,
//               color: textColor,
//             ),
//             value: isAnonymous,
//             onChanged: (value) {
//               isAnonymous = value ?? false;
//               anonymous = isAnonymous ? '1' : '0';
//               setState(
//                   () {}); // Update the state if this is within a StatefulWidget
//             },
//           ),
//           Text(
//             'Send as anonymous',
//             style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF858585),
//                 fontFamily: 'Segoe',
//                 fontSize: querySize.height * 0.015),
//           )
//         ],
//       ),
//       customOneSizedBox(querySize),
//       Container(
//           width: querySize.width * 1,
//           height: querySize.height * 0.385,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(querySize.width * 0.03)),
//           child: Padding(
//             padding: EdgeInsets.all(querySize.width * 0.038),
//             child: Column(
//               children: [
//                 checkOutMessageColumn(querySize, 'To', toContoller),
//                 customOneSizedBox(querySize),
//                 Container(
//                   width: querySize.width * 0.88,
//                   height: querySize.height * 0.18,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFEFEEEE),
//                     borderRadius: BorderRadius.circular(querySize.width * 0.02),
//                   ),
//                   child: TextFormField(
//                     controller: message,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: querySize.height * 0.01,
//                           horizontal: querySize.width * 0.04),
//                       hintText: 'Card Message',
//                       hintStyle: TextStyle(
//                           fontSize: querySize.height * 0.02,
//                           color: const Color(0xFFAAAEAE),
//                           fontFamily: 'Segoe'),
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 customOneSizedBox(querySize),
//                 // checkOutMessageColumn(querySize, 'From'),
//               ],
//             ),
//           )),
//       customOneSizedBox(querySize),
//       Text(
//         'Pick a date',
//         style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF667080),
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.017),
//       ),
//       SizedBox(
//         height: querySize.height * 0.01,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 todaySelected = !todaySelected;
//                 tommorrowSelected = false;
//               });
//               if (todaySelected == true) {
//                 selectedDay = 'today';
//                 selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
//               }
//               print(todaySelected);
//             },
//             child: Container(
//               width: querySize.width * 0.28,
//               height: querySize.height * 0.045,
//               decoration: BoxDecoration(
//                 color: todaySelected ? Colors.blue : appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.02),
//               ),
//               child: Center(
//                 child: Text(
//                   'Today',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white,
//                     fontFamily: 'Segoe',
//                     fontSize: querySize.height * 0.017,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 todaySelected = false;
//                 tommorrowSelected = !tommorrowSelected;
//               });
//               if (todaySelected == true) {
//                 selectedDay = 'tommorrow';
//                 selectedDate = DateFormat('yyyy-MM-dd')
//                     .format(DateTime.now().add(Duration(days: 1)));
//               }
//             },
//             child: Container(
//               width: querySize.width * 0.28,
//               height: querySize.height * 0.045,
//               decoration: BoxDecoration(
//                 color: tommorrowSelected ? Colors.blue : appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.02),
//               ),
//               child: Center(
//                 child: Text(
//                   'Tommorrow',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Segoe',
//                       fontSize: querySize.height * 0.017),
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//               onTap: () async {
//                 setState(() {
//                   todaySelected = false;
//                   tommorrowSelected = false;
//                 });
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now().add(const Duration(days: 1)),
//                   firstDate: DateTime.now().add(const Duration(days: 1)),
//                   lastDate: DateTime(2100),
//                 );

//                 if (pickedDate != null) {
//                   selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                 }
//               },
//               child: Container(
//                 width: querySize.width * 0.28,
//                 height: querySize.height * 0.045,
//                 decoration: BoxDecoration(
//                   color: appColor,
//                   borderRadius: BorderRadius.circular(querySize.width * 0.02),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Pick a date',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                         fontFamily: 'Segoe',
//                         fontSize: querySize.height * 0.017),
//                   ),
//                 ),
//               )),
//         ],
//       ),
//       SizedBox(
//         height: querySize.height * 0.018,
//       ),
//       Text(
//         'Note: Our team will contact the giftee for their location',
//         style: TextStyle(
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFFAAAEAE),
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.015),
//       ),
//       SizedBox(
//         height: querySize.height * 0.03,
//       ),
//       Row(
//         children: [
//           SizedBox(
//             width: querySize.width * 0.07,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Total',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                     fontFamily: 'Segoe',
//                     fontSize: querySize.height * 0.02),
//               ),
//               Text(
//                 "QAR ${total}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     color: appColor,
//                     fontFamily: 'Segoe',
//                     fontSize: querySize.height * 0.026),
//               )
//             ],
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () async {
//               var response =
//                   await Provider.of<CheckOutProvider>(context, listen: false)
//                       .saveAddress(CheckOutModel(
//                           orderType: "gift",
//                           myName: myNameController.text.trim(),
//                           myPhone: myMobileNumberController.text.trim(),
//                           to: toContoller.text.trim(),
//                           message: message.text.trim(),
//                           date: selectedDate.toString(),
//                           makeAnonymous: anonymous,
//                           deliveryType: selectedDay));
//               if (response != null) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentScreen(
//                         addressId: response.addressId.toString(),
//                       ),
//                     ));
//               }
//             },
//             child: Container(
//               width: querySize.width * 0.4,
//               height: querySize.height * 0.055,
//               decoration: BoxDecoration(
//                 color: appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.08),
//               ),
//               child: Center(
//                 child: Text(
//                   'Pay Now',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Segoe',
//                       fontSize: querySize.height * 0.017),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       SizedBox(
//         height: querySize.height * 0.04,
//       ),
//     ],
//   );
// }

// Column giftMySelfSection(
//   Size querySize,
//   BuildContext context,
//   List<HiveCartModel> item,
//   String total,
//   TextEditingController myName,
//   TextEditingController myMobileNumber,
//   TextEditingController toContoller,
//   TextEditingController message,
// ) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       customSizedBox(querySize),
//       Text(
//         'My Details',
//         style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF667080),
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.017),
//       ),
//       customOneSizedBox(querySize),
//       customCheckOutField(context, "assets/images/profile/first_name_icon.png",
//           'Enter Your Name', 'Your Name', myName),
//       customOneSizedBox(querySize),
//       customCheckOutField(context, "assets/images/profile/qatar_flag_icon.png",
//           'Enter Your Number', 'Mobile Number', myMobileNumber),
//       customOneSizedBox(querySize),
//       Container(
//           width: querySize.width * 1,
//           height: querySize.height * 0.385,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(querySize.width * 0.03)),
//           child: Padding(
//             padding: EdgeInsets.all(querySize.width * 0.038),
//             child: Column(
//               children: [
//                 checkOutMessageColumn(querySize, 'To', toContoller),
//                 customOneSizedBox(querySize),
//                 Container(
//                   width: querySize.width * 0.88,
//                   height: querySize.height * 0.18,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFEFEEEE),
//                     borderRadius: BorderRadius.circular(querySize.width * 0.02),
//                   ),
//                   child: TextFormField(
//                     controller: message,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: querySize.height * 0.01,
//                           horizontal: querySize.width * 0.04),
//                       hintText: 'Card Message',
//                       hintStyle: TextStyle(
//                           fontSize: querySize.height * 0.02,
//                           color: const Color(0xFFAAAEAE),
//                           fontFamily: 'Segoe'),
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 customOneSizedBox(querySize),
//               ],
//             ),
//           )),
//       customOneSizedBox(querySize),
//       Text(
//         'Pick a date',
//         style: TextStyle(
//             fontWeight: FontWeight.w600,
//             color: const Color(0xFF667080),
//             fontFamily: 'Segoe',
//             fontSize: querySize.height * 0.017),
//       ),
//       SizedBox(
//         height: querySize.height * 0.01,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 selfTodaySelected = !selfTodaySelected;
//                 selfTommorrowSelected = false;
//               });
//               if (todaySelected == true) {
//                 selfSelectedDay = 'today';
//                 selfSelectedDate =
//                     DateFormat('yyyy-MM-dd').format(DateTime.now());
//               }
//               print(todaySelected);
//             },
//             child: Container(
//               width: querySize.width * 0.28,
//               height: querySize.height * 0.045,
//               decoration: BoxDecoration(
//                 color: selfTodaySelected ? Colors.blue : appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.02),
//               ),
//               child: Center(
//                 child: Text(
//                   'Today',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Segoe',
//                       fontSize: querySize.height * 0.017),
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 selfTodaySelected = false;
//                 selfTommorrowSelected = !tommorrowSelected;
//               });
//               if (todaySelected == true) {
//                 selfSelectedDay = 'tomorrow';
//                 selfSelectedDate = DateFormat('yyyy-MM-dd')
//                     .format(DateTime.now().add(Duration(days: 1)));
//               }
//             },
//             child: Container(
//               width: querySize.width * 0.28,
//               height: querySize.height * 0.045,
//               decoration: BoxDecoration(
//                 color: selfTommorrowSelected ? Colors.blue : appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.02),
//               ),
//               child: Center(
//                 child: Text(
//                   'Tomorrow',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Segoe',
//                       fontSize: querySize.height * 0.017),
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () async {
//               setState(() {
//                 selfTodaySelected = false;
//                 selfTommorrowSelected = false;
//               });
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now().add(const Duration(days: 1)),
//                 firstDate: DateTime.now().add(const Duration(days: 1)),
//                 lastDate: DateTime(2100),
//               );

//               if (pickedDate != null) {
//                 selfSelectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//               }
//             },
//             child: Container(
//               width: querySize.width * 0.28,
//               height: querySize.height * 0.045,
//               decoration: BoxDecoration(
//                 color: appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.02),
//               ),
//               child: Center(
//                 child: Text(
//                   'Pick a date',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Segoe',
//                       fontSize: querySize.height * 0.017),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       customSizedBox(querySize),
//       Row(
//         children: [
//           SizedBox(
//             width: querySize.width * 0.07,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Total',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                     fontFamily: 'Segoe',
//                     fontSize: querySize.height * 0.02),
//               ),
//               Text(
//                 "QAR ${total}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     color: appColor,
//                     fontFamily: 'Segoe',
//                     fontSize: querySize.height * 0.026),
//               )
//             ],
//           ),
//           const Spacer(),
//           GestureDetector(
//             onTap: () async {
//               var response = await Provider.of<CheckOutProvider>(context,
//                       listen: false)
//                   .saveAddress(CheckOutModel(
//                       orderType: "myself",
//                       myName: myNameController.text.trim(),
//                       myPhone: myMobileNumberController.text.trim(),
//                       gifteeName: giftteeNameController.text.trim(),
//                       gifteePhone: giftteemobileNumberController.text.trim(),
//                       to: toContoller.text.trim(),
//                       message: message.text.trim(),
//                       date: selectedDate.toString(),
//                       makeAnonymous: '0',
//                       deliveryType: selectedDay));
//               if (response != null) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaymentScreen(
//                         addressId: response.addressId.toString(),
//                       ),
//                     ));
//               }
//             },
//             child: Container(
//               width: querySize.width * 0.4,
//               height: querySize.height * 0.055,
//               decoration: BoxDecoration(
//                 color: appColor,
//                 borderRadius: BorderRadius.circular(querySize.width * 0.08),
//               ),
//               child: Center(
//                 child: Text(
//                   'Pay Now',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                       fontFamily: 'Segoe',
//                       fontSize: querySize.height * 0.017),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       SizedBox(
//         height: querySize.height * 0.04,
//       ),
//     ],
//   );
// }
