import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _username;
  String? _fullName;
  String? _token;

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;
  String? get fullName => _fullName;
  String? get token => _token;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _username = prefs.getString('username');
    _fullName = prefs.getString('full_name');
    _isLoggedIn = _token != null;
    notifyListeners();
  }

  Future<void> saveSession(
    String token, {
    String? username,
    String? fullName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    if (username != null) await prefs.setString('username', username);
    if (fullName != null) await prefs.setString('full_name', fullName);

    _token = token;
    _username = username;
    _fullName = fullName;
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _isLoggedIn = false;
    _username = null;
    _fullName = null;
    _token = null;
    notifyListeners();
  }
}
