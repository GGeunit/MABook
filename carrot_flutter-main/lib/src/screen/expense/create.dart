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
  CategoryModel _categoryId =
      CategoryModel(id: 1, name: '카테고리 1'); // 기본 카테고리 ID

  _submit() async {
    final result = await expenseController.expenseCreate(
      _categoryId,
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
      appBar: AppBar(
        title: const Text('내 지출 등록'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        '카테고리',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CategoryModel>(
                        value: _categoryId,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        onChanged: (CategoryModel? newValue) {
                          setState(() {
                            _categoryId = newValue!;
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
                      const SizedBox(height: 24),
                      LabelTextField(
                        label: '설명',
                        hintText: '지출에 대한 설명을 입력하세요',
                        controller: _descriptionController,
                      ),
                      const SizedBox(height: 24),
                      LabelTextField(
                        label: '가격',
                        hintText: '가격을 입력해주세요',
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      LabelTextField(
                        label: '날짜',
                        hintText: 'YYYY-MM-DD',
                        controller: _dateController,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('등록하기'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
