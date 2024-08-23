
import 'package:budget_tracker/view/income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/budget_controller.dart';
import '../controller/navigate.dart';
import 'dashboard.dart';
import 'expense.dart';
import 'home_content..dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.put(NavigationController());
    final HomeController homeController = Get.put(HomeController());


    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.grid_view_rounded, color: Colors.white),
        ),
        title: const Text(
          'BudgetBuddy',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.settings,color: Colors.white,))
        ],
        backgroundColor: const Color(0xffb43b28),
        elevation: 0,
      ),
      body: Obx(() => IndexedStack(
        index: navController.selectedIndex.value,
        children: [ HomeContent(),
          const DashboardPage(),
          Income(),
          Expense(),]
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xffb43b28),
        unselectedItemColor: Colors.black54,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: navController.selectedIndex.value,
        onTap: navController.changeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Expense',
          ),

        ],
      ),)

    );
  }
}



