import 'package:flutter/material.dart';

class CheckBoxProvider extends ChangeNotifier {
  // bool _isChecked = false;
  bool _giftMySelfChecked = true;
  bool _sendAsGiftChecked = false;
  bool get giftMySelfChecked => _giftMySelfChecked;
  bool get sendAsGift => _sendAsGiftChecked;

  void toggleSendAsGift() {
    _sendAsGiftChecked = !_sendAsGiftChecked;
    _giftMySelfChecked = !_giftMySelfChecked;
    notifyListeners();
  }

  void toggleMySelf() {
    _sendAsGiftChecked = false;
    _giftMySelfChecked = true;
    notifyListeners();
  }
}
