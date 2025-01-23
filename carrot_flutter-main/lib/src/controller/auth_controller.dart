import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../provider/auth_provider.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  final authProvider = Get.put(AuthProvider());

  Future<bool> login(String user_id, String password) async {
    Map body = await authProvider.login(user_id, password);
    if (body['result'] == 'ok') {
      String token = body['access_token'];
      log("token : $token");
      // Global.accessToken = body['access_token'];
      await box.write('access_token', token);
      return true;
    }
    Get.snackbar('로그인 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<bool> register(String userId, String password, String name) async {
    Map body = await authProvider.register(userId, password, name);
    if (body['result'] == 'ok') {
      String token = body['access_token'];
      log("token : $token");
      await box.write('access_token', token);
      return true;
    }
    Get.snackbar('회원가입 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> logout() async {
    Map body = await authProvider.logout();
    if (body['result'] == 'ok') {
      await box.remove('access_token');
      Get.offAllNamed('/intro');
    } else {
      Get.snackbar('로그아웃 에러', body['message'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
