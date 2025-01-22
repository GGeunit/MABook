import 'package:get/get.dart';

import 'provider.dart';

class ExpenseProvider extends Provider {
  Future<Map> index([int page = 1]) async {
    Response response = await get(
      '/api/expense',
      query: {'page': '$page'},
    );
    return response.body;
  }

  Future<Map> store(
    int categoryId,
    String description,
    String price,
    String date,
  ) async {
    final Map<String, dynamic> body = {
      'categoryId': categoryId,
      'description': description,
      'price': price,
      'date': date,
    };
    final response = await post('/api/expense', body);
    return response.body;
  }

  Future<Map> update(
    int id,
    int categoryId,
    String description,
    String price,
    String date,
  ) async {
    final Map<String, dynamic> body = {
      'categoryId': categoryId,
      'description': description,
      'price': price,
      'date': date,
    };
    final response = await put('/api/expense/$id', body);
    return response.body;
  }

  Future<Map> show(int id) async {
    final response = await get('/api/expense/$id');
    return response.body;
  }

  Future<Map> destroy(int id) async {
    final response = await delete('/api/expense/$id');
    return response.body;
  }
}
