import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<String?> login(String username, String password) async {
    final response = await _apiService.postRequestWithoutToken('users/login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // 토큰 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return data['token'];
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> register(String username, String password) async {
    final response =
        await _apiService.postRequestWithoutToken('users/register', {
      'username': username,
      'password': password,
    });

    return response.statusCode == 201;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
