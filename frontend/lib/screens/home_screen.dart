import 'package:flutter/material.dart';
import 'account_screen.dart';
import 'expense_screen.dart';
import 'regular_expense_screen.dart';
import 'goal_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountScreen()),
                );
              },
              child: Text('Manage Accounts'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpenseScreen()),
                );
              },
              child: Text('Manage Expenses'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegularExpenseScreen()),
                );
              },
              child: Text('Manage Regular Expenses'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoalScreen()),
                );
              },
              child: Text('Manage Goals'),
            ),
          ],
        ),
      ),
    );
  }
}
