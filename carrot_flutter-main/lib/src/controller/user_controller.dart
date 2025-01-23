import 'package:get/get.dart';

import '../model/user_model.dart';
import '../provider/user_provider.dart';

class UserController extends GetxController {
  final provider = Get.put(UserProvider());
  final Rx<UserModel?> my = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    myInfo();
  }

  Future<void> myInfo() async {
    Map body = await provider.show();
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return;
    }
    Get.snackbar('회원 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
  }

  Future<bool> updateInfo(String name, int? image) async {
    Map body = await provider.update(name, image);
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    Map body = await provider.changePassword(currentPassword, newPassword);
    if (body['result'] == 'ok') {
      Get.snackbar('성공', '비밀번호가 변경되었습니다.', snackPosition: SnackPosition.BOTTOM);
      return true;
    }
    Get.snackbar('변경 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
