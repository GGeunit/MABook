import 'package:carrot_flutter/src/model/user_model.dart';

class ExpenseModel {
  late int id;
  late int categoryId;
  late String description;
  late double? price;
  late DateTime date;

  ExpenseModel({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.date,
  });

  ExpenseModel.parse(Map m) {
    id = m['id'];
    categoryId = m['categoryId'];
    description = m['description'];
    price = m['price'];
    date = DateTime.parse(m['date']);
  }

  ExpenseModel copyWith({
    int? id,
    double? price,
    required int categoryId,
    required String description,
    required date,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
