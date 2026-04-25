import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:narabuna/services/api_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ConsultationChatViewModel extends ChangeNotifier {
  List<dynamic> _messages = [];
  bool _isLoading = false;
  WebSocketChannel? _channel;

  List<dynamic> get messages => _messages;
  bool get isLoading => _isLoading;

  void connectWebSocket(String token) {
    final url = Uri.parse(
      'wss://hackfest.iccn.or.id/ws/consultation?token=$token',
    );
    _channel = WebSocketChannel.connect(url);

    _channel?.stream.listen(
      (data) {
        final decoded = jsonDecode(data);
        if (decoded['type'] == 'message') {
          final msg = decoded['message'];
          if (msg['senderRole'] != 'USER') {
            _messages.insert(0, {
              'id': msg['id'] ?? DateTime.now().toString(),
              'message': msg['content'],
              'senderRole': msg['senderRole'],
              'createdAt': msg['createdAt'],
            });
            notifyListeners();
          }
        }
      },
      onError: (error) => debugPrint('WS Error: $error'),
      onDone: () => debugPrint('WS Connection Closed'),
    );
  }

  void disconnectWebSocket() {
    _channel?.sink.close();
  }

  Future<void> fetchMessages(String token, String roomId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get(
        '/consultation/rooms/$roomId/messages',
        headers: {'Authorization': 'Bearer $token'},
      );
      _messages = response.reversed.toList();
    } catch (e) {
      debugPrint('Error fetch messages: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendMessage(String text, String roomId) async {
    if (text.isEmpty) return;

    final clientMsgId = DateTime.now().millisecondsSinceEpoch.toString();

    final userMsg = {
      'id': clientMsgId,
      'message': text,
      'senderRole': 'USER',
      'createdAt': DateTime.now().toIso8601String(),
    };

    _messages.insert(0, userMsg);
    notifyListeners();

    if (_channel != null) {
      final payload = {
        "type": "send_message",
        "roomId": roomId,
        "content": text,
        "clientMessageId": clientMsgId,
      };
      _channel!.sink.add(jsonEncode(payload));
    }
  }
}
