import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int _start = 20;
  Timer? _timer;

  int get start => _start;

  void startTimer() {
    if (_timer != null) _timer!.cancel();
    _start = 20;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _timer!.cancel();
      } else {
        _start--;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
