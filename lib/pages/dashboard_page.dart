import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_constants.dart';
import 'package:flutter_ui_coffee_shop_2/pages/fragments/home_fragment.dart';
import 'package:flutter_ui_coffee_shop_2/pages/favorites_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/notification_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/edit_profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  // Buat daftar halaman
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeFragment(
        onProfileTap: () {
          setState(() {
            _currentIndex = 3; // pindah ke halaman Edit Profile
          });
        },
      ),
      FavoritesPage(),
      const NotificationPage(),
      const EditProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -3),
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: AppConstants.menuBottomNav.map((item) {
          return BottomNavigationBarItem(
            label: item['label'] as String,
            icon: ImageIcon(AssetImage(item['icon_off']), size: 24),
            activeIcon: ImageIcon(AssetImage(item['icon_on']), size: 24),
          );
        }).toList(),
      ),
    );
  }
}
