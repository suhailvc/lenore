import 'package:flutter/material.dart';
import 'package:lenore/infrastructure/wallet_balance_api/wallet_balance_api.dart';

class WalletBalanceProvider extends ChangeNotifier {
  double _walletBalance = 0.0;
  bool _isLoading = false;
  String? _error;

  double get walletBalance => _walletBalance;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWalletBalance(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final balance = await walletBalanceApi(context);

      if (balance != null) {
        _walletBalance = balance;
        _error = null;
      } else {
        _error = 'Failed to fetch wallet balance';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
