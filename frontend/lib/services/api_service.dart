import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000';

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map<String, String>> getHeaders() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('Token is null');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Future<http.Response> getRequest(String endpoint) async {
    return await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await getHeaders(),
    );
  }

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await getHeaders(),
      body: jsonEncode(data),
    );
  }

  Future<http.Response> postRequestWithoutToken(
      String endpoint, Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  Future<http.Response> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await getHeaders(),
      body: jsonEncode(data),
    );
  }

  Future<http.Response> deleteRequest(String endpoint) async {
    return await http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: await getHeaders(),
    );
  }
}
