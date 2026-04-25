import 'package:flutter/material.dart';
import 'package:narabuna/auth/auth_state.dart';
import 'package:narabuna/services/api_client.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(
    String identifier,
    String password,
    AuthState authState,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiClient.post(
        '/auth/login',
        body: {'identifier': identifier, 'password': password},
      );

      final String token = response['token'];
      final Map<String, dynamic> userData = response['user'];

      final String username = userData['username'];
      final String fullName = userData['fullName'];

      await authState.saveSession(
        token,
        username: username,
        fullName: fullName,
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
