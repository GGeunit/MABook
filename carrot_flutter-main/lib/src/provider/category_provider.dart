import 'package:carrot_flutter/src/model/category.dart';
import 'package:carrot_flutter/src/model/expense_model.dart';
import 'package:carrot_flutter/src/provider/provider.dart';
import 'package:get/get.dart';

class CategoryProvider extends Provider {
  Future<Map> show() async {
    final response = await get('/api/category');
    return response.body;
  }

  Future<List<ExpenseModel>> getExpensesByCategory(int categoryId) async {
    try {
      final response = await get('/api/category/$categoryId/expenses');
      if (response.statusCode == 200) {
        var body = response.body;
        print('Response body: $body');
        if (body == null) {
          throw Exception('Response body is null');
        }
        if (body['data'] == null) {
          throw Exception('Response body data is null');
        }
        var data = body['data'];
        print('Data type: ${data.runtimeType}');
        if (data is List) {
          return data.map((e) => ExpenseModel.parse(e)).toList();
        } else if (data is Map) {
          // Map을 List로 변환
          List<dynamic> dataList = [data];
          return dataList.map((e) => ExpenseModel.parse(e)).toList();
        } else {
          throw Exception('Data format is incorrect');
        }
      } else {
        throw Exception('Failed to load expenses for category $categoryId');
      }
    } catch (e) {
      print('Error fetching expenses: $e');
      throw Exception('Error fetching expenses: $e');
    }
  }

  Future<CategoryModel> getCategoryById(int categoryId) async {
    try {
      final response = await get('/api/category/$categoryId');
      if (response.statusCode == 200) {
        if (response.body is Map) {
          return CategoryModel.parse(response.body);
        } else {
          throw Exception('Invalid response format: Expected Map');
        }
      } else {
        throw Exception('Failed to load category with ID $categoryId');
      }
    } catch (e) {
      throw Exception('Error fetching category: $e');
    }
  }
}
