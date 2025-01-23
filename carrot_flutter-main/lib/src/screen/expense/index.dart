import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expense_controller.dart';
import '../../widget/listitem/expense_list_item.dart';
import 'create.dart';

class ExpenseIndex extends StatefulWidget {
  const ExpenseIndex({super.key});
  @override
  State<ExpenseIndex> createState() => _ExpenseIndexState();
}

class _ExpenseIndexState extends State<ExpenseIndex> {
  final ExpenseController expenseController =
      Get.put<ExpenseController>(ExpenseController());
  int _currentPage = 1;

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      expenseController.expenseIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await expenseController.expenseIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          '내 지출',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ExpenseCreate());
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: expenseController.expenseList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = expenseController.expenseList[index];
                        return ExpenseListItem(item);
                      },
                    ),
                  ),
                )),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
