import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/expense_controller.dart';
import '../../model/category.dart';
import '../../model/expense_model.dart';
import '../../widget/form/label_textfield.dart';

class ExpenseEdit extends StatefulWidget {
  final ExpenseModel model;
  const ExpenseEdit(this.model, {super.key});
  @override
  State<ExpenseEdit> createState() => _ExpenseEditState();
}

class _ExpenseEditState extends State<ExpenseEdit> {
  final expenseController = Get.put(ExpenseController());
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _dateController = TextEditingController();
  late CategoryModel _selectedCategory;

  _submit() async {
    try {
      DateTime.parse(_dateController.text);
    } catch (e) {
      Get.snackbar(
        '날짜 오류',
        '올바른 날짜 형식(YYYY-MM-DD)으로 입력해주세요.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final result = await expenseController.expenseUpdate(
      widget.model.id,
      _selectedCategory,
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
    _selectedCategory = widget.model.category;
    _descriptionController.text = widget.model.description;
    _priceController.text = widget.model.price.toString();
    _dateController.text = DateFormat('yyyy-MM-dd').format(widget.model.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 지출 수정'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // 카테고리 드롭다운
                  DropdownButton<CategoryModel>(
                    value: _selectedCategory,
                    onChanged: (CategoryModel? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: [
                      CategoryModel(id: 1, name: '식비'),
                      CategoryModel(id: 2, name: '교통비'),
                      CategoryModel(id: 3, name: '기타'),
                    ].map<DropdownMenuItem<CategoryModel>>(
                        (CategoryModel category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  // 설명
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
