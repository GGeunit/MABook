import 'package:carrot_flutter/src/model/expense_model.dart';
import 'package:get/get.dart';

import '../provider/expense_provider.dart';

class ExpenseController extends GetxController {
  final expenseProvider = Get.put(ExpenseProvider());
  final RxList<ExpenseModel> expenseList = <ExpenseModel>[].obs;
  final Rx<ExpenseModel?> currentExpense = Rx<ExpenseModel?>(null);

  Future<void> expenseIndex({int page = 1}) async {
    Map json = await expenseProvider.index(page);
    List<ExpenseModel> tmp =
        json['data'].map<ExpenseModel>((m) => ExpenseModel.parse(m)).toList();
    (page == 1) ? expenseList.assignAll(tmp) : expenseList.addAll(tmp);
  }

  Future<bool> expenseCreate(
      int categoryId, String description, String price, String date) async {
    Map body =
        await expenseProvider.store(categoryId, description, price, date);
    if (body['result'] == 'ok') {
      await expenseIndex();
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<bool> expenseUpdate(int id, int categoryId, String description,
      String price, String date) async {
    Map body =
        await expenseProvider.update(id, categoryId, description, price, date);
    if (body['result'] == 'ok') {
      int index = expenseList.indexWhere((expense) => expense.id == id);
      if (index != -1) {
        ExpenseModel updatedExpense = ExpenseModel(
          id: id,
          userId: expenseList[index].userId,
          categoryId: categoryId,
          description: description,
          price: double.tryParse(price),
          date: DateTime.parse(date),
        );
        expenseList[index] = updatedExpense;
      }
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> expenseShow(int id) async {
    Map body = await expenseProvider.show(id);
    if (body['result'] == 'ok') {
      currentExpense.value = ExpenseModel.parse(body['data']);
    } else {
      Get.snackbar('조회 에러', body['message'],
          snackPosition: SnackPosition.BOTTOM);
      currentExpense.value = null;
    }
  }

  Future<bool> expenseDelete(int id) async {
    Map body = await expenseProvider.destroy(id);
    if (body['result'] == 'ok') {
      expenseList.removeWhere((expense) => expense.id == id);
      return true;
    }
    Get.snackbar('삭제 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
