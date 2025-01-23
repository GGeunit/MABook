import 'provider.dart';

class UserProvider extends Provider {
  Future<Map> show() async {
    final response = await get('/api/user/my');
    return response.body;
  }

  Future<Map> update(String name, int? image) async {
    final Map<String, dynamic> body = {
      'name': name,
    };
    if (image != null) {
      body['profile_id'] = image.toString();
    }
    final response = await put('/api/user/my', body);
    return response.body;
  }

  Future<Map> changePassword(String currentPassword, String newPassword) async {
    final Map<String, dynamic> body = {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
    final response = await put('/user/change-password', body);

    if (response.body != null) {
      return response.body;
    } else {
      return {'result': 'fail', 'message': '서버 응답이 없습니다.'};
    }
  }
}
