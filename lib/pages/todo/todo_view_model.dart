import 'package:flutter/material.dart';
import 'package:narabuna/services/api_client.dart';

class TodoViewModel extends ChangeNotifier {
  List<dynamic> _todos = [];
  bool _isLoading = false;

  List<dynamic> get todos => _todos;
  bool get isLoading => _isLoading;

  double get progress {
    if (_todos.isEmpty) return 0;
    final completed = _todos.where((item) => item['status'] == true).length;
    return completed / _todos.length;
  }

  Future<void> fetchTodos(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(
        '/me/current-todos',
        headers: {'Authorization': 'Bearer $token'},
      );
      _todos = response;
    } catch (e) {
      debugPrint('Error fetch todos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTodoStatus(
    String token,
    String todoId,
    bool currentStatus,
  ) async {
    // Optimistic Update: Ubah di UI dulu biar terasa cepat
    final index = _todos.indexWhere((t) => t['id'] == todoId);
    if (index != -1) {
      _todos[index]['status'] = !currentStatus;
      notifyListeners();
    }

    try {
      await ApiClient.put(
        '/todos/$todoId',
        headers: {'Authorization': 'Bearer $token'},
        body: {'status': !currentStatus},
      );
    } catch (e) {
      if (index != -1) {
        _todos[index]['status'] = currentStatus;
        notifyListeners();
      }
      debugPrint('Error update todo: $e');
    }
  }
}
