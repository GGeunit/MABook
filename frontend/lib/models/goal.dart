class Goal {
  final int id;
  final int accountId;
  final int targetAmount;
  final String description;

  Goal({
    required this.id,
    required this.accountId,
    required this.targetAmount,
    required this.description,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      accountId: json['account_id'],
      targetAmount: json['target_amount'],
      description: json['description'],
    );
  }
}
