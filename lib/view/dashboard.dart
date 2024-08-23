import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/budget_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Hello, User!',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffb43b28),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Here is your financial overview for this month.',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              _buildCard(
                context,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOverItem(
                          icon: Icons.attach_money,
                          label: 'Income',
                          amount: controller.totalIncome.value.toString(),
                        ),
                        _buildOverItem(
                          icon: Icons.money_off,
                          label: 'Expenses',
                          amount: controller.totalExpense.value.toString(),
                        ),
                        _buildOverItem(
                          icon: Icons.savings,
                          label: 'Savings',
                          amount: '0',
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildProgressBar(
                      context,
                      label: 'Budget Used',
                      percentage: 60, // Example percentage
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              _buildCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Transactions',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildTransactionItem(
                      icon: Icons.fastfood,
                      label: 'Lunch',
                      amount: '-\$12.00',
                      color: Colors.red,
                    ),
                    _buildTransactionItem(
                      icon: Icons.shopping_bag,
                      label: 'Shopping',
                      amount: '-\$30.00',
                      color: Colors.red,
                    ),
                    _buildTransactionItem(
                      icon: Icons.account_balance_wallet,
                      label: 'Salary',
                      amount: '+\$1500.00',
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              _buildQuote(context, "“Save more, worry less.”"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildOverItem({
    required IconData icon,
    required String label,
    required String amount,
  }) {
    return Column(
      children: [
        Icon(icon, size: 32, color: const Color(0xffb43b28)),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            color: Color(0xffb43b28),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context,
      {required String label, required int percentage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * (percentage / 100),
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xffb43b28),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage% of your Expense ',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuote(BuildContext context, String quote) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          quote,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
