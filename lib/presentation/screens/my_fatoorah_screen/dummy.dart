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
// "asdfgbuh2bhbhsbjdbcjbfkdbgvkdg",        MFCountry.QATAR,
//         MFEnvironment.LIVE, // Consider using .TEST first for debugging
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
//       // request.customerMobile = "+97412345678";

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
//         invoiceValue: widget.totalAmount,
//       );
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
//                   // Navigator.pushAndRemoveUntil(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => HomeScreen()),
//                   //   (route) =>
//                   //       false, // This predicate removes all previous routes
//                   // );
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
