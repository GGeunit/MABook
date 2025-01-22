import 'provider.dart';

class UserProvider extends Provider {
  Future<Map> show() async {
    final response = await get('/user/my');
    return response.body;
  }

  Future<Map> update(String name) async {
    final Map<String, dynamic> body = {
      'name': name,
    };
    // if (image != null) {
    //   body['profile_id'] = image.toString();
    // }
    final response = await put('/user/my', body);
    return response.body;
  }
}
