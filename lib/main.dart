import 'package:flutter/material.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:flutter_ui_coffee_shop_2/pages/cart_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/dashboard_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
      ),
      routes: {
        '/': (context) => DashboardPage(),
        '/detail': (context) {
          final coffee = ModalRoute.settingsOf(context)?.arguments as Coffee?;
          if (coffee == null) return Scaffold();
          return DetailPage(coffee: coffee);
        },
        '/cart': (context) => CartPage(),
      },
    );
  }
}
