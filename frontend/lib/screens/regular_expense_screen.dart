import 'package:flutter/material.dart';
import '../models/regular_expense.dart';
import '../services/api_service.dart';

class RegularExpenseScreen extends StatefulWidget {
  @override
  _RegularExpenseScreenState createState() => _RegularExpenseScreenState();
}

class _RegularExpenseScreenState extends State<RegularExpenseScreen> {
  final ApiService _apiService = ApiService();
  List<RegularExpense> _regularExpenses = [];

  @override
  void initState() {
    super.initState();
    _fetchRegularExpenses();
  }

  void _fetchRegularExpenses() async {
    final response = await _apiService.getRequest('regular-expenses');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.body as List<dynamic>;
      setState(() {
        _regularExpenses =
            data.map((json) => RegularExpense.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Regular Expenses')),
      body: ListView.builder(
        itemCount: _regularExpenses.length,
        itemBuilder: (context, index) {
          final regularExpense = _regularExpenses[index];
          return ListTile(
            title: Text(regularExpense.description),
            subtitle: Text(
                'Amount: ${regularExpense.amount} | Day of Month: ${regularExpense.dayOfMonth}'),
          );
        },
      ),
    );
  }
}
