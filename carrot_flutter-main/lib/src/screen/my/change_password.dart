import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/user_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 변경'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: const InputDecoration(labelText: '현재 비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: '새 비밀번호'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: confirmNewPasswordController,
              decoration: const InputDecoration(labelText: '새 비밀번호 확인'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (newPasswordController.text !=
                    confirmNewPasswordController.text) {
                  Get.snackbar('오류', '새 비밀번호가 일치하지 않습니다.');
                  return;
                }

                print(
                    'Current Password: ${currentPasswordController.text}'); // 디버깅 로그
                print('New Password: ${newPasswordController.text}'); // 디버깅 로그

                bool success = await userController.changePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                );
                if (success) {
                  Get.snackbar('성공', '비밀번호가 변경되었습니다.');
                } else {
                  Get.snackbar('오류', '비밀번호 변경에 실패했습니다.');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('비밀번호 변경'),
            ),
          ],
        ),
      ),
    );
  }
}
