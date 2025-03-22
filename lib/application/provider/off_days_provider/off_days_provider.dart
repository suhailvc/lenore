import 'package:flutter/material.dart';
import 'package:lenore/domain/off_days_model/off_days_model.dart';
import 'package:lenore/infrastructure/off_days_api/off_days_api.dart';

class OffDaysProvider with ChangeNotifier {
  List<DateTime> _offDays = [];
  bool _isLoading = false;
  String _error = '';

  List<DateTime> get offDays => _offDays;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchOffDays() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final OffDaysResponse response = await offDaysMethod();

      if (response.status) {
        _offDays = response.data;
      } else {
        _error = response.message;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool isOffDay(DateTime date) {
    return _offDays.any((offDay) =>
        offDay.year == date.year &&
        offDay.month == date.month &&
        offDay.day == date.day);
  }
}
