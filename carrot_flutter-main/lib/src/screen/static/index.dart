import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/expense_controller.dart';
import '../../widget/listitem/expense_list_item.dart';

class StaticIndex extends StatefulWidget {
  const StaticIndex({super.key});
  @override
  State<StaticIndex> createState() => _StaticIndexState();
}

class _StaticIndexState extends State<StaticIndex> {
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
          '지출 통계',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
