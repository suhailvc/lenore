import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

class CardPaymentScreen extends StatefulWidget {
  final double totalAmount;

  const CardPaymentScreen({required this.totalAmount, super.key});

  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  late MFCardPaymentView mfCardView;
  String? sessionId;

  @override
  void initState() {
    super.initState();
    initiateSession();
  }

  // Function to initialize the payment session
  late MFInitiateSessionResponse sessionResponse;

  Future<void> initiateSession() async {
    try {
      MFInitiateSessionRequest request = MFInitiateSessionRequest();
      await MFSDK.initiateSession(request, (bin) {
        debugPrint("BIN: $bin");
      }).then((response) {
        setState(() {
          sessionResponse = response; // Store the entire response
        });
        loadPaymentCardView();
      });
    } catch (e) {
      debugPrint("Error initiating session: $e");
    }
  }

  Future<void> loadPaymentCardView() async {
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
      debugPrint("Error: $e");
    }
  }

  // Function to handle the pay action
  Future<void> pay() async {
    if (sessionId != null) {
      MFExecutePaymentRequest request =
          MFExecutePaymentRequest(invoiceValue: widget.totalAmount);
      request.sessionId = sessionId;

      await mfCardView.pay(request, MFLanguage.ENGLISH, (invoiceId) {
        debugPrint("Invoice ID: $invoiceId");
        // Handle successful payment (e.g., navigate to success screen)
      }).catchError((error) {
        debugPrint("Payment error: ${error.message}");
      });
    }
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
      appBar: AppBar(title: Text("Card Payment")),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: mfCardView,
          ),
          ElevatedButton(
            onPressed: pay,
            child: const Text("Pay"),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:lenore/presentation/screens/my_fatoorah_screen/widgets/card_view_style.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

// class FatoorahPaymentScreen extends StatefulWidget {
//   const FatoorahPaymentScreen({super.key});

//   @override
//   State<FatoorahPaymentScreen> createState() => _FatoorahPaymentScreenState();
// }

// class _FatoorahPaymentScreenState extends State<FatoorahPaymentScreen> {
//   late MFCardPaymentView mfCardView;
//   @override
//   Widget build(BuildContext context) {
//     mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
//     return Scaffold(
//       appBar: AppBar(title: Text("Payment")),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 200,
//             child: mfCardView,
//           ),
//           ElevatedButton(
//             onPressed: pay,
//             child: Text("Pay"),
//           ),
//         ],
//       ),
//     );
//   }
// }
