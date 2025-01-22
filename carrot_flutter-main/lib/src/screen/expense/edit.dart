import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expense_controller.dart';
import '../../controller/file_controller.dart';
import '../../model/expense_model.dart';
import '../../widget/button/expense_image.dart';
import '../../widget/form/label_textfield.dart';

class ExpenseEdit extends StatefulWidget {
  final ExpenseModel model;
  const ExpenseEdit(this.model, {super.key});
  @override
  State<ExpenseEdit> createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit> {
  final expenseController = Get.put(ExpenseController());
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();

  _submit() async {
    final result = await expenseController.expenseUpdate(
      widget.model.id,
      _categoryController.text as int,
      _descriptionController.text,
      _priceController.text,
      _dateController.text,
    );
    if (result) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
// 초기화 이후 TextField에 값을 채워주기 위한 작업
    _categoryController.text = widget.model.categoryId.toString();
    _descriptionController.text = widget.model.description;
    _priceController.text = widget.model.price.toString();
    _dateController.text = widget.model.date.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 지출 수정')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 카테고리
                  LabelTextField(
                    label: '카테고리',
                    hintText: '카테고리',
                    controller: _categoryController,
                  ), // 설명
                  LabelTextField(
                    label: '설명',
                    hintText: '설명을 입력하세요',
                    controller: _descriptionController,
                    maxLines: 6,
                  ),
                  // 금액
                  LabelTextField(
                    label: '금액',
                    hintText: '금액을 입력해주세요.',
                    controller: _priceController,
                  ),
                  // 날짜
                  LabelTextField(
                    label: '날짜',
                    hintText: '날짜를 입력하세요',
                    controller: _dateController,
                    maxLines: 6,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
