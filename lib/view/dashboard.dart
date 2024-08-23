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
    final double expensePercentage = controller.totalIncome.value > 0
        ? (controller.totalExpense.value / controller.totalIncome.value) * 100
        : 0;

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
              buildCard(
                context,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Obx(() =>   buildOverItem(
                        icon: Icons.attach_money,
                        label: 'Income',
                        amount: controller.totalIncome.value.toString(),
                      ),),
                        Obx(() => buildOverItem(
                          icon: Icons.money_off,
                          label: 'Expenses',
                          amount: controller.totalExpense.value.toString(),
                        ),),


                        buildOverItem(
                          icon: Icons.account_balance,
                          label: 'Balance',
                          amount: '${controller.totalIncome.value - controller.totalExpense.value}',
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    buildProgressBar(
                      context,
                      label: 'Expense Ratio',
                      percentage: expensePercentage,
                    ),
                  ],
                )
              ),
              SizedBox(height: screenHeight * 0.05),
              buildQuote(context, "“Save more, worry less.”"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, {required Widget child}) {
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

  Widget buildOverItem({
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

  Widget buildProgressBar(BuildContext context, {required String label, required double percentage}) {
    final cappedPercentage = percentage.clamp(0, 100); 

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
              width: MediaQuery.of(context).size.width * (cappedPercentage / 100).clamp(0, 1).toDouble(),
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
          '${cappedPercentage.toStringAsFixed(1)}% of your Income spent',
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 12,
          ),
        ),
      ],
    );
  }


  Widget buildQuote(BuildContext context, String quote) {
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
    ) ;
  }
}
