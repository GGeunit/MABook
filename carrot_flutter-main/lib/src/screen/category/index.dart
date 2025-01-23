import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carrot_flutter/src/controller/category_controller.dart';

class CategoryIndex extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카테고리별 지출현황'),
      ),
      body: Obx(() {
        if (categoryController.categoryList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) {
            final category = categoryController.categoryList[index];
            final categoryId = category.id;
            final expenses = categoryController.categoryExpenses[categoryId] ?? [];
            final total = categoryController.calculateTotal(categoryId);

            return ExpansionTile(
              title: Text(category.name),
              subtitle: Text('Total: ${total.toStringAsFixed(2)}원'),
              children: expenses.map((expense) {
                return ListTile(
                  title: Text(expense.description),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${expense.price?.toStringAsFixed(2) ?? '0.00'}'),
                      Text('Date: ${expense.date.toString()}'),
                    ],
                  ),
                );
              }).toList(),
              onExpansionChanged: (expanded) {
                if (expanded) {
                  categoryController.fetchExpensesByCategory(categoryId);
                }
              },
            );
          },
        );
      }),
    );
  }
}