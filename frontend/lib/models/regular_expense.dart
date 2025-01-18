class RegularExpense {
  final int id;
  final int accountId;
  final int amount;
  final String description;
  final int dayOfMonth;

  RegularExpense({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.dayOfMonth,
  });

  factory RegularExpense.fromJson(Map<String, dynamic> json) {
    return RegularExpense(
      id: json['id'],
      accountId: json['account_id'],
      amount: json['amount'],
      description: json['description'],
      dayOfMonth: json['day_of_month'],
    );
  }
}
