import 'package:flutter/material.dart';
import 'package:narabuna/services/api_client.dart';

class HomeViewModel extends ChangeNotifier {
  Map<String, dynamic>? _classification;
  Map<String, dynamic>? _visitsData;
  bool _isLoading = false;

  Map<String, dynamic>? get classification => _classification;
  Map<String, dynamic>? get visitsData => _visitsData;
  bool get isLoading => _isLoading;

  Future<void> fetchData(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        ApiClient.get(
          '/me/classification',
          headers: {'Authorization': 'Bearer $token'},
        ),
        ApiClient.get(
          '/me/visits',
          headers: {'Authorization': 'Bearer $token'},
        ),
      ]);

      _classification = results[0];
      _visitsData = results[1];
    } catch (e) {
      debugPrint('Error fetching home data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
