import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Get.offAllNamed('/intro');
    });
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/money-hands-coins-digiday-unscreen.gif',
              height: screenHeight * 0.3,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xffb43b28), Color(0xfff16f43)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                'BudgetBuddy',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: screenWidth * 0.09,
                  letterSpacing: 2.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 0.0),
                      blurRadius: 4.0,
                      color: Colors.black26,
                    ),
                    Shadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
