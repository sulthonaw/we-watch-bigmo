import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:narabuna/auth/auth_state.dart';
import 'package:narabuna/services/api_client.dart';

class ChatViewModel extends ChangeNotifier {
  String? _sessionId;
  bool _isLoading = false;
  bool _useUserData = false;
  final List<Map<String, dynamic>> _messages = [];

  String? get sessionId => _sessionId;
  bool get isLoading => _isLoading;
  bool get useUserData => _useUserData;
  List<Map<String, dynamic>> get messages => _messages;

  void toggleUseUserData(bool value) {
    _useUserData = value;
    notifyListeners();
  }

  Future<void> sendMessage(String text, AuthState authState) async {
    if (text.isEmpty) return;

    final now = DateTime.now();
    final timeString =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    _messages.add({'isMe': true, 'text': text, 'time': timeString});

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.post(
        '/chat',
        headers: {'Authorization': 'Bearer ${authState.token}'},
        body: {
          'sessionId': _sessionId,
          'message': text,
          'useUserData': _useUserData,
        },
      );

      if (_sessionId == null) {
        _sessionId = response['sessionId'];
      }

      _messages.add({
        'isMe': false,
        'text': response['response'],
        'time': timeString,
      });
    } catch (e, stackTrace) {
      _messages.add({
        'isMe': false,
        'text': 'Maaf Bun, terjadi kesalahan: ${e.toString()}',
        'time': 'Baru saja',
      });
      log(
        'Chatbot Error: ${e.toString()}',
        name: 'ChatViewModel',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    _sessionId = null;
    notifyListeners();
  }
}
