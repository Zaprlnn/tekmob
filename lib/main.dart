import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ui_coffee_shop_2/common/app_colors.dart';
import 'package:flutter_ui_coffee_shop_2/models/coffee.dart';
import 'package:flutter_ui_coffee_shop_2/providers/cart_provider.dart';
import 'package:flutter_ui_coffee_shop_2/providers/favorites_provider.dart';
import 'package:flutter_ui_coffee_shop_2/providers/notification_provider.dart'; // Import ini sudah benar
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Pages
import 'package:flutter_ui_coffee_shop_2/auth/signin_page.dart';
import 'package:flutter_ui_coffee_shop_2/auth/signup_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/cart_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/complete_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/dashboard_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/detail_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/edit_profile_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/notification_page.dart';
import 'package:flutter_ui_coffee_shop_2/pages/onboarding_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        // DIUBAH: Menambahkan NotificationProvider yang hilang
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoardingPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/cart': (context) => const CartPage(),
        '/notification': (context) => const NotificationPage(),
        '/complete': (context) => const CompletePage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/detail': (context) {
          final coffee = ModalRoute.of(context)?.settings.arguments as Coffee?;
          if (coffee == null) {
            return const Scaffold(
              body: Center(
                child: Text("Error: Coffee data not found."),
              ),
            );
          }
          return DetailPage(coffee: coffee);
        },
      },
    );
  }
}