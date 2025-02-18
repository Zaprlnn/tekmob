import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/pages/fragments/home_fragment.dart';

class AppConstants {
  static const categories = [
    'All Coffees',
    'Original',
    'Decaf Coffee',
    'Special'
  ];
  static const menuBottomNav = <Map<String, dynamic>>[
    {
      'label': 'Home',
      'icon_on': 'assets/icons/home-bold.png',
      'icon_off': 'assets/icons/home.png',
      'ui': HomeFragment(),
    },
    {
      'label': 'Favorite',
      'icon_on': 'assets/icons/heart.png',
      'icon_off': 'assets/icons/heart.png',
      'ui': Center(child: Text('Favorite')),
    },
    {
      'label': 'Notification',
      'icon_on': 'assets/icons/notification.png',
      'icon_off': 'assets/icons/notification.png',
      'ui': Center(child: Text('Notification')),
    },
    {
      'label': 'Account',
      'icon_on': 'assets/icons/account.png',
      'icon_off': 'assets/icons/account.png',
      'ui': Center(child: Text('Account')),
    },
  ];
}
