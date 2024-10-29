import 'package:flutter/material.dart';
import 'package:lenore/domain/profile_model/profile_model.dart';
import 'package:lenore/infrastructure/profile_api/profile_api.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? _profile;
  bool _isLoading = false;
  bool _showGif = true;

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get showGif => _showGif;

  ProfileProvider() {
    // Automatically trigger the GIF delay when provider is initialized
    _startGifDelay();
  }

  Future<void> fetchProfile(String token) async {
    _isLoading = true;
    notifyListeners();

    final fetchedProfile = await getProfileDetailsService(token);
    _profile = fetchedProfile;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _startGifDelay() async {
    await Future.delayed(Duration(seconds: 3));
    _showGif = false;
    notifyListeners();
  }
}

// class ProfileProvider with ChangeNotifier {
//   ProfileModel? _profile;
//   bool _isLoading = false;

//   ProfileModel? get profile => _profile;
//   bool get isLoading => _isLoading;

//   Future<void> fetchProfile(String token) async {
//     _isLoading = true;
//     notifyListeners();

//     final fetchedProfile = await getProfileDetailsService(token);
//     _profile = fetchedProfile;
//     _isLoading = false;
//     notifyListeners();
//   }
// }
