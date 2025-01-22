import 'package:carrot_flutter/src/model/category.dart';
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
    CategoryModel category,
    String description,
    String price,
    String date,
  ) async {
    try {
      final Map<String, dynamic> body = {
        'category': {
          'id': category.id.toString(),
          'name': category.name,
        },
        'description': description,
        'price': price,
        'date': date,
      };
      final response = await post('/api/expense', body);
      return response.body ?? {'result': 'fail', 'message': '응답이 없습니다.'};
    } catch (e) {
      return {'result': 'fail', 'message': '오류가 발생했습니다: $e'};
    }
  }

  Future<Map> update(
    int id,
    CategoryModel category,
    String description,
    String price,
    String date,
  ) async {
    final Map<String, dynamic> body = {
      'category': {
        'id': category.id,
        'name': category.name,
      },
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
