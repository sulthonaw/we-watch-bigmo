import 'package:flutter/material.dart';
import 'package:narabuna/services/api_client.dart';

class KondisiDetailViewModel extends ChangeNotifier {
  Map<String, dynamic>? _visitData;
  bool _isLoading = false;

  Map<String, dynamic>? get visitData => _visitData;
  bool get isLoading => _isLoading;

  Future<void> fetchVisitDetail(String token, String visitId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(
        '/me/visits/$visitId',
        headers: {'Authorization': 'Bearer $token'},
      );
      _visitData = response;
    } catch (e) {
      debugPrint('Error fetching visit detail: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
