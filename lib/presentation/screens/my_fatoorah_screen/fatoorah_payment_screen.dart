import 'package:flutter/material.dart';
import 'package:lenore/application/provider/cart_provider/cart_provider.dart';
import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
import 'package:lenore/core/constant.dart';

import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/MFUtils.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

// class CardPaymentScreen extends StatefulWidget {
//   final int orderId;
//   final double totalAmount;
//   final String token;
//   final BuildContext context;

//   const CardPaymentScreen({
//     required this.context,
//     required this.token,
//     required this.orderId,
//     required this.totalAmount,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CardPaymentScreenSate createState() => _CardPaymentScreenState();
// }

// class _CardPaymentScreenState extends State<CardPaymentScreen> {
//   late MFCardPaymentView mfCardView;
//   late MFInitiateSessionResponse sessionResponse;
//   bool isLoading = true;
//   bool isCardViewReady = true;
//   String? error; // Declaration of the error variable
//   bool saveCardOption = true; // Option to save card for future use

//   @override
//   void initState() {
//     super.initState();

//     // Add error handling for SDK initialization
//     try {
//       MFSDK.init(
//         // Use your API key here
//         "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
//         MFCountry.QATAR,
//         MFEnvironment.TEST,
//       );
//       debugPrint("MFSDK initialized successfully");
//     } catch (e) {
//       debugPrint("Error initializing MFSDK: $e");
//       showErrorDialog(
//           "Initialization Error", "Failed to initialize payment SDK: $e");
//       return;
//     }

//     initiateSession();
//   }

//   Future<void> initiateSession() async {
//     try {
//       // Add request configuration with customerIdentifier for saved cards
//       MFInitiateSessionRequest request = MFInitiateSessionRequest(
//           customerIdentifier: widget.orderId.toString(), saveToken: true);

//       debugPrint('Initiating session with request: $request');

//       final response = await MFSDK.initSession(request, MFLanguage.ENGLISH);

//       debugPrint("Session initiated successfully");
//       debugPrint("Session ID: ${response.sessionId}");

//       setState(() {
//         sessionResponse = response;
//       });

//       await loadCardView();

//       // Give time for the card view to load, then enable the UI
//       await Future.delayed(const Duration(seconds: 3));
//       if (mounted) {
//         setState(() => isCardViewReady = false);
//       }
//     } on MFError catch (e) {
//       // Handle MyFatoorah specific errors
//       debugPrint("MyFatoorah Error Code: ${e.code}");
//       debugPrint("MyFatoorah Error Message: ${e.message}");
//       showErrorDialog("Payment Error", "Error ${e.code}: ${e.message}");
//     } catch (e, stackTrace) {
//       // Handle other errors
//       debugPrint("Unexpected error during session initiation: $e");
//       debugPrint("Stack trace: $stackTrace");
//       showErrorDialog("System Error", "An unexpected error occurred: $e");
//     }
//   }

//   Future<void> loadCardView() async {
//     try {
//       if (!mounted) return;

//       mfCardView.load(
//         sessionResponse,
//         (result) {
//           if (result == null) {
//             debugPrint("Card view loaded successfully");
//           } else {
//             debugPrint("Card view info: $result");
//           }
//         },
//       );
//     } catch (e) {
//       debugPrint("Error loading card view: $e");
//       showErrorDialog("Card View Error", "Failed to load payment form: $e");
//     }
//   }

//   Future<void> verifyPaymentStatus(String invoiceId) async {
//     try {
//       var request = MFGetPaymentStatusRequest(
//         key: invoiceId,
//         keyType: "InvoiceId",
//       );

//       var response = await MFSDK.getPaymentStatus(request, "en");

//       if (!mounted) return;

//       if (response.invoiceStatus?.toLowerCase() == "paid") {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: true,
//           message: "Payment Successful\nOrder Placed",
//         );
//       } else {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: false,
//           message: "Payment Failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Status check error: $e");
//       if (!mounted) return;
//       navigateToResult(
//         invoiceId: invoiceId,
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     }
//   }

//   void navigateToResult(
//       {required bool isSuccess,
//       required String message,
//       required String invoiceId}) async {
//     if (!mounted) return;

//     debugPrint('Updating order status');
//     // Use your payment provider here
//     bool status = await Provider.of<PaymentProvider>(context, listen: false)
//         .updateOrderStatus(
//       token: widget.token,
//       orderId: widget.orderId.toString(),
//       invoiceId: invoiceId,
//     );

//     debugPrint('Order status update result: $status');

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(
//           message: message,
//           isSuccess: isSuccess,
//         ),
//       ),
//     );
//   }

//   void showError(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> payWithCard({String? savedCardToken}) async {
//     try {
//       setState(() => isLoading = true);

//       final executePaymentRequest = MFExecutePaymentRequest(
//         invoiceValue: widget.totalAmount,
//         customerReference: widget.orderId.toString(),
//       );
//       executePaymentRequest.sessionId = sessionResponse.sessionId;

//       String? invoiceId;
//       bool paymentCompleted = false;

//       if (savedCardToken != null) {
//         // Pay with saved card token
//         debugPrint("Using saved card token: $savedCardToken");

//         var directPaymentRequest = MFDirectPaymentRequest(
//           executePaymentRequest: executePaymentRequest,
//           token: savedCardToken,
//           card: null, // No need for card details when using a token
//           saveToken: true, // Save the token for future use
//         );

//         await MFSDK.executeDirectPayment(
//           directPaymentRequest,
//           MFLanguage.ENGLISH,
//           (String receivedInvoiceId) {
//             debugPrint("Payment callback received: $receivedInvoiceId");
//             invoiceId = receivedInvoiceId;
//             paymentCompleted = true;
//           },
//         );
//       } else {
//         // Pass saveToken parameter in initSession
//         // Create a new session with saveToken parameter
//         if (saveCardOption) {
//           debugPrint("Creating new session with saveToken=true");
//           try {
//             MFInitiateSessionRequest request = MFInitiateSessionRequest(
//                 customerIdentifier: widget.orderId.toString(), saveToken: true);

//             final response =
//                 await MFSDK.initSession(request, MFLanguage.ENGLISH);
//             setState(() {
//               sessionResponse = response;
//             });

//             // Reload card view with new session
//             mfCardView.load(
//               sessionResponse,
//               (result) {
//                 debugPrint("Card view reloaded for saved token");
//               },
//             );
//           } catch (e) {
//             debugPrint("Failed to create new session for saved token: $e");
//             // Continue with existing session if this fails
//           }
//         }

//         // Pay with new card
//         await mfCardView.pay(
//           executePaymentRequest,
//           MFLanguage.ENGLISH,
//           (String receivedInvoiceId) {
//             debugPrint("Payment callback received: $receivedInvoiceId");
//             invoiceId = receivedInvoiceId;
//             paymentCompleted = true;
//           },
//         ).catchError((error) {
//           if (error is MFError) {
//             throw error;
//           }
//           throw Exception("Payment failed - Please try again");
//         });
//       }

//       // Wait for payment callback with timeout
//       int attempts = 0;
//       const maxAttempts = 10;
//       while (!paymentCompleted && attempts < maxAttempts) {
//         await Future.delayed(const Duration(seconds: 1));
//         attempts++;
//       }

//       if (invoiceId != null) {
//         await verifyPaymentStatus(invoiceId!);
//       } else {
//         showError("Payment timeout - Please try again");
//       }
//     } on MFError catch (e) {
//       final errorMsg = e.message ?? '';
//       if (errorMsg.isNotEmpty && errorMsg.toLowerCase().contains('card')) {
//         showError(e.message ?? "Invalid card details");
//       } else {
//         navigateToResult(
//           invoiceId: '',
//           isSuccess: false,
//           message: "Payment verification failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Payment error: $e");
//       navigateToResult(
//         invoiceId: '',
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   void showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Define card view style
//     MFCardViewStyle cardViewStyle() {
//       MFCardViewStyle style = MFCardViewStyle();
//       style.cardHeight = 200;
//       style.savedCardText;
//       style.hideCardIcons = false;
//       style.input?.inputMargin = 5;
//       style.label?.display = true;
//       style.input?.fontFamily = MFFontFamily.Monaco;
//       style.label?.fontWeight = MFFontWeight.Heavy;
//       return style;
//     }

//     // Initialize card view in the build method
//     mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Payment"),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Amount information
//             Card(
//               elevation: 2,
//               margin: const EdgeInsets.only(bottom: 16),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Total Amount", style: TextStyle(fontSize: 16)),
//                     Text(
//                       "${widget.totalAmount.toStringAsFixed(2)} QAR",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: appColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Saved Cards Section - Only show if session is ready and has saved cards
//             if (!isCardViewReady &&
//                 sessionResponse.customerTokens != null &&
//                 sessionResponse.customerTokens!.isNotEmpty) ...[
//               const Text(
//                 "Saved Cards",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // List of saved cards
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: sessionResponse.customerTokens!.length,
//                 itemBuilder: (context, index) {
//                   final token = sessionResponse.customerTokens![index];
//                   // Get last 4 digits of card number
//                   final lastFourDigits = token.cardNumber.isNotEmpty
//                       ? token.cardNumber
//                       //  .substring(math.max(0, token.cardNumber.length - 4))
//                       : "****";

//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     child: ListTile(
//                       leading: Icon(
//                         Icons.credit_card,
//                         color: appColor,
//                       ),
//                       title: Text("Card ending with $lastFourDigits"),
//                       subtitle: Text(
//                         token.cardBrand.isNotEmpty
//                             ? token.cardBrand
//                             : "Credit/Debit Card",
//                         style: TextStyle(color: Colors.grey.shade600),
//                       ),
//                       trailing: ElevatedButton(
//                         onPressed: isLoading
//                             ? null
//                             : () => payWithCard(savedCardToken: token.token),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: appColor,
//                         ),
//                         child: isLoading
//                             ? const SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : const Text("Pay",
//                                 style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   );
//                 },
//               ),

//               const Divider(height: 32),

//               const Text(
//                 "Pay with a new card",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],

//             // Card view container - main form for entering card info
//             SizedBox(height: 200, child: mfCardView),

//             // Save card checkbox
//             // if (!isCardViewReady)
//             //   CheckboxListTile(
//             //     title: const Text("Save card for future payments"),
//             //     value: saveCardOption,
//             //     onChanged: (value) {
//             //       setState(() {
//             //         saveCardOption = value ?? true;
//             //       });
//             //     },
//             //     activeColor: appColor,
//             //     controlAffinity: ListTileControlAffinity.leading,
//             //   ),

//             // const SizedBox(height: 20),

//             // Pay button
//             ElevatedButton(
//               onPressed: isCardViewReady ? null : () => payWithCard(),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF00ACB3),
//                 minimumSize: const Size(double.infinity, 48),
//               ),
//               child: isCardViewReady
//                   ? const CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     )
//                   : const Text(
//                       "Pay with Card",
//                       style: TextStyle(color: Colors.white),
//                     ),
//             ),

//             // Error display
//             if (error != null) ...[
//               const SizedBox(height: 16),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.red.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   error!,
//                   style: TextStyle(color: Colors.red.shade800),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Result Screen for Payment Success or Failure
// class PaymentResultScreen extends StatelessWidget {
//   final String message;
//   final bool isSuccess;

//   const PaymentResultScreen({
//     required this.message,
//     required this.isSuccess,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: SizedBox(),
//         backgroundColor: Colors.white,
//         title: Text(
//           isSuccess ? "Payment Successful" : "Payment Failed",
//           style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 isSuccess ? Icons.check_circle : Icons.error,
//                 color: isSuccess ? Colors.green : Colors.red,
//                 size: 80,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate back to home screen
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isSuccess ? Colors.green : Colors.red,
//                 ),
//                 child: const Text("Go to Home"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// class CardPaymentScreen extends StatefulWidget {
//   final BuildContext context;
//   final int orderId;
//   final double totalAmount;
//   final String token;

//   const CardPaymentScreen({
//     required this.context,
//     required this.token,
//     required this.orderId,
//     required this.totalAmount,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CardPaymentScreenState createState() => _CardPaymentScreenState();
// }

// class _CardPaymentScreenState extends State<CardPaymentScreen> {
//   late MFCardPaymentView mfCardView;
//   late MFInitiateSessionResponse sessionResponse;
//   bool isLoading = true;
//   bool isCardViewReady = true;

//   @override
//   void initState() {
//     super.initState();

//     // Add error handling for SDK initialization
//     try {
//       MFSDK.init(
//         // Replace with your API key (this is a test key)
//         "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
//         MFCountry.QATAR, // Set your country
//         MFEnvironment.TEST,
//       );
//       debugPrint("MFSDK initialized successfully");
//     } catch (e) {
//       debugPrint("Error initializing MFSDK: $e");
//       showErrorDialog(
//           "Initialization Error", "Failed to initialize payment SDK: $e");
//       return;
//     }

//     initiateSession();
//   }

//   Future<void> initiateSession() async {
//     try {
//       // Add request configuration with customerIdentifier for saved cards (optional)
//       MFInitiateSessionRequest request = MFInitiateSessionRequest(
//           customerIdentifier: widget.orderId.toString());

//       debugPrint('Initiating session request: $request');

//       final response = await MFSDK.initSession(request, MFLanguage.ENGLISH);

//       debugPrint("Session initiated successfully");
//       debugPrint("Session ID: ${response.sessionId}");

//       setState(() {
//         sessionResponse = response;
//       });

//       await loadCardView();

//       // Give time for the card view to load, then update UI
//       await Future.delayed(const Duration(seconds: 3));
//       if (mounted) {
//         setState(() => isCardViewReady = false);
//       }
//     } on MFError catch (e) {
//       // Handle MyFatoorah specific errors
//       debugPrint("MyFatoorah Error Code: ${e.code}");
//       debugPrint("MyFatoorah Error Message: ${e.message}");
//       showErrorDialog("Payment Error", "Error ${e.code}: ${e.message}");
//     } catch (e, stackTrace) {
//       // Handle other errors
//       debugPrint("Unexpected error during session initiation: $e");
//       debugPrint("Stack trace: $stackTrace");
//       showErrorDialog("System Error", "An unexpected error occurred: $e");
//     }
//   }

//   Future<void> loadCardView() async {
//     try {
//       if (!mounted) return;

//       await mfCardView.load(
//         sessionResponse,
//         (bin) {
//           if (bin == null) {
//             debugPrint("Card view loaded successfully");
//           } else {
//             debugPrint("Card BIN: $bin");
//           }
//         },
//       );
//     } catch (e) {
//       debugPrint("Error loading card view: $e");
//       showErrorDialog("Card View Error", "Failed to load payment form: $e");
//     }
//   }

//   Future<void> verifyPaymentStatus(String invoiceId) async {
//     try {
//       var request = MFGetPaymentStatusRequest(
//         key: invoiceId,
//         keyType: MFKeyType.INVOICEID,
//       );

//       var response = await MFSDK.getPaymentStatus(request, MFLanguage.ENGLISH);

//       if (!mounted) return;

//       if (response.invoiceStatus?.toLowerCase() == "paid") {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: true,
//           message: "Payment Successful\nOrder Placed",
//         );
//       } else {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: false,
//           message: "Payment Failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Status check error: $e");
//       if (!mounted) return;
//       navigateToResult(
//         invoiceId: invoiceId,
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     }
//   }

//   void navigateToResult(
//       {required bool isSuccess,
//       required String message,
//       required String invoiceId}) async {
//     if (!mounted) return;

//     debugPrint("Updating order status");
//     bool status = await Provider.of<PaymentProvider>(context, listen: false)
//         .updateOrderStatus(
//       token: widget.token,
//       orderId: widget.orderId.toString(),
//       invoiceId: invoiceId,
//     );

//     debugPrint("Order status update result: $status");

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(
//           message: message,
//           isSuccess: isSuccess,
//         ),
//       ),
//     );
//   }

//   void showError(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> payWithCard() async {
//     try {
//       if (sessionResponse == null) {
//         showError("Payment not initialized");
//         return;
//       }

//       setState(() => isLoading = true);

//       final executePaymentRequest = MFExecutePaymentRequest(
//         invoiceValue: widget.totalAmount,
//         customerReference: widget.orderId.toString(),
//       );
//       executePaymentRequest.sessionId = sessionResponse.sessionId;

//       String? invoiceId;
//       bool paymentCompleted = false;

//       await mfCardView.pay(
//         executePaymentRequest,
//         MFLanguage.ENGLISH,
//         (String receivedInvoiceId) {
//           debugPrint("Payment callback received: $receivedInvoiceId");
//           invoiceId = receivedInvoiceId;
//           paymentCompleted = true;
//         },
//       );

//       // Wait for payment callback to complete
//       int attempts = 0;
//       while (!paymentCompleted && attempts < 10) {
//         await Future.delayed(const Duration(seconds: 1));
//         attempts++;
//       }

//       if (invoiceId != null) {
//         await verifyPaymentStatus(invoiceId!);
//       } else {
//         showError("Payment timeout - Please try again");
//       }
//     } on MFError catch (e) {
//       final errorMsg = e.message ?? '';
//       if (errorMsg.isNotEmpty && errorMsg.toLowerCase().contains('card')) {
//         showError(e.message ?? "Invalid card details");
//       } else {
//         navigateToResult(
//           invoiceId: '',
//           isSuccess: false,
//           message: "Payment verification failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Payment error: $e");
//       navigateToResult(
//         invoiceId: '',
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   void showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Define card view style
//     MFCardViewStyle cardViewStyle() {
//       MFCardViewStyle style = MFCardViewStyle();
//       style.cardHeight = 200;
//       style.hideCardIcons = false;
//       style.input?.inputMargin = 5;
//       style.label?.display = true;
//       style.input?.fontFamily = MFFontFamily.Monaco;
//       style.label?.fontWeight = MFFontWeight.Heavy;
//       return style;
//     }

//     // Initialize card view - MUST be done in build method
//     mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Payment"),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Card view container
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: mfCardView,
//             ),

//             const SizedBox(height: 20),

//             // Test card information
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Text(
//                 'For testing, use card number: 5454545454545454, exp: any future date, CVV: any 3 digits',
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 12,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Pay button
//             ElevatedButton(
//               onPressed: isCardViewReady ? null : payWithCard,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF00ACB3),
//                 minimumSize: const Size(double.infinity, 48),
//               ),
//               child: isCardViewReady
//                   ? const CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     )
//                   : const Text(
//                       "Pay with Card",
//                       style: TextStyle(color: Colors.white),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentResultScreen extends StatelessWidget {
//   final String message;
//   final bool isSuccess;

//   const PaymentResultScreen({
//     required this.message,
//     required this.isSuccess,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: SizedBox(),
//         backgroundColor: Colors.white,
//         title: Text(
//           isSuccess ? "Payment Successful" : "Payment Failed",
//           style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 isSuccess ? Icons.check_circle : Icons.error,
//                 color: isSuccess ? Colors.green : Colors.red,
//                 size: 80,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate back to home or any other screen
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isSuccess ? Colors.green : Colors.red,
//                 ),
//                 child: const Text("Go to Home"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//------------------------------------------claude ai----------------------
// class CardPaymentScreen extends StatefulWidget {
//   final BuildContext context;
//   final int orderId;
//   final double totalAmount;
//   final String token;

//   const CardPaymentScreen({
//     required this.context,
//     required this.token,
//     required this.orderId,
//     required this.totalAmount,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CardPaymentScreenState createState() => _CardPaymentScreenState();
// }

// class _CardPaymentScreenState extends State<CardPaymentScreen> {
//   late MFCardPaymentView mfCardView;
//   bool isLoading = false;
//   String? sessionId;
//   String? error;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize MyFatoorah SDK
//     _initMyFatoorah();
//   }

//   // Initialize the MyFatoorah SDK
//   void _initMyFatoorah() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       // Replace with your actual API key from MyFatoorah dashboard
//       // Use MFEnvironment.LIVE for production
//       MFSDK.init(
//           "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
//           MFCountry.KUWAIT,
//           MFEnvironment.TEST);

//       // Set up the action bar (optional)
//       _setupActionBar();

//       // Start the payment session
//       await _initSession();
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Set up the MyFatoorah action bar (optional)
//   void _setupActionBar() {
//     MFSDK.setUpActionBar(
//       toolBarTitle: 'Payment',
//       toolBarTitleColor: '#FFFFFF',
//       toolBarBackgroundColor: '#00ACB3',
//       isShowToolBar: true,
//     );
//   }

//   // Initialize the payment session
//   Future<void> _initSession() async {
//     // If you want to use saved card option, pass a customer identifier
//     // MFInitiateSessionRequest initiateSessionRequest = MFInitiateSessionRequest("customer_${widget.orderId}");

//     // For regular payments without saved cards
//     MFInitiateSessionRequest initiateSessionRequest =
//         MFInitiateSessionRequest();

//     try {
//       await MFSDK
//           .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
//           .then((value) => _loadEmbeddedPayment(value))
//           .catchError((error) {
//         setState(() {
//           this.error = error.message;
//         });
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//       });
//     }
//   }

//   // Load the embedded payment component
//   void _loadEmbeddedPayment(MFInitiateSessionResponse session) {
//     sessionId = session.sessionId;
//     _loadCardView(session);
//   }

//   // Load the card view component
//   void _loadCardView(MFInitiateSessionResponse session) {
//     mfCardView.load(session, (bin) {
//       debugPrint("Card BIN: $bin");
//     });
//   }

//   // Execute payment when the user clicks the pay button
//   Future<void> _pay() async {
//     if (sessionId == null) {
//       setState(() {
//         error = "Session not initialized. Please try again.";
//       });
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       error = null;
//     });

//     try {
//       var executePaymentRequest =
//           MFExecutePaymentRequest(invoiceValue: widget.totalAmount);
//       executePaymentRequest.sessionId = sessionId;

//       await mfCardView.pay(executePaymentRequest, MFLanguage.ENGLISH,
//           (invoiceId) {
//         debugPrint("Invoice ID: $invoiceId");
//         // Save the invoice ID or perform any other action
//         _onPaymentSuccess(invoiceId);
//       }).then((value) {
//         debugPrint("Payment result: ${value.toString()}");
//       }).catchError((error) {
//         setState(() {
//           this.error = error.message;
//           isLoading = false;
//         });
//       });
//     } catch (e) {
//       setState(() {
//         error = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   // Handle successful payment
//   void _onPaymentSuccess(String invoiceId) {
//     // Update payment status in your backend
//     Provider.of<PaymentProvider>(context, listen: false)
//         .updateOrderStatus(
//       orderId: widget.orderId.toString(),
//       invoiceId: invoiceId,
//       token: widget.token,
//     )
//         .then((_) {
//       // Navigate to success screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PaymentResultScreen(
//             message: "Payment Successful!",
//             isSuccess: true,
//             invoiceId: invoiceId,
//             orderId: widget.orderId.toString(),
//           ),
//         ),
//       );
//     }).catchError((error) {
//       setState(() {
//         this.error =
//             "Payment was processed but failed to update status: ${error.toString()}";
//         isLoading = false;
//       });
//     });
//   }

//   // Custom style for card view
//   MFCardViewStyle _cardViewStyle() {
//     MFCardViewStyle cardViewStyle = MFCardViewStyle();
//     cardViewStyle.cardHeight = 200;
//     cardViewStyle.hideCardIcons = false;
//     cardViewStyle.input?.inputMargin = 5;
//     cardViewStyle.label?.display = true;
//     cardViewStyle.input?.fontFamily = MFFontFamily.Arial;
//     cardViewStyle.label?.fontWeight = MFFontWeight.Normal;
//     return cardViewStyle;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Initialize card view with style
//     mfCardView = MFCardPaymentView(cardViewStyle: _cardViewStyle());

//     final querySize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Card Payment'),
//         backgroundColor: const Color(0xFF00ACB3),
//         foregroundColor: Colors.white,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SafeArea(
//         child: isLoading && sessionId == null
//             ? const Center(
//                 child: CircularProgressIndicator(
//                   color: Color(0xFF00ACB3),
//                 ),
//               )
//             : error != null && sessionId == null
//                 ? Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.error_outline,
//                             color: Colors.red,
//                             size: 48,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Failed to initialize payment',
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             error!,
//                             style: Theme.of(context).textTheme.bodyMedium,
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 24),
//                           ElevatedButton(
//                             onPressed: _initSession,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00ACB3),
//                               foregroundColor: Colors.white,
//                             ),
//                             child: const Text('Try Again'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         // Order summary card
//                         Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Order Summary',
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 ),
//                                 const SizedBox(height: 8),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text('Order ID:'),
//                                     Text('#${widget.orderId}'),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text('Total Amount:'),
//                                     Text(
//                                       '${widget.totalAmount.toStringAsFixed(2)} KWD',
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // Card payment view
//                         Text(
//                           'Enter Card Details',
//                           style: Theme.of(context).textTheme.bodyMedium,
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           height: 200,
//                           child: mfCardView,
//                         ),

//                         if (error != null) ...[
//                           const SizedBox(height: 16),
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.red.shade100,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               error!,
//                               style: TextStyle(
//                                 color: Colors.red.shade800,
//                               ),
//                             ),
//                           ),
//                         ],

//                         const Spacer(),

//                         // Pay button
//                         SizedBox(
//                           width: double.infinity,
//                           height: querySize.height * (48 / 812),
//                           child: ElevatedButton(
//                             onPressed: isLoading ? null : _pay,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00ACB3),
//                               disabledBackgroundColor:
//                                   const Color(0xFF00ACB3).withOpacity(0.5),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     querySize.width * 0.045),
//                               ),
//                             ),
//                             child: isLoading
//                                 ? const SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                 : const Text(
//                                     'Pay Now',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                           ),
//                         ),

//                         const SizedBox(height: 16),
//                       ],
//                     ),
//                   ),
//       ),
//     );
//   }
// }

// // Payment Result Screen
// class PaymentResultScreen extends StatelessWidget {
//   final String message;
//   final bool isSuccess;
//   final String? invoiceId;
//   final String? orderId;

//   const PaymentResultScreen({
//     required this.message,
//     required this.isSuccess,
//     this.invoiceId,
//     this.orderId,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment Result'),
//         backgroundColor: const Color(0xFF00ACB3),
//         foregroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Icon(
//                 isSuccess ? Icons.check_circle_outline : Icons.error_outline,
//                 color: isSuccess ? Colors.green : Colors.red,
//                 size: 80,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 message,
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//               if (isSuccess && invoiceId != null) ...[
//                 const SizedBox(height: 8),
//                 Text(
//                   'Invoice ID: $invoiceId',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ],
//               if (isSuccess && orderId != null) ...[
//                 const SizedBox(height: 8),
//                 Text(
//                   'Order ID: $orderId',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ],
//               const SizedBox(height: 40),
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Navigate back to home or orders screen
//                     Navigator.of(context).popUntil((route) => route.isFirst);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF00ACB3),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     'Back to Home',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//----------------------------deep seek code---------------------------------------------------------------------
// class CardPaymentScreen extends StatefulWidget {
//   final int orderId;
//   final double totalAmount;
//   final String token;
//   final BuildContext context;

//   const CardPaymentScreen({
//     required this.context,
//     required this.token,
//     required this.orderId,
//     required this.totalAmount,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CardPaymentScreenState createState() => _CardPaymentScreenState();
// }

// class _CardPaymentScreenState extends State<CardPaymentScreen> {
//   late MFCardPaymentView mfCardView;
//   late MFInitiateSessionResponse sessionResponse;
//   bool isLoading = true;
//   bool isCardViewReady = false;
//   bool saveCard = false; // Toggle for saving card

//   @override
//   void initState() {
//     super.initState();
//     initializeSDK();
//   }

//   void initializeSDK() async {
//     try {
//       await MFSDK.init(
//         // "UIgbtb_fyCSnHeP76m6roKj04tCQ3z5n_hMQ-haAeA_n-gAWJeAmTZ-Lkpi3kfrycTeDZCvUCRTRfgTA669XkXUf6fdh86DGTC9a3Z2NOgA6fkkwy4qII1MQsc8vGkMJfP-B5DAuwNLg1xmTNOufi6pkubg3AAlVTgfgE7MEifbKT-CiBjMiznYgmsYv99HMtKHZYubufuSnHOPo4AYi03gbkPSyUQ37hsuVBWleTrqMsHDE7pJ5jPHJojeP1wiRVXzbXBlLTxZ_zzNMUV5VLMJRSukVX5COwYbwca1dafj_q_bFV6KHO7v1Qwc6ydk1HSUNmnU2PBT_Bq4-rCuY6O2nCu4p1NNhFilMEjOlk4HHs-JNWsZAIRvYJt-kXjI2Y3IO8YP8mgVFP5A5n97ZkNOTenPWPpAojvCXA3AjYEjTB_4IHq20M0bcD5-hnDT9IRMlaPMA8cR1S27sXQO97mrmqC60t3DtOM2RSNcA-5uHaxQpSCNRGPo1D3WO_qEiXuARM4hsgiRxu9Y_aCKJtnLsfqxxtslx1IahDnyrkUhyxJ9UCe9Q6OLwfpPYIqha1OemunYUuKe6e_Y5WoV3Kz9NdvyXrmNrDEYPHW9ePIrg9YNXuUhTM764VcwSHPPMnJqg3fwG6hhGhYUFl-mJTCiOiucP_gI3J_TUEhHkAyA7kYxk", // Make sure this is the correct API key for your environment
//         /*test */ "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",

//         MFCountry.QATAR,
//         MFEnvironment
//             .TEST, // Use TEST for debugging, switch to LIVE for production
//       );
//       debugPrint("MFSDK initialized successfully");
//       await initiateSession();
//     } catch (e) {
//       debugPrint("Error initializing MFSDK: $e");
//       showErrorDialog(
//           "Initialization Error", "Failed to initialize payment SDK: $e");
//     }
//   }

//   Future<void> initiateSession() async {
//     try {
//       MFInitiateSessionRequest request = MFInitiateSessionRequest(
//         customerIdentifier: widget.orderId.toString(),
//       );

//       final response = await MFSDK.initSession(request, MFLanguage.ENGLISH);
//       debugPrint("Session initiated successfully");
//       debugPrint("Session ID: ${response.sessionId}");

//       setState(() {
//         sessionResponse = response;
//       });

//       await loadCardView();
//     } on MFError catch (e) {
//       debugPrint("MyFatoorah Error Code: ${e.code}");
//       debugPrint("MyFatoorah Error Message: ${e.message}");
//       showErrorDialog("Payment Error", "Error ${e.code}: ${e.message}");
//     } catch (e) {
//       debugPrint("Unexpected error during session initiation: $e");
//       showErrorDialog("System Error", "An unexpected error occurred: $e");
//     }
//   }

//   Future<void> loadCardView() async {
//     try {
//       if (!mounted) return;

//       await mfCardView.load(
//         sessionResponse,
//         (error) {
//           if (error == null) {
//             setState(() => isCardViewReady = true);
//             debugPrint("Card view loaded successfully");
//           } else {
//             debugPrint("Error loading card view: ${error.toString()}");
//             showErrorDialog("Card View Error", error.toString());
//           }
//         },
//       );
//     } catch (e) {
//       debugPrint("Error loading card view: $e");
//       showErrorDialog("Card View Error", "Failed to load payment form: $e");
//     }
//   }

//   Future<void> payWithCard() async {
//     try {
//       if (sessionResponse == null) {
//         showError("Payment not initialized");
//         return;
//       }

//       setState(() => isLoading = true);

//       final executePaymentRequest = MFExecutePaymentRequest(
//         invoiceValue: widget.totalAmount,
//         sessionId: sessionResponse.sessionId,
//       );

//       String? invoiceId;
//       bool paymentCompleted = false;

//       await mfCardView.pay(
//         executePaymentRequest,
//         MFLanguage.ENGLISH,
//         (String receivedInvoiceId) {
//           debugPrint("Payment callback received: $receivedInvoiceId");
//           invoiceId = receivedInvoiceId;
//           paymentCompleted = true;
//         },
//       ).catchError((error) {
//         if (error is MFError) {
//           throw error;
//         }
//         throw Exception("Payment failed - Please try again");
//       });

//       while (!paymentCompleted) {
//         await Future.delayed(const Duration(seconds: 3));
//       }

//       if (invoiceId != null) {
//         await verifyPaymentStatus(invoiceId!);
//       }
//     } on MFError catch (e) {
//       final errorMsg = e.message ?? '';
//       if (errorMsg.isNotEmpty && errorMsg.toLowerCase().contains('card')) {
//         showError(e.message ?? "Invalid card details");
//       } else {
//         navigateToResult(
//           invoiceId: '',
//           isSuccess: false,
//           message: "Payment verification failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Payment error: $e");
//       navigateToResult(
//         invoiceId: '',
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   Future<void> payWithApplePay() async {
//     try {
//       setState(() => isLoading = true);

//       final executePaymentRequest = MFExecutePaymentRequest(
//         invoiceValue: widget.totalAmount,
//         sessionId: sessionResponse.sessionId,
//       );

//       final response = await MFSDK.applePayPayment(
//         executePaymentRequest,
//         MFLanguage.ENGLISH,
//         (String invoiceId) {
//           debugPrint("Apple Pay callback received: $invoiceId");
//           verifyPaymentStatus(invoiceId);
//         },
//       );

//       if (response.invoiceId != null) {
//         await verifyPaymentStatus(response.invoiceId.toString());
//       }
//     } on MFError catch (e) {
//       debugPrint("Apple Pay Error: ${e.message}");
//       showError("Apple Pay Error: ${e.message}");
//     } catch (e) {
//       debugPrint("Unexpected error during Apple Pay: $e");
//       showError("Apple Pay failed - Please try again");
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   Future<void> payWithGooglePay() async {
//     try {
//       setState(() => isLoading = true);

//       final googlePayRequest = MFGooglePayRequest(
//         totalPrice: widget.totalAmount.toString(),
//         currencyIso: "QAR", // Replace with your currency code
//         countryCode: "QA", // Replace with your country code
//         merchantId:
//             "YOUR_MERCHANT_ID", // Replace with your Google Pay merchant ID
//         merchantName: "Your Merchant Name",
//       );

//       final response = await MFSDK.setupGooglePayHelper(
//         sessionResponse.sessionId!,
//         googlePayRequest,
//         (String invoiceId) {
//           debugPrint("Google Pay callback received: $invoiceId");
//           verifyPaymentStatus(invoiceId);
//         },
//       );

//       if (response.invoiceId != null) {
//         await verifyPaymentStatus(response.invoiceId.toString());
//       }
//     } on MFError catch (e) {
//       debugPrint("Google Pay Error: ${e.message}");
//       showError("Google Pay Error: ${e.message}");
//     } catch (e) {
//       debugPrint("Unexpected error during Google Pay: $e");
//       showError("Google Pay failed - Please try again");
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   Future<void> verifyPaymentStatus(String invoiceId) async {
//     try {
//       var request = MFGetPaymentStatusRequest(
//         key: invoiceId,
//         keyType: "InvoiceId",
//       );

//       var response = await MFSDK.getPaymentStatus(request, "en");

//       if (!mounted) return;

//       if (response.invoiceStatus?.toLowerCase() == "paid") {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: true,
//           message: "Payment Successful\nOrder Placed",
//         );
//       } else {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: false,
//           message: "Payment Failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Status check error: $e");
//       if (!mounted) return;
//       navigateToResult(
//         invoiceId: invoiceId,
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     }
//   }

//   void navigateToResult({
//     required bool isSuccess,
//     required String message,
//     required String invoiceId,
//   }) async {
//     if (!mounted) return;

//     bool status = await Provider.of<PaymentProvider>(context, listen: false)
//         .updateOrderStatus(
//       token: widget.token,
//       orderId: widget.orderId.toString(),
//       invoiceId: invoiceId,
//     );

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(
//           message: message,
//           isSuccess: isSuccess,
//         ),
//       ),
//     );
//   }

//   void showError(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     MFCardViewStyle cardViewStyle() {
//       MFCardViewStyle style = MFCardViewStyle();
//       style.cardHeight = 200;
//       style.hideCardIcons = false;
//       style.input?.inputMargin = 5;
//       style.label?.display = true;
//       style.input?.fontFamily = MFFontFamily.Monaco;
//       style.label?.fontWeight = MFFontWeight.Heavy;
//       return style;
//     }

//     mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Payment"),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             SizedBox(height: 200, child: mfCardView),
//             const SizedBox(height: 20),
//             // Save Card Toggle
//             Row(
//               children: [
//                 Checkbox(
//                   value: saveCard,
//                   onChanged: (value) {
//                     setState(() {
//                       saveCard = value ?? false;
//                     });
//                   },
//                 ),
//                 const Text("Save Card for Future Payments"),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: payWithCard,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//               child: isCardViewReady
//                   ? CircularProgressIndicator()
//                   : const Text("Pay with Card",
//                       style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 20),
//             // Apple Pay Button
//             ElevatedButton(
//               onPressed: payWithApplePay,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
//               child: const Text("Pay with Apple Pay",
//                   style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 10),
//             // Google Pay Button
//             ElevatedButton(
//               onPressed: payWithGooglePay,
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//               child: const Text("Pay with Google Pay",
//                   style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentResultScreen extends StatelessWidget {
//   final String message;
//   final bool isSuccess;

//   const PaymentResultScreen({
//     required this.message,
//     required this.isSuccess,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: SizedBox(),
//         backgroundColor: Colors.white,
//         title: Text(
//           isSuccess ? "Payment Successful" : "Payment Failed",
//           style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 isSuccess ? Icons.check_circle : Icons.error,
//                 color: isSuccess ? Colors.green : Colors.red,
//                 size: 80,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 message,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 18),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: isSuccess ? Colors.green : Colors.red,
//                 ),
//                 child: const Text("Go to Home"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//------------------------------------------my code ---------------------------------
// class CardPaymentScreen extends StatefulWidget {
//   final int orderId;
//   final double totalAmount;
//   final String token;
//   final BuildContext context;

//   const CardPaymentScreen(
//       {required this.context,
//       required this.token,
//       required this.orderId,
//       required this.totalAmount,
//       Key? key})
//       : super(key: key);

//   @override
//   _CardPaymentScreenState createState() => _CardPaymentScreenState();
// }

// class _CardPaymentScreenState extends State<CardPaymentScreen> {
//   late MFCardPaymentView mfCardView;
//   late MFInitiateSessionResponse sessionResponse;
//   bool isLoading = true;
//   bool isCardViewReady = true;
//   @override
//   void initState() {
//     super.initState();

//     // Add error handling for SDK initialization
//     try {
//       MFSDK.init(
//         /*test */ "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
//         // "UIgbtb_fyCSnHeP76m6roKj04tCQ3z5n_hMQ-haAeA_n-gAWJeAmTZ-Lkpi3kfrycTeDZCvUCRTRfgTA669XkXUf6fdh86DGTC9a3Z2NOgA6fkkwy4qII1MQsc8vGkMJfP-B5DAuwNLg1xmTNOufi6pkubg3AAlVTgfgE7MEifbKT-CiBjMiznYgmsYv99HMtKHZYubufuSnHOPo4AYi03gbkPSyUQ37hsuVBWleTrqMsHDE7pJ5jPHJojeP1wiRVXzbXBlLTxZ_zzNMUV5VLMJRSukVX5COwYbwca1dafj_q_bFV6KHO7v1Qwc6ydk1HSUNmnU2PBT_Bq4-rCuY6O2nCu4p1NNhFilMEjOlk4HHs-JNWsZAIRvYJt-kXjI2Y3IO8YP8mgVFP5A5n97ZkNOTenPWPpAojvCXA3AjYEjTB_4IHq20M0bcD5-hnDT9IRMlaPMA8cR1S27sXQO97mrmqC60t3DtOM2RSNcA-5uHaxQpSCNRGPo1D3WO_qEiXuARM4hsgiRxu9Y_aCKJtnLsfqxxtslx1IahDnyrkUhyxJ9UCe9Q6OLwfpPYIqha1OemunYUuKe6e_Y5WoV3Kz9NdvyXrmNrDEYPHW9ePIrg9YNXuUhTM764VcwSHPPMnJqg3fwG6hhGhYUFl-mJTCiOiucP_gI3J_TUEhHkAyA7kYxk", // Make sure this is the correct API key for your environment
//         MFCountry.QATAR,
//         MFEnvironment.TEST, // Consider using .TEST first for debugging
//       );
//       debugPrint("MFSDK initialized successfully");
//     } catch (e) {
//       debugPrint("Error initializing MFSDK: $e");
//       showErrorDialog(
//           "Initialization Error", "Failed to initialize payment SDK: $e");
//       return;
//     }

//     initiateSession();
//   }

//   Future<void> initiateSession() async {
//     try {
//       // Add request configuration
//       MFInitiateSessionRequest request = MFInitiateSessionRequest(
//           customerIdentifier: widget.orderId.toString());
//       print('11111111111111111');
//       print('------$request');
//       // Optional: Add any required configuration
//       // request.customerEmail = "customer@example.com";
//       // request. = "+97412345678";

//       final response = await MFSDK.initSession(request, MFLanguage.ENGLISH);
//       print('2222222222222222222222');
//       debugPrint("Session initiated successfully");
//       debugPrint("Session ID: ${response.sessionId}");

//       setState(() {
//         sessionResponse = response;
//       });

//       await loadCardView();
//       await Future.delayed(const Duration(seconds: 3));
//       if (mounted) {
//         setState(() => isCardViewReady = false);
//       }
//     } on MFError catch (e) {
//       // Handle MyFatoorah specific errors
//       debugPrint("MyFatoorah Error Code: ${e.code}");
//       debugPrint("MyFatoorah Error Message: ${e.message}");
//       showErrorDialog("Payment Error", "Error ${e.code}: ${e.message}");
//     } catch (e, stackTrace) {
//       // Handle other errors
//       debugPrint("Unexpected error during session initiation: $e");
//       debugPrint("Stack trace: $stackTrace");
//       showErrorDialog("System Error", "An unexpected error occurred: $e");
//     }
//   }

//   // Future<void> loadCardView() async {
//   //   try {
//   //     if (!mounted) return;
//   //     await mfCardView.load(
//   //       sessionResponse,
//   //       (error) {
//   //         if (mounted) {
//   //           setState(() => isCardViewReady = true);
//   //         }
//   //       },
//   //     );
//   //   } catch (e) {
//   //     showErrorDialog("Card View Error", "Failed to load payment form: $e");
//   //   }
//   // }

//   Future<void> loadCardView() async {
//     try {
//       if (!mounted) return;

//       await mfCardView.load(
//         sessionResponse,
//         (error) {
//           if (error == null) {
//             // setState(() => isCardViewReady = true);
//             debugPrint("Card view loaded successfully");
//           } else {
//             debugPrint("Error loading card view: ${error.toString()}");
//             // showErrorDialog("Card View Error", error.toString());
//           }
//         },
//       );
//       // setState(() => isCardViewReady = true);
//     } catch (e) {
//       debugPrint("Error loading card view: $e");
//       showErrorDialog("Card View Error", "Failed to load payment form: $e");
//     }
//   }

//   Future<void> verifyPaymentStatus(String invoiceId) async {
//     try {
//       var request = MFGetPaymentStatusRequest(
//         key: invoiceId,
//         keyType: "InvoiceId",
//       );

//       var response = await MFSDK.getPaymentStatus(request, "en");

//       if (!mounted) return;

//       if (response.invoiceStatus?.toLowerCase() == "paid") {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: true,
//           message: "Payment Successful\nOrder Placed",
//         );
//       } else {
//         navigateToResult(
//           invoiceId: invoiceId,
//           isSuccess: false,
//           message: "Payment Failed",
//         );
//       }
//     } catch (e) {
//       debugPrint("Status check error: $e");
//       if (!mounted) return;
//       navigateToResult(
//         invoiceId: invoiceId,
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//     }
//   }

//   void navigateToResult(
//       {required bool isSuccess,
//       required String message,
//       required String invoiceId}) async {
//     if (!mounted) return;
//     print('-------------11-----');
//     bool status = await Provider.of<PaymentProvider>(context, listen: false)
//         .updateOrderStatus(
//       token: widget.token,
//       orderId: widget.orderId.toString(),
//       invoiceId: invoiceId,
//     );
//     print('-------------22$status-----');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(
//           message: message,
//           isSuccess: isSuccess,
//         ),
//       ),
//     );
//   }

//   void showError(String message) {
//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   Future<void> payWithCard() async {
//     try {
//       if (sessionResponse == null) {
//         showError("Payment not initialized");
//         return;
//       }

//       setState(() => isLoading = true);

//       final executePaymentRequest = MFExecutePaymentRequest(
//           invoiceValue: widget.totalAmount,
//           customerReference: widget.orderId.toString());
//       executePaymentRequest.sessionId = sessionResponse!.sessionId;

//       String? invoiceId;
//       bool paymentCompleted = false;

//       await mfCardView.pay(
//         executePaymentRequest,
//         MFLanguage.ENGLISH,
//         (String receivedInvoiceId) {
//           debugPrint("Payment callback received: $receivedInvoiceId");
//           invoiceId = receivedInvoiceId;
//           paymentCompleted = true;
//         },
//       ).catchError((error) {
//         if (error is MFError) {
//           throw error;
//         }
//         throw Exception("Payment failed - Please try again");
//       });

//       while (!paymentCompleted) {
//         await Future.delayed(const Duration(seconds: 3));
//       }

//       if (invoiceId != null) {
//         await verifyPaymentStatus(invoiceId!);
//       }
//     } on MFError catch (e) {
//       final errorMsg = e.message ?? '';
//       if (errorMsg.isNotEmpty && errorMsg.toLowerCase().contains('card')) {
//         showError(e.message ?? "Invalid card details");
//       } else {
//         navigateToResult(
//           invoiceId: '',
//           isSuccess: false,
//           message: "Payment verification failed",
//         );
//         // showError(e.message ?? "Payment failed");
//       }
//     } catch (e) {
//       debugPrint("Payment error: $e");
//       navigateToResult(
//         invoiceId: '',
//         isSuccess: false,
//         message: "Payment verification failed",
//       );
//       //showError("Payment failed - Please try again");
//     } finally {
//       if (mounted) setState(() => isLoading = false);
//     }
//   }

//   /// Navigates to the result screen
//   void navigateToResultScreen(String message, {required bool isSuccess}) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PaymentResultScreen(
//           message: message,
//           isSuccess: isSuccess,
//         ),
//       ),
//     );
//   }

//   /// Displays an error dialog
//   void showErrorDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Define card view style
//     MFCardViewStyle cardViewStyle() {
//       MFCardViewStyle style = MFCardViewStyle();
//       style.cardHeight = 200;
//       style.hideCardIcons = false;
//       style.input?.inputMargin = 5;
//       style.label?.display = true;
//       style.input?.fontFamily = MFFontFamily.Monaco;
//       style.label?.fontWeight = MFFontWeight.Heavy;
//       return style;
//     }

//     // Initialize card view
//     mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Payment"),
//         backgroundColor: Colors.white,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             SizedBox(height: 200, child: mfCardView),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: payWithCard,
//               style: ElevatedButton.styleFrom(backgroundColor: appColor),
//               child: isCardViewReady
//                   ? CircularProgressIndicator()
//                   : const Text("Pay with Card",
//                       style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // /// Result Screen for Payment Success or Failure
class PaymentResultScreen extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final String orderId;
  // final String token;
  // final int invoiceId;
  const PaymentResultScreen({
    // required this.invoiceId,
    // required this.token,
    required this.orderId,
    required this.message,
    required this.isSuccess,
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isSuccess) {
      Provider.of<CartProvider>(context, listen: false).clearCart();
    }
    // await Provider.of<PaymentProvider>(context, listen: false)
    //     .updateOrderStatus(
    //   token: widget.token,
    //   orderId: widget.orderId.toString(),
    //   invoiceId: widget.invoiceId.toString(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        title: Text(
          widget.isSuccess ? "Payment Successful" : "Payment Failed",
          style: TextStyle(color: widget.isSuccess ? Colors.green : Colors.red),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.isSuccess ? Icons.check_circle : Icons.error,
                color: widget.isSuccess ? Colors.green : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                widget.isSuccess
                    ? "Order Id: ${widget.orderId}"
                    : widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  //   (route) =>
                  //       false, // This predicate removes all previous routes
                  // );
                  // Navigate back to home or any other screen
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isSuccess ? Colors.green : Colors.red,
                ),
                child: const Text("Go to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardPaymentScreen extends StatefulWidget {
  final int orderId;
  final double totalAmount;
  final String token;
  final BuildContext context;
  final String customerIdentifier;

  const CardPaymentScreen(
      {required this.context,
      required this.customerIdentifier,
      required this.token,
      required this.orderId,
      required this.totalAmount,
      Key? key})
      : super(key: key);

  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  String? _response = '';
  MFInitiateSessionResponse? session;

  List<MFPaymentMethod> paymentMethods = [];
  List<bool> isSelected = [];
  int selectedPaymentMethodIndex = -1;

  // String amount = "5.00";
  bool visibilityObs = false;
  late MFCardPaymentView mfCardView;
  late MFApplePayButton mfApplePayButton;
  late MFGooglePayButton mfGooglePayButton;

  @override
  void initState() {
    super.initState();
    initiate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initiate() async {
    // if (Config.testAPIKey.isEmpty) {
    //   setState(() {});
    //   return;
    // }

    await MFSDK.init(
        "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
        MFCountry.KUWAIT,
        MFEnvironment.TEST);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initiateSessionForCardView();
      await initiateSessionForGooglePay();
      await initiatePayment();
      // await initiateSession();
    });
  }

  log(Object object) {
    var json = const JsonEncoder.withIndent('  ').convert(object);
    setState(() {
      debugPrint(json);
      _response = json;
    });
  }

  initiatePayment() async {
    var request = MFInitiatePaymentRequest(
        invoiceAmount: widget.totalAmount,
        currencyIso: MFCurrencyISO.KUWAIT_KWD);

    await MFSDK
        .initiatePayment(request, MFLanguage.ENGLISH)
        .then((value) => {
              log(value),
              paymentMethods.addAll(value.paymentMethods!),
              for (int i = 0; i < paymentMethods.length; i++)
                isSelected.add(false)
            })
        .catchError((error) => {log(error.message)});
  }

  executeRegularPayment(int paymentMethodId) async {
    var request = MFExecutePaymentRequest(
        paymentMethodId: paymentMethodId, invoiceValue: widget.totalAmount);
    request.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;

    // var recurring = MFRecurringModel();
    // recurring.intervalDays = 10;
    // recurring.recurringType = MFRecurringType.Custom;
    // recurring.iteration = 2;
    // request.recurringModel = recurring;

    await MFSDK
        .executePayment(request, MFLanguage.ENGLISH, (invoiceId) {
          log(invoiceId);
        })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods[index].isDirectPayment!;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else {
        isSelected[i] = false;
      }
    }
  }

  executePayment() {
    if (selectedPaymentMethodIndex == -1) {
      setState(() {
        _response = "Please select payment method first";
      });
    } else {
      if (widget.totalAmount.toString().isEmpty) {
        setState(() {
          _response = "Set the amount";
        });
      } else {
        executeRegularPayment(
            paymentMethods[selectedPaymentMethodIndex].paymentMethodId!);
      }
    }
  }

  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.cardHeight = 340;
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.backgroundColor = getColorHexFromStr("#00ACB3");
    cardViewStyle.input?.inputMargin = 3;
    cardViewStyle.label?.display = true;
    cardViewStyle.input?.fontFamily = MFFontFamily.TimesNewRoman;
    cardViewStyle.label?.fontWeight = MFFontWeight.Light;
    cardViewStyle.savedCardText?.saveCardText = "Save Card";
    cardViewStyle.savedCardText?.addCardText = "Add Card";
    MFDeleteAlert deleteAlertText = MFDeleteAlert();
    deleteAlertText.title = "Delete Card";
    deleteAlertText.message = "Delete Card?";
    deleteAlertText.confirm = "Confirm";
    deleteAlertText.cancel = "Cancel";
    cardViewStyle.savedCardText?.deleteAlertText = deleteAlertText;
    return cardViewStyle;
  }

  initiateSessionForCardView() async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest(customerIdentifier: widget.customerIdentifier);

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => loadEmbeddedPayment(value))
        .catchError((error) => {log(error.message)});
  }

  loadCardView(MFInitiateSessionResponse session) {
    mfCardView.load(session, (bin) {
      log(bin);
    });
  }

  loadEmbeddedPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 10);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.KUWAIT_KWD;
    await loadCardView(session);
    if (Platform.isIOS) {
      applePayPayment(session);
    }
  }

  applePayPayment(MFInitiateSessionResponse session) async {
    MFExecutePaymentRequest executePaymentRequest =
        MFExecutePaymentRequest(invoiceValue: 0.01);
    executePaymentRequest.displayCurrencyIso = MFCurrencyISO.SAUDIARABIA_SAR;

    await mfApplePayButton
        .displayApplePayButton(
            session, executePaymentRequest, MFLanguage.ENGLISH)
        .then((value) => {
              log(value),
              // mfApplePayButton
              //     .executeApplePayButton(null, (invoiceId) => log(invoiceId))
              //     .then((value) => log(value))
              //     .catchError((error) => {log(error.message)})
            })
        .catchError((error) => {log(error.message)});
  }

  // pay() async {
  //   var executePaymentRequest = MFExecutePaymentRequest(
  //       invoiceValue: widget.totalAmount,
  //       customerReference: widget.orderId.toString());

  //   await mfCardView.pay(executePaymentRequest, MFLanguage.ENGLISH,
  //       (invoiceId) {
  //     debugPrint("-----------$invoiceId------------");
  //     log(invoiceId);
  //   }).then((value) async {
  //     // Added async here
  //     log(value);

  //     // Check payment status from the response
  //     try {
  //       // The response is of type MFGetPaymentStatusResponse
  //       final MFGetPaymentStatusResponse responseData = value;
  //       final String invoiceStatus = responseData.invoiceStatus ?? '';
  //       final String invoiceReference = responseData.invoiceReference ?? '';

  //       // Check if payment was successful
  //       final bool isSuccess = invoiceStatus.toLowerCase() == 'paid';
  //       String message;

  //       if (isSuccess) {
  //         message =
  //             "Your payment was successful!\nReference: $invoiceReference";
  //       } else {
  //         message =
  //             "Payment could not be completed.\nReference: $invoiceReference";
  //       }

  //       // Fixed the semicolon issue here
  //       await Provider.of<PaymentProvider>(context, listen: false)
  //           .updateOrderStatus(
  //         token: widget.token,
  //         orderId: widget.orderId.toString(),
  //         invoiceId: responseData.invoiceId,
  //       );

  //       // Navigate to result screen
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PaymentResultScreen(
  //             message: message,
  //             isSuccess: isSuccess,
  //           ),
  //         ),
  //       );
  //     } catch (e) {
  //       // Handle parsing error
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PaymentResultScreen(
  //             message: "Error processing payment result: ${e.toString()}",
  //             isSuccess: false,
  //           ),
  //         ),
  //       );
  //     }
  //   }).catchError((error) {
  //     log(error.message);
  //     if (error.message == "Card details are invalid or missing!") {
  //       // Empty if block - might want to add some user feedback here
  //     } else {
  //       // Navigate to result screen for failure
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => PaymentResultScreen(
  //             message: "Payment failed: ${error.message}",
  //             isSuccess: false,
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }
  pay() async {
    var invoiceId;
    var executePaymentRequest = MFExecutePaymentRequest(
        invoiceValue: widget.totalAmount,
        customerReference: widget.orderId.toString());

    await mfCardView.pay(executePaymentRequest, MFLanguage.ENGLISH,
        (invoiceId) {
      debugPrint("-----------$invoiceId------------");
      log(invoiceId);
    }).then((value) async {
      log(value);

      // Check payment status from the response
      try {
        // The response is of type MFGetPaymentStatusResponse
        final MFGetPaymentStatusResponse responseData = value;
        invoiceId = responseData.invoiceId;
        final String invoiceStatus = responseData.invoiceStatus ?? '';
        final String invoiceReference = responseData.invoiceReference ?? '';

        // Check if payment was successful
        final bool isSuccess = invoiceStatus.toLowerCase() == 'paid';
        String message;

        if (isSuccess) {
          message =
              "Your payment was successful!\nReference: $invoiceReference";
        } else {
          message =
              "Payment could not be completed.\nReference: $invoiceReference";
        }
        await Provider.of<PaymentProvider>(context, listen: false)
            .updateOrderStatus(
          token: widget.token,
          orderId: widget.orderId.toString(),
          invoiceId: responseData.invoiceId.toString(),
        );
        // Navigate to result screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentResultScreen(
              // token: widget.token,
              // invoiceId: responseData.invoiceId!,
              orderId: widget.orderId.toString(),
              message: message,
              isSuccess: isSuccess,
            ),
          ),
        );
      } catch (e) {
        // Handle parsing error
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentResultScreen(
              // token: widget.token,
              // invoiceId: invoiceId!,
              orderId: widget.orderId.toString(),
              message: "Error processing payment result: ${e.toString()}",
              isSuccess: false,
            ),
          ),
        );
      }
    }).catchError((error) {
      log(error.message);
      if (error.message == "Card details are invalid or missing!") {
      } else {
        // Navigate to result screen for failure
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentResultScreen(
              // token: widget.token,
              // invoiceId: invoiceId!,
              orderId: widget.orderId.toString(),
              message: "Payment failed: ${error.message}",
              isSuccess: false,
            ),
          ),
        );
      }
    });
  }

  initiateSessionForGooglePay() async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest(customerIdentifier: widget.customerIdentifier);

    await MFSDK
        .initSession(initiateSessionRequest, MFLanguage.ENGLISH)
        .then((value) => {setupGooglePayHelper(value.sessionId)})
        .catchError((error) => {log(error.message)});
  }

  setupGooglePayHelper(String sessionId) async {
    MFGooglePayRequest googlePayRequest = MFGooglePayRequest(
        totalPrice: "1",
        merchantId: '', //Config.googleMerchantId,
        merchantName: "Test Vendor",
        countryCode: MFCountry.KUWAIT,
        currencyIso: MFCurrencyISO.UAE_AED);

    await mfGooglePayButton
        .setupGooglePayHelper(sessionId, googlePayRequest, (invoiceId) {
          log("-----------Invoice Id: $invoiceId------------");
        })
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  @override
  Widget build(BuildContext context) {
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
    mfGooglePayButton = MFGooglePayButton();

    //  return MaterialApp(
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      // appBar: AppBar(
      //   toolbarHeight: 1,
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Flex(
            direction: Axis.vertical,
            children: [
              // Text("Payment Amount", style: textStyle()),
              //  amountInput(),
              if (Platform.isIOS) applePayView(),
              //if (Platform.isAndroid)
              googlePayButton(),
              embeddedCardView(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //  paymentMethodsList(),
                        if (selectedPaymentMethodIndex != -1)
                          btn("Execute Payment", executePayment),
                        // btn("Reload GooglePay", initiateSessionForGooglePay),
                        // ColoredBox(
                        //   color: const Color(0xFFD8E5EB),
                        //   child: SelectableText.rich(
                        //     TextSpan(
                        //       text: _response!,
                        //       style: const TextStyle(),
                        //     ),
                        //   ),
                        // ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }

  Widget embeddedCardView() {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: mfCardView,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          children: [
            const SizedBox(width: 4),
            Expanded(
                child: elevatedButton(
                    "Pay ${widget.totalAmount.toString()}", pay)),
            const SizedBox(width: 2),
            elevatedButton("", initiateSessionForCardView),
          ],
        )
      ],
    );
  }

  Widget applePayView() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: mfApplePayButton,
        )
      ],
    );
  }

  Widget googlePayButton() {
    return SizedBox(
      height: 70,
      child: mfGooglePayButton,
    );
  }

  Widget paymentMethodsList() {
    return Column(
      children: [
        Text("Select payment method", style: textStyle()),
        SizedBox(
          height: 85,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: paymentMethods.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return paymentMethodsItem(ctxt, index);
              }),
        ),
      ],
    );
  }

  Widget paymentMethodsItem(BuildContext ctxt, int index) {
    return SizedBox(
      width: 70,
      height: 75,
      child: Container(
        decoration: isSelected[index]
            ? BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 2))
            : const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Image.network(
                paymentMethods[index].imageUrl!,
                height: 35.0,
              ),
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                    checkColor: Colors.blueAccent,
                    activeColor: const Color(0xFFC9C5C5),
                    value: isSelected[index],
                    onChanged: (bool? value) {
                      setState(() {
                        setPaymentMethodSelected(index, value!);
                      });
                    }),
              ),
              Text(
                paymentMethods[index].paymentMethodEn ?? "",
                style: TextStyle(
                  fontSize: 8.0,
                  fontWeight:
                      isSelected[index] ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btn(String title, Function onPressed) {
    return SizedBox(
      width: double.infinity,
      child: elevatedButton(title, onPressed),
    );
  }

  Widget elevatedButton(String title, Function onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(appColor),
        // shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        //   // (Set<WidgetState> states) {
        //   //   if (states.contains(WidgetState.pressed)) {
        //   //     return RoundedRectangleBorder(
        //   //       borderRadius: BorderRadius.circular(8.0),
        //   //       side: const BorderSide(color: Colors.red, width: 1.0),
        //   //     );
        //   //   } else {
        //   //     return RoundedRectangleBorder(
        //   //       borderRadius: BorderRadius.circular(8.0),
        //   //       side: const BorderSide(color: Colors.white, width: 1.0),
        //   //     );
        //   //   }
        //   // },
        // ),
      ),
      child: (title.isNotEmpty)
          ? Text(title, style: textStyle())
          : const Icon(Icons.refresh),
      onPressed: () async {
        await onPressed();
      },
    );
  }

  // Widget amountInput() {
  //   return TextField(
  //     style: const TextStyle(color: Colors.white),
  //     textAlign: TextAlign.center,
  //     keyboardType: TextInputType.number,
  //     controller: TextEditingController(text: widget.totalAmount.toString()),
  //     decoration: const InputDecoration(
  //       filled: true,
  //       fillColor: Color(0xff0495ca),
  //       hintText: "0.00",
  //       contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.white, width: 1.0),
  //         borderRadius: BorderRadius.all(Radius.circular(8.0)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.red, width: 1.0),
  //         borderRadius: BorderRadius.all(Radius.circular(8.0)),
  //       ),
  //     ),
  //     onChanged: (value) {
  //       //amount = value;
  //     },
  //   );
  // }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic);
  }
}
