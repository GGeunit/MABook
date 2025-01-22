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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const ExpenseCreate());
        },
        tooltip: '항목 추가',
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text('내 지출'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(() => NotificationListener<ScrollNotification>(
                    onNotification: _onNotification,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                          itemCount: expenseController.expenseList.length,
                          itemBuilder: (context, index) {
                            final item = expenseController.expenseList[index];
                            return ExpenseListItem(item);
                          }),
                    ),
                  )))
        ],
      ),
    );
  }
}
