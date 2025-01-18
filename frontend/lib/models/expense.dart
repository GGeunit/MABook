class Expense {
  final int id;
  final int accountId;
  final int amount;
  final String description;
  final String date;

  Expense({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      accountId: json['account_id'],
      amount: json['amount'],
      description: json['description'],
      date: json['date'],
    );
  }
}
