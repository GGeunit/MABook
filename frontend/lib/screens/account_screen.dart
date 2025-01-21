import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/api_service.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ApiService _apiService = ApiService();
  List<Account> _accounts = [];

  @override
  void initState() {
    super.initState();
    _fetchAccounts();
  }

  void _fetchAccounts() async {
    final response = await _apiService.getRequest('accounts');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.body as List<dynamic>;
      setState(() {
        _accounts = data.map((json) => Account.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accounts')),
      body: ListView.builder(
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          final account = _accounts[index];
          return ListTile(
            title: Text(account.name),
            subtitle: Text('Balance: ${account.balance}'),
          );
        },
      ),
    );
  }
}
