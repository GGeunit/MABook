import 'provider.dart';

class AuthProvider extends Provider {
  Future<Map> login(String userId, String password) async {
    final response = await post('/user/login', {
      'userId': userId,
      'password': password,
    });
    return response.body;
  }

  Future<Map> register(String userId, String password, String name) async {
    final response = await post('/user/register', {
      'userId': userId,
      'password': password,
      'name': name,
    });
    return response.body;
  }
}
