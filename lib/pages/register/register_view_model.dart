import 'package:flutter/material.dart';
import 'package:narabuna/services/api_client.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String nik,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await ApiClient.post(
        '/auth/register',
        body: {
          'fullName': fullName,
          'username': username,
          'email': email,
          'password': password,
          'nik': nik,
        },
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
