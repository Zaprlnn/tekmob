import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_constants.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppConstants.menuBottomNav[_currentIndex]['ui'],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.grey.shade300,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          _currentIndex = value;
          setState(() {});
        },
        items: AppConstants.menuBottomNav.map((e) {
          return BottomNavigationBarItem(
            label: e['label'],
            icon: ImageIcon(
              AssetImage(e['icon_off']),
              size: 24,
            ),
            activeIcon: ImageIcon(
              AssetImage(e['icon_on']),
              size: 24,
            ),
          );
        }).toList(),
      ),
    );
  }
}
