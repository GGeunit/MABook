import 'provider.dart';

class AuthProvider extends Provider {
  

  Future<Map> login(String user_id, String password) async {
    final response = await post('/user/login', {
      'user_id': user_id,
      'password': password,
    });
    return response.body;
  }

  Future<Map> register(String user_id, String password, String name,) async {
    final response = await post('/user/register', {
      'user_id': user_id,
      'password': password,
      'name': name,
    });
    return response.body;
  }
}