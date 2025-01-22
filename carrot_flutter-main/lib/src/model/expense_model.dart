import 'category.dart';

class ExpenseModel {
  late int id;
  late CategoryModel category;
  late String description;
  late double? price;
  late DateTime date;

  ExpenseModel({
    required this.id,
    required this.category,
    required this.description,
    required this.price,
    required this.date,
  });

  ExpenseModel.parse(Map m) {
    id = m['id'];
    category = CategoryModel.parse(m['category']);
    description = m['description'];
    price = m['price'] is String
        ? double.tryParse(m['price'])
        : m['price']?.toDouble();
    date = DateTime.parse(m['date']);
  }

  ExpenseModel copyWith({
    int? id,
    double? price,
    required CategoryModel? category,
    required String description,
    required date,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
