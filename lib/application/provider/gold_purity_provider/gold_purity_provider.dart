import 'package:flutter/material.dart';
import 'package:lenore/domain/gold_purity_model/gold_purity_model.dart';
import 'package:lenore/infrastructure/gold_purity_api/gold_purity_api.dart';

class GoldPurityProvider with ChangeNotifier {
  GoldPurityModel? _goldPurityData;
  bool _isLoading = false;

  GoldPurityModel? get goldPurityData => _goldPurityData;
  bool get isLoading => _isLoading;

  Future<void> loadGoldPurity() async {
    _isLoading = true;
    notifyListeners();

    _goldPurityData = await GoldpurityApi.fetchGoldPurity();

    _isLoading = false;
    notifyListeners();
  }
}
