// // config.dart// payment_service.dart
// import 'package:flutter/material.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

// class PaymentConfig {
//   static bool get isProduction => false; // Change to true for production

//   static const String testAPIKey =
//       "UIgbtb_fyCSnHeP76m6roKj04tCQ3z5n_hMQ-haAeA_n-gAWJeAmTZ-Lkpi3kfrycTeDZCvUCRTRfgTA669XkXUf6fdh86DGTC9a3Z2NOgA6fkkwy4qII1MQsc8vGkMJfP-B5DAuwNLg1xmTNOufi6pkubg3AAlVTgfgE7MEifbKT-CiBjMiznYgmsYv99HMtKHZYubufuSnHOPo4AYi03gbkPSyUQ37hsuVBWleTrqMsHDE7pJ5jPHJojeP1wiRVXzbXBlLTxZ_zzNMUV5VLMJRSukVX5COwYbwca1dafj_q_bFV6KHO7v1Qwc6ydk1HSUNmnU2PBT_Bq4-rCuY6O2nCu4p1NNhFilMEjOlk4HHs-JNWsZAIRvYJt-kXjI2Y3IO8YP8mgVFP5A5n97ZkNOTenPWPpAojvCXA3AjYEjTB_4IHq20M0bcD5-hnDT9IRMlaPMA8cR1S27sXQO97mrmqC60t3DtOM2RSNcA-5uHaxQpSCNRGPo1D3WO_qEiXuARM4hsgiRxu9Y_aCKJtnLsfqxxtslx1IahDnyrkUhyxJ9UCe9Q6OLwfpPYIqha1OemunYUuKe6e_Y5WoV3Kz9NdvyXrmNrDEYPHW9ePIrg9YNXuUhTM764VcwSHPPMnJqg3fwG6hhGhYUFl-mJTCiOiucP_gI3J_TUEhHkAyA7kYxk";

// //TODO Get your google merchant id
//   static const String googleMerchantId = "your_google_merchant_id";
// }

// class PaymentService {
//   static Future<void> initializePayment() async {
//     await MFSDK.init(
//         PaymentConfig.testAPIKey, MFCountry.QATAR, MFEnvironment.LIVE);
//   }

//   static Future<List<MFPaymentMethod>> getPaymentMethods(double amount) async {
//     try {
//       var request = MFInitiatePaymentRequest(
//           invoiceAmount: amount, currencyIso: MFCurrencyISO.QATAR_QAR);

//       var response = await MFSDK.initiatePayment(request, MFLanguage.ENGLISH);

//       return response.paymentMethods ?? [];
//     } catch (e) {
//       debugPrint('Error getting payment methods: $e');
//       rethrow;
//     }
//   }

//   static Future<void> executePayment({
//     required int paymentMethodId,
//     required double amount,
//     required Function(String) onInvoiceCreated,
//   }) async {
//     try {
//       var request = MFExecutePaymentRequest(
//         paymentMethodId: paymentMethodId,
//         invoiceValue: amount,
//       );
//       request.displayCurrencyIso = MFCurrencyISO.QATAR_QAR;

//       await MFSDK.executePayment(
//         request,
//         MFLanguage.ENGLISH,
//         onInvoiceCreated,
//       );
//     } catch (e) {
//       debugPrint('Error executing payment: $e');
//       rethrow;
//     }
//   }
// }

// // payment_screen.dart
// class PaymentScreen extends StatefulWidget {
//   final double amount;
//   const PaymentScreen({Key? key, required this.amount}) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   List<MFPaymentMethod> _paymentMethods = [];
//   int? _selectedMethodId;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializePayment();
//   }

//   Future<void> _initializePayment() async {
//     try {
//       await PaymentService.initializePayment();
//       var methods = await PaymentService.getPaymentMethods(widget.amount);
//       setState(() {
//         _paymentMethods = methods;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() => _isLoading = false);
//       _showError('Failed to initialize payment');
//     }
//   }

//   Future<void> _processPayment() async {
//     if (_selectedMethodId == null) {
//       _showError('Please select a payment method');
//       return;
//     }

//     setState(() => _isLoading = true);
//     try {
//       await PaymentService.executePayment(
//         paymentMethodId: _selectedMethodId!,
//         amount: widget.amount,
//         onInvoiceCreated: _handleInvoiceCreated,
//       );
//     } catch (e) {
//       _showError('Payment failed: ${e.toString()}');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _handleInvoiceCreated(String invoiceId) {
//     debugPrint('Invoice created: $invoiceId');
//     // Handle invoice creation
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Payment')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Amount: ${widget.amount} QAR',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge, // Fixed headline6
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 20),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: _paymentMethods.length,
//                       itemBuilder: (context, index) {
//                         final method = _paymentMethods[index];
//                         return PaymentMethodCard(
//                           method: method,
//                           isSelected:
//                               _selectedMethodId == method.paymentMethodId,
//                           onSelected: (selected) {
//                             setState(() {
//                               _selectedMethodId =
//                                   selected ? method.paymentMethodId : null;
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed:
//                         _selectedMethodId != null ? _processPayment : null,
//                     child: const Text('Pay Now'),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// // payment_method_card.dart
// class PaymentMethodCard extends StatelessWidget {
//   final MFPaymentMethod method;
//   final bool isSelected;
//   final Function(bool) onSelected;

//   const PaymentMethodCard({
//     Key? key,
//     required this.method,
//     required this.isSelected,
//     required this.onSelected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: isSelected ? 4 : 1,
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       child: ListTile(
//         leading: Image.network(
//           method.imageUrl ?? '',
//           width: 40,
//           height: 40,
//           errorBuilder: (_, __, ___) => const Icon(Icons.payment),
//         ),
//         title: Text(method.paymentMethodEn ?? ''),
//         trailing: Checkbox(
//           value: isSelected,
//           onChanged: (value) => onSelected(value ?? false),
//         ),
//         onTap: () => onSelected(!isSelected),
//       ),
//     );
//   }
// }
