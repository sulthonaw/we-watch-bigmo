import 'package:flutter/material.dart';
import 'package:narabuna/services/api_client.dart';

class KondisiViewModel extends ChangeNotifier {
  Map<String, dynamic>? _data;
  bool _isLoading = false;

  Map<String, dynamic>? get data => _data;
  bool get isLoading => _isLoading;

  Future<void> fetchConditions(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(
        '/conditions',
        headers: {'Authorization': 'Bearer $token'},
      );
      _data = response;
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
