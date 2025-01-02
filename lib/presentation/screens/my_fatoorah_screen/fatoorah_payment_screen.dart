import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lenore/application/provider/payment_provider/payment_provider.dart';
import 'package:lenore/core/constant.dart';
import 'package:lenore/presentation/screens/persistant_bottom_nav_bar/persistant_bottom_nav_bar.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import 'dart:io';

import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart'; // Import this to check the platform.

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
//   MFInitiateSessionResponse? sessionResponse;
//   Timer? _statusCheckTimer;
//   int _statusCheckAttempts = 0;
//   static const int maxAttempts =
//       12; // 60 seconds total (12 * 5 second intervals)

//   @override
//   void dispose() {
//     _statusCheckTimer?.cancel();
//     super.dispose();
//   }

//   Future<void> startPaymentStatusCheck(String paymentId) async {
//     _statusCheckAttempts = 0;
//     _statusCheckTimer?.cancel();

//     _statusCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _statusCheckAttempts++;

//       if (_statusCheckAttempts >= maxAttempts) {
//         timer.cancel();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentResultScreen(
//               message:
//                   "Payment verification timeout.\nPlease contact support if amount was deducted.",
//               isSuccess: false,
//             ),
//           ),
//         );
//         return;
//       }

//       getPaymentStatus(paymentId).then((completed) {
//         if (completed) {
//           timer.cancel();
//         }
//       });
//     });
//   }

//   Future<bool> getPaymentStatus(String paymentId) async {
//     try {
//       debugPrint(
//           "Checking payment status for ID: $paymentId (Attempt: $_statusCheckAttempts)");

//       var request = MFGetPaymentStatusRequest(
//           key: paymentId, keyType: MFKeyType.PAYMENTID);

//       final response =
//           await MFSDK.getPaymentStatus(request, MFLanguage.ENGLISH);
//       debugPrint("Payment status: ${response.invoiceStatus}");

//       // If we get a definitive status, handle it
//       if (response.invoiceStatus == "Paid") {
//         _statusCheckTimer?.cancel();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentResultScreen(
//               message: "Payment Successful!\nOrder ID: ${widget.orderId}",
//               isSuccess: true,
//             ),
//           ),
//         );
//         return true;
//       } else if (response.invoiceStatus == "Failed" ||
//           response.invoiceStatus == "Expired") {
//         _statusCheckTimer?.cancel();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentResultScreen(
//               message: "Payment Failed!\nStatus: ${response.invoiceStatus}",
//               isSuccess: false,
//             ),
//           ),
//         );
//         return true;
//       }

//       // Payment still processing
//       return false;
//     } catch (e) {
//       debugPrint("Error checking status (Attempt $_statusCheckAttempts): $e");
//       return false;
//     }
//   }

//   Future<void> payWithCard() async {
//     if (sessionResponse == null) {
//       showErrorDialog("Error", "Session not initialized");
//       return;
//     }

//     try {
//       debugPrint("Starting card payment...");
//       var executePaymentRequest = MFExecutePaymentRequest(
//         invoiceValue: widget.totalAmount,
//       );
//       executePaymentRequest.sessionId = sessionResponse!.sessionId;

//       mfCardView.pay(
//         executePaymentRequest,
//         MFLanguage.ENGLISH,
//         (String? paymentId) {
//           debugPrint("Payment in progress, received ID: $paymentId");
//           if (paymentId != null) {
//             startPaymentStatusCheck(paymentId);
//           }
//         },
//       );
//     } catch (e) {
//       debugPrint("Exception in payWithCard: $e");
//       showErrorDialog("Error", "Payment failed");
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
//             ElevatedButton(
//               onPressed: payWithCard,
//               style: ElevatedButton.styleFrom(backgroundColor: appColor),
//               child: const Text("Pay with Card",
//                   style: TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CardPaymentScreen extends StatefulWidget {
  final int orderId;
  final double totalAmount;
  final String token;
  final BuildContext context;

  const CardPaymentScreen(
      {required this.context,
      required this.token,
      required this.orderId,
      required this.totalAmount,
      Key? key})
      : super(key: key);

  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  late MFCardPaymentView mfCardView;
  late MFInitiateSessionResponse sessionResponse;

  @override
  void initState() {
    super.initState();
    initiateSession();
  }

  /// Initiates the payment session
  Future<void> initiateSession() async {
    try {
      MFInitiateSessionRequest request = MFInitiateSessionRequest();

      await MFSDK.initSession(request, MFLanguage.ENGLISH).then((response) {
        debugPrint("Session initiated successfully");
        setState(() {
          sessionResponse = response;
        });
        loadCardView();
      }).catchError((error) {
        debugPrint("Error initiating session: ${error.toString()}");
        showErrorDialog("Error", "Failed to initiate session");
      });
    } catch (e) {
      debugPrint("Error initiating session: $e");
      showErrorDialog("Error", "Failed to initiate session");
    }
  }

  /// Loads the payment card view
  Future<void> loadCardView() async {
    try {
      await mfCardView.load(
        sessionResponse,
        (error) {
          if (error == null) {
            debugPrint("Card view loaded successfully.");
          } else {
            debugPrint("Error loading card view: $error");
          }
        },
      );
    } catch (e) {
      debugPrint("Error loading card view: $e");
    }
  }

  /// Navigates to the result screen
  void navigateToResultScreen(String message, {required bool isSuccess}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentResultScreen(
          message: message,
          isSuccess: isSuccess,
        ),
      ),
    );
  }

  /// Handles card payment
  // Future<void> payWithCard() async {
  //   try {
  //     // Step 1: Execute the payment and get invoice ID
  //     MFExecutePaymentRequest executePaymentRequest = MFExecutePaymentRequest(
  //       invoiceValue: widget.totalAmount,
  //       customerReference: widget.orderId.toString(),
  //     );
  //     executePaymentRequest.sessionId = sessionResponse.sessionId;

  //     await mfCardView.pay(executePaymentRequest, MFLanguage.ENGLISH,
  //         (InvoiceStatus) async {
  //       print("Card payment successful, Invoice ID---------------------: $InvoiceStatus");

  //       // try {
  //       //   // Step 2: Request payment status
  //       //   MFGetPaymentStatusRequest paymentStatusRequest =
  //       //       MFGetPaymentStatusRequest(
  //       //     key: invoiceId, // Use the invoice ID as the key
  //       //     keyType: MFKeyType.INVOICEID, // Use INVOICEID for keyType
  //       //   );

  //       //   MFGetPaymentStatusResponse paymentStatusResponse =
  //       //       await MFSDK.getPaymentStatus(
  //       //     paymentStatusRequest,
  //       //     MFLanguage.ENGLISH, // Ensure language is passed correctly
  //       //   );

  //       //   // Step 3: Check the status of the payment and handle it accordingly
  //       //   if (paymentStatusResponse == null) {
  //       //     debugPrint("Error: Payment status response is null");
  //       //     navigateToResultScreen(
  //       //       "Payment Failed 1 !\nReason: No payment status data available.",
  //       //       isSuccess: false,
  //       //     );
  //       //     return;
  //       //   }

  //       //   // Check the invoice status
  //       //   if (paymentStatusResponse.invoiceStatus == "Paid" &&
  //       //       paymentStatusResponse.invoiceTransactions != null &&
  //       //       paymentStatusResponse.invoiceTransactions!.isNotEmpty &&
  //       //       paymentStatusResponse.invoiceTransactions![0].transactionStatus ==
  //       //           "Success") {
  //       //     navigateToResultScreen(
  //       //       "Payment Successful!\nOrder ID: ${widget.orderId}",
  //       //       isSuccess: true,
  //       //     );
  //       //   } else if (paymentStatusResponse.invoiceStatus == "Pending") {
  //       //     // Transaction is pending, check for failed transaction
  //       //     if (paymentStatusResponse.invoiceTransactions != null &&
  //       //         paymentStatusResponse.invoiceTransactions!.isNotEmpty &&
  //       //         paymentStatusResponse
  //       //                 .invoiceTransactions![0].transactionStatus ==
  //       //             "Failed") {
  //       //       debugPrint(
  //       //           "Payment failed: ${paymentStatusResponse.invoiceTransactions![0].error}");
  //       //       navigateToResultScreen(
  //       //         "Payment Failed 2 !\nReason: ${paymentStatusResponse.invoiceTransactions![0].error ?? 'Unknown error'}",
  //       //         isSuccess: false,
  //       //       );
  //       //     } else {
  //       //       navigateToResultScreen(
  //       //         "Payment Pending.\nPlease check again later.",
  //       //         isSuccess: false,
  //       //       );
  //       //     }
  //       //   } else {
  //       //     // Handle any other unexpected invoice status
  //       //     navigateToResultScreen(
  //       //       "Payment Failed 3 !\nReason: Unknown issue with payment status.",
  //       //       isSuccess: false,
  //       //     );
  //       //   }
  //       // } catch (e) {
  //       //   debugPrint("Error fetching payment status: $e");
  //       //   if (e is MFError) {
  //       //     debugPrint("MFError: ${e.message ?? e.toString()}");
  //       //   } else {
  //       //     debugPrint("Non-MFError: $e");
  //       //   }
  //       //   navigateToResultScreen(
  //       //     "Payment Failed 4 !\nReason: ${e.toString()}",
  //       //     isSuccess: false,
  //       //   );
  //       // }
  //     }).catchError((error) {
  //       debugPrint("Card payment error: ${error.toString()}");
  //       navigateToResultScreen(
  //         "Payment Failed 5 !\nReason: ${error.toString()}",
  //         isSuccess: false,
  //       );
  //     });
  //   } catch (e) {
  //     debugPrint("Error during card payment: $e");
  //     navigateToResultScreen(
  //       "Payment Failed 6 !\nReason: ${e.toString()}",
  //       isSuccess: false,
  //     );
  //   }
  // }

  Future<void> payWithCard() async {
    try {
      MFExecutePaymentRequest executePaymentRequest = MFExecutePaymentRequest(
          invoiceValue: widget.totalAmount,
          customerReference: widget.orderId.toString());
      executePaymentRequest.sessionId = sessionResponse.sessionId;

      await mfCardView.pay(executePaymentRequest, MFLanguage.ENGLISH,
          (invoiceId) {
        // print('-----------------------toke ${invoiceStatus}');
        debugPrint(
            "Card payment successful-------------------, Invoice ID: $invoiceId");
        Provider.of<PaymentProvider>(context, listen: false).updateOrderStatus(
            token: widget.token,
            orderId: widget.orderId.toString(),
            invoiceId: invoiceId);
        navigateToResultScreen(
          "Payment Successful!\nOrder ID: ${widget.orderId}",
          isSuccess: true,
        );
      }).catchError((error) {
        debugPrint("Card payment error: ${error.toString()}");
        navigateToResultScreen(
          "Payment Failed!\nReason: ${error.toString()}",
          isSuccess: false,
        );
      });
    } catch (e) {
      debugPrint("Error during card payment: $e");
      navigateToResultScreen(
        "Payment Failed!\nReason: ${e.toString()}",
        isSuccess: false,
      );
    }
  }

  /// Displays an error dialog
  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define card view style
    MFCardViewStyle cardViewStyle() {
      MFCardViewStyle style = MFCardViewStyle();
      style.cardHeight = 200;
      style.hideCardIcons = false;
      style.input?.inputMargin = 5;
      style.label?.display = true;
      style.input?.fontFamily = MFFontFamily.Monaco;
      style.label?.fontWeight = MFFontWeight.Heavy;
      return style;
    }

    // Initialize card view
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 200, child: mfCardView),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: payWithCard,
              style: ElevatedButton.styleFrom(backgroundColor: appColor),
              child: const Text("Pay with Card",
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// /// Result Screen for Payment Success or Failure
class PaymentResultScreen extends StatelessWidget {
  final String message;
  final bool isSuccess;

  const PaymentResultScreen({
    required this.message,
    required this.isSuccess,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        title: Text(
          isSuccess ? "Payment Successful" : "Payment Failed",
          style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
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
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to home or any other screen
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
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
