import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../controller/expense_controller.dart';
import '../../widget/listitem/user_list_item.dart';

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

  _chat() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          // slivers: [
          //   Obx(() {
          //     final expense = expenseController.currentExpense.value;
          //     return SliverAppBar(
          //       expandedHeight: MediaQuery.of(context).size.height / 3,
          //       pinned: true,
          //       flexibleSpace: FlexibleSpaceBar(
          //         background: expense != null
          //             ? Image.network(expense.imageUrl, fit: BoxFit.cover)
          //             : null,
          //       ),
          //     );
          //   }),
          //   SliverFillRemaining(
          //     hasScrollBody: true,
          //     child: Obx(() {
          //       if (expenseController.currentExpense.value != null) {
          //         final textTheme = Theme.of(context).textTheme;
          //         return SingleChildScrollView(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               UserListItem(
          //                   expenseController.currentExpense.value!.writer!),
          //               Padding(
          //                 padding: const EdgeInsets.all(16.0),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       expenseController.currentExpense.value!.title,
          //                       style: textTheme.bodyLarge,
          //                     ),
          //                     const SizedBox(height: 12),
          //                     Text(
          //                       TimeUtil.parse(expenseController
          //                           .currentExpense.value!.createdAt),
          //                       style: textTheme.bodyMedium
          //                           ?.copyWith(color: Colors.grey),
          //                     ),
          //                     const SizedBox(height: 12),
          //                     Text(
          //                       expenseController.currentExpense.value!.content,
          //                       style: textTheme.bodyMedium,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       } else {
          //         return const Center(child: CircularProgressIndicator());
          //       }
          //     }),
          //   ),
          // ],
          ),
      bottomNavigationBar: Obx(
        () {
          return Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200))),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${expenseController.currentExpense.value?.price} 원",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onPressed: _chat,
                    child: const Text("채팅하기"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
