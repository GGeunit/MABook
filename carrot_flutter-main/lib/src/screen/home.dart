import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'expense/index.dart';
import 'my/mypage.dart';

final List<BottomNavigationBarItem> myTabs = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: '지출',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.feed),
    label: '카테고리',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    label: '마이페이지',
  ),
];
final List<Widget> myTabItems = [
  ExpenseIndex(),
  Center(child: Text('카테고리')),
  MyPage(),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userController = Get.put(UserController());
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    userController.myInfo();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: myTabs,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: myTabItems,
      ),
    );
  }
}
