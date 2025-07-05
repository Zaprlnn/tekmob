
import 'package:flutter_ui_coffee_shop_2/pages/fragments/home_fragment.dart';
import 'package:flutter_ui_coffee_shop_2/pages/favorites_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/notification_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/edit_profile_page.dart';

class AppConstants {
  static const categories = [
    'All Coffees',
    'Original',
    'Non-Coffee',
  ];

  static final menuBottomNav = <Map<String, dynamic>>[
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
      'ui': FavoritesPage(),
    },
    {
      'label': 'Notification',
      'icon_on': 'assets/icons/notification.png',
      'icon_off': 'assets/icons/notification.png',
      'ui': NotificationPage(),
    },
    {
      'label': 'Account',
      'icon_on': 'assets/icons/account.png',
      'icon_off': 'assets/icons/account.png',
      'ui': EditProfilePage(),
    },
  ];
}
