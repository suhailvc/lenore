import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _hasToken = false;

  bool get hasToken => _hasToken;

  AuthProvider() {
    _checkBearerToken(); // Initialize by checking token at startup
  }

  Future<void> _checkBearerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _hasToken = prefs.containsKey('bearerToken');
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> refreshTokenStatus() async {
    await _checkBearerToken(); // Public method to refresh token status
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('bearerToken');
    _hasToken = false;
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bearerToken', token);
    _hasToken = true;
    notifyListeners();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('bearerToken');
  }
}
