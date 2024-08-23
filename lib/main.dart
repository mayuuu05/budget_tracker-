
import 'package:budget_tracker/view/home_page.dart';
import 'package:budget_tracker/view/intro.dart';
import 'package:budget_tracker/view/login_page.dart';
import 'package:budget_tracker/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const BudgetTracker());
}

class BudgetTracker extends StatelessWidget {
  const BudgetTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen(),),
        GetPage(name: '/intro', page: () => const IntroScreen(),),
        GetPage(name: '/login', page: () => const LoginPage(),),
        GetPage(name: '/home', page: () => const HomePage(),),
      ],
    );
  }
}

