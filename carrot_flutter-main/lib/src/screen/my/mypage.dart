import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import 'change_password.dart';
import 'my_info_page.dart';
import 'webpage.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final authController = Get.put<AuthController>(AuthController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필
            // UserMypage(UserModel(id: 1, name: '홍길동')),
            // Obx(
            //   () {
            //     if (userController.my.value == null) {
            //       return const CircularProgressIndicator();
            //     } else {
            //       return UserMypage(userController.my.value!);
            //     }
            //   },
            // ),

            // 기타메뉴
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '마이페이지',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            ListTile(
              title: const Text('내 정보 확인'),
              onTap: () {
                Get.to(() => MyInfoPage());
              },
              leading: const Icon(Icons.account_circle),
            ),
            ListTile(
              title: const Text('비밀번호 변경'),
              onTap: () {
                Get.to(() => const ChangePasswordPage());
              },
              leading: const Icon(Icons.key),
            ),
            ListTile(
              title: const Text('로그아웃'),
              onTap: () {
                authController.logout();
              },
              leading: const Icon(Icons.logout_outlined),
            ),
            const Divider(),
            ListTile(
              title: const Text('이용약관'),
              onTap: () {
                Get.to(() => const WebPage('이용약관', '/page/terms'));
              },
            ),
            ListTile(
              title: const Text('개인정보 처리방침'),
              onTap: () {
                Get.to(() => const WebPage('개인정보 처리방침', '/page/policy'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
