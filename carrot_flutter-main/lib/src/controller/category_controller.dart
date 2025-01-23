import 'package:carrot_flutter/src/model/category.dart';
import 'package:carrot_flutter/src/model/expense_model.dart';
import 'package:carrot_flutter/src/provider/category_provider.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';

class CategoryController extends GetxController {
  final RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  final RxMap<int, List<ExpenseModel>> categoryExpenses = <int, List<ExpenseModel>>{}.obs; // Map for category-wise expenses

  final categoryProvider = Get.put(CategoryProvider());

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

void fetchCategories() async {
  try {
    print('Fetching categories...');
    Map body = await categoryProvider.show();
    print('Response: $body');
    if (body['result'] == 'ok') {
      var data = body['data'];
      print('Data type: ${data.runtimeType}');
      if (data is List) {
        categoryList.assignAll(data.map<CategoryModel>((m) => CategoryModel.parse(m)).toList());
        print('Categories loaded: ${categoryList.length}');
      } else if (data is Map) {
        // Map을 List로 변환
        List<dynamic> dataList = [data];
        categoryList.assignAll(dataList.map<CategoryModel>((m) => CategoryModel.parse(m)).toList());
        print('Categories loaded: ${categoryList.length}');
      } else {
        print('Error: data is not a List or Map');
        Get.snackbar('Error', 'Data format is incorrect');
      }
    } else {
      Get.snackbar('Error', body['message']);
    }
  } catch (e) {
    print('Error fetching categories: $e');
    Get.snackbar('Error', 'Failed to load categories');
  }
}


  void fetchExpensesByCategory(int categoryId) async {
  try {
    print('Fetching expenses for category $categoryId...');
    var expenseData = await categoryProvider.getExpensesByCategory(categoryId);
    print('Expense data: $expenseData');
    categoryExpenses[categoryId] = expenseData;
    categoryExpenses.refresh(); // Refresh to update the UI
  } catch (e) {
    print('Error fetching expenses for category $categoryId: $e');
    Get.snackbar('Error', 'Failed to load expenses for category $categoryId: $e');
  }
}

  double calculateTotal(int categoryId) {
    if (!categoryExpenses.containsKey(categoryId)) return 0.0;
    return categoryExpenses[categoryId]!.fold(0.0, (sum, expense) => sum + (expense.price ?? 0.0));
  }
}