import 'package:carrot_flutter/src/controller/expense_controller.dart';
import 'package:carrot_flutter/src/model/category.dart';
import 'package:carrot_flutter/src/widget/form/label_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseCreate extends StatefulWidget {
  const ExpenseCreate({super.key});

  @override
  State<ExpenseCreate> createState() => _ExpenseCreateState();
}

class _ExpenseCreateState extends State<ExpenseCreate> {
  final expenseController = Get.put(ExpenseController());
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  int _categoryId = 1; // 기본 카테고리 ID

  _submit() async {
    CategoryModel selectedCategory =
        CategoryModel(id: _categoryId, name: '카테고리 $_categoryId');

    final result = await expenseController.expenseCreate(
      _categoryId as CategoryModel,
      _descriptionController.text,
      _priceController.text,
      _dateController.text,
    );
    if (result) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 지출 등록')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // 카테고리 선택 (드롭다운 또는 다른 위젯으로 구현 필요)
                  DropdownButton<int>(
                    value: _categoryId,
                    onChanged: (int? newValue) {
                      setState(() {
                        _categoryId = newValue!;
                      });
                    },
                    items: <int>[1, 2, 3, 4, 5]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('카테고리 $value'),
                      );
                    }).toList(),
                  ),
                  // 설명
                  LabelTextField(
                    label: '설명',
                    hintText: '지출에 대한 설명을 입력하세요',
                    controller: _descriptionController,
                  ),
                  // 가격
                  LabelTextField(
                    label: '가격',
                    hintText: '가격을 입력해주세요.',
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                  ),
                  // 날짜
                  LabelTextField(
                    label: '날짜',
                    hintText: 'YYYY-MM-DD',
                    controller: _dateController,
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
