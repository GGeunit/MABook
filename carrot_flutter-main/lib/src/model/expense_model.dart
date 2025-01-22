import 'package:carrot_flutter/src/model/user_model.dart';


class ExpenseModel {
  late int id;
  late int userId;
  late int categoryId;
  late String description;
  late double? price;
  late DateTime date;

  
  ExpenseModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.date,
  });

  ExpenseModel.parse(Map m) {
    id = m['id'];
    userId = m['userId'];
    categoryId = m['categoryId'];
    description = m['description'];
    price = m['price'];
    date = DateTime.parse(m['date']);
  }

  ExpenseModel copyWith({
    int? id,
    String? title,
    String? content,
    int? price,
    int? imageId,
    DateTime? createdAt,
    bool? isMe,
    UserModel? writer,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      description: description ?? this.description,
      date: date ?? this.date,
      
    );
  }
}
