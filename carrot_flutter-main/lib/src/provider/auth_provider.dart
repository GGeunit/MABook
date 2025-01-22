import 'provider.dart';

class AuthProvider extends Provider {
<<<<<<< HEAD
  

  Future<Map> login(String user_id, String password) async {
    final response = await post('/user/login', {
      'user_id': user_id,
=======
  Future<Map> login(String userId, String password) async {
    final response = await post('/user/login', {
      'userId': userId,
>>>>>>> cb14c44f45d442c68ffb7a5f007fcddf52603efe
      'password': password,
    });
    return response.body;
  }

<<<<<<< HEAD
  Future<Map> register(String user_id, String password, String name,) async {
    final response = await post('/user/register', {
      'user_id': user_id,
=======
  Future<Map> register(String userId, String password, String name) async {
    final response = await post('/user/register', {
      'userId': userId,
>>>>>>> cb14c44f45d442c68ffb7a5f007fcddf52603efe
      'password': password,
      'name': name,
    });
    return response.body;
  }
}