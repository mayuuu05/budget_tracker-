import 'package:flutter/material.dart';
import 'package:get/get.dart';


class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/money-hands-coins-digiday-unscreen.gif',
              height: screenHeight * 0.3,
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              'Welcome to BudgetBuddy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.w900,
                color: const Color(0xffb43b28),
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Take control of your finances with BudgetBuddy. Track your expenses, manage your savings, and achieve your financial goals effortlessly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffb43b28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                 Get.toNamed('/login');
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
