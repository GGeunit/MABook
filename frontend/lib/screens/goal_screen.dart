import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../services/api_service.dart';

class GoalScreen extends StatefulWidget {
  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  final ApiService _apiService = ApiService();
  List<Goal> _goals = [];

  @override
  void initState() {
    super.initState();
    _fetchGoals();
  }

  void _fetchGoals() async {
    final response = await _apiService.getRequest('goals');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.body as List<dynamic>;
      setState(() {
        _goals = data.map((json) => Goal.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goals')),
      body: ListView.builder(
        itemCount: _goals.length,
        itemBuilder: (context, index) {
          final goal = _goals[index];
          return ListTile(
            title: Text(goal.description),
            subtitle: Text('Target Amount: ${goal.targetAmount}'),
          );
        },
      ),
    );
  }
}
