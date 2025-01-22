import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../widget/form/label_textfield.dart';
import '../home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final authController = Get.put(AuthController());
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  _submit() async {
    bool result = await authController.login(
      _idController.text,
      _passwordController.text,
    );
    if (result) {
      Get.offAll(() => const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            LabelTextField(
              label: '아이디',
              hintText: '아이디를 입력해주세요',
              controller: _idController,
            ),
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요',
              controller: _passwordController,
              isObscure: true,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
