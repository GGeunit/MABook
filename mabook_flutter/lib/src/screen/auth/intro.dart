import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';
import 'register_form.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 로고 & 슬로건 영역
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 로고
                  Image.asset('asset/image/logo.png', width: 300, height: 300),

                  // 슬로건
                  const Text(
                    'MABook 마북',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '스마트한 가계부의 시작',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          //가입, 로그인 버튼 영역
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const RegisterForm());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('시작하기'),
                ),
                // 로그인
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('이미 계정이 있나요?'),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const Login());
                      },
                      child: const Text('로그인',
                          style: TextStyle(color: Colors.green)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
