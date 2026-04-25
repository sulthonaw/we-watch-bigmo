import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiClient {
  static const baseUrl = 'https://hackfest.iccn.or.id';

  static Future<dynamic> get(
    String path, {
    Map<String, String>? headers,
  }) async {
    final res = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }

    throw Exception('Failed request: ${res.statusCode} - ${res.body}');
  }

  static Future<dynamic> post(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    }

    throw Exception('Failed request: ${res.statusCode} - ${res.body}');
  }

  static Future<dynamic> put(
    String path, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final res = await http.put(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200 || res.statusCode == 204) {
      return res.body.isNotEmpty ? jsonDecode(res.body) : {};
    }

    throw Exception('Failed request: ${res.statusCode} - ${res.body}');
  }
}
