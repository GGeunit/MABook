import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/user_controller.dart';

class MyInfoPage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  MyInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userController.myInfo(); // 사용자 정보를 불러옵니다.

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보 확인'),
      ),
      body: Obx(
        () {
          if (userController.my.value == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final user = userController.my.value!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // 프로필 사진
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    child: Image.asset('asset/image/logo.png',
                        width: 300, height: 300),
                  ),
                ),
                const SizedBox(height: 16),
                // 사용자 정보 카드
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 28),
                            const SizedBox(width: 8),
                            Text(
                              'ID: ${user.id}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.account_circle, size: 28),
                            const SizedBox(width: 8),
                            Text(
                              'Name: ${user.name}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        // 필요한 경우 추가 사용자 정보 표시
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 16),
                // // 추가 정보
                // Card(
                //   elevation: 4,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(16.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           '추가 정보',
                //           style: Theme.of(context).textTheme.titleMedium,
                //         ),
                //         const SizedBox(height: 8),
                //         Text(
                //           '이곳에 추가 정보를 표시하십시오.',
                //           style: Theme.of(context).textTheme.bodyMedium,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            );
          }
        },
      ),
    );
  }
}
