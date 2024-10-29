import 'package:flutter/material.dart';
import 'package:lenore/domain/notification_model/notification_model.dart';

import 'package:lenore/infrastructure/notification_api/notification_api.dart';

class NotificationProvider with ChangeNotifier {
  NotificationsModel? _notification;
  bool _isLoading = false;
  bool _showGif = true;

  NotificationsModel? get profile => _notification;
  bool get isLoading => _isLoading;
  bool get showGif => _showGif;

  NotificationProvider() {
    _startGifDelay();
  }

  Future<void> fetchNotification() async {
    _isLoading = true;
    notifyListeners();

    final fetchedNotification = await notificationService();
    _notification = fetchedNotification;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _startGifDelay() async {
    await Future.delayed(Duration(seconds: 3));
    _showGif = false;
    notifyListeners();
  }
}
