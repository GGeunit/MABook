import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/expense_controller.dart';

class ExpenseShow extends StatefulWidget {
  final int expenseId;
  const ExpenseShow(this.expenseId, {super.key});

  @override
  State<ExpenseShow> createState() => _ExpenseShowState();
}

class _ExpenseShowState extends State<ExpenseShow> {
  final ExpenseController expenseController = Get.find<ExpenseController>();

  @override
  void initState() {
    super.initState();
    expenseController.expenseShow(widget.expenseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          '지출 상세',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final expense = expenseController.currentExpense.value;
        if (expense != null) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '카테고리',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      expense.category.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Divider(height: 24, thickness: 1),
                    Text(
                      '설명',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      expense.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const Divider(height: 24, thickness: 1),
                    Text(
                      '가격',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(expense.price)}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Divider(height: 24, thickness: 1),
                    Text(
                      '날짜',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('yyyy-MM-dd').format(expense.date),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
