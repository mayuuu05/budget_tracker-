import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/budget_controller.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    final screenHeight = MediaQuery.of(context).size.height;
    final HomeController homeController = Get.put(HomeController());
    double totalIncome = controller.totalIncome.value;
    double totalExpense = controller.totalExpense.value;

    double total = totalIncome + totalExpense;
    double incomePercentage = total > 0 ? (totalIncome / total) * 100 : 0;
    double expensePercentage = total > 0 ? (totalExpense / total) * 100 : 0;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOverviewItem(
                    icon: Icons.attach_money,
                    label: 'Income',
                    percentage: incomePercentage,
                    color: Colors.green.shade600,
                  ),
                  _buildOverviewItem(
                    icon: Icons.money_off,
                    label: 'Expenses',
                    percentage: expensePercentage,
                    color: Colors.red.shade600,
                  ),
                ],
              ),
            ),
          ),

            SizedBox(height: screenHeight * 0.03),
            Text(
              'Recent Transactions',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: controller.data[index]['isIncome'] == 1
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      child: Icon(
                        controller.data[index]['isIncome'] == 1
                            ? Icons.attach_money
                            : Icons.money_off,
                        color: controller.data[index]['isIncome'] == 1
                            ? Colors.green.shade900
                            : Colors.red.shade900,
                      ),
                    ),
                    title: Text(
                      controller.data[index]['category'].toString(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${controller.data[index]['amount']}',
                      style: TextStyle(
                        color: controller.data[index]['isIncome'] == 1
                            ? Colors.green.shade900
                            : Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,color: Colors.grey,),
                          onPressed: () {
                            homeController.txtAmount.text = controller.data[index]['amount'].toString();
                            homeController.txtCategory.text = controller.data[index]['category'].toString();
                            homeController.setIncome(controller.data[index]['isIncome'] == 1);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Update Record',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffb43b28),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    TextField(
                                      controller: homeController.txtAmount,
                                      decoration: const InputDecoration(labelText: 'Amount'),
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(height: 16),
                                    TextField(
                                      controller: homeController.txtCategory,
                                      decoration: const InputDecoration(labelText: 'Category'),
                                    ),
                                    SizedBox(height: 16),
                                    Obx(
                                          () => SwitchListTile(
                                        title: const Text('Income/Expense'),
                                        value: homeController.isIncome.value,
                                        onChanged: (value) {
                                          homeController.setIncome(value);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 24),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            double amount = double.parse(homeController.txtAmount.text);
                                            int isIncome = homeController.isIncome.value ? 1 : 0;
                                            String category = homeController.txtCategory.text;

                                            homeController.updateRecord(
                                              int.parse(controller.data[index]['id'].toString()),
                                              amount,
                                              isIncome,
                                              category,
                                            );

                                            homeController.txtAmount.clear();
                                            homeController.txtCategory.clear();
                                            homeController.setIncome(false);
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xffb43b28),
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Update',style: TextStyle(color: Colors.white),),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },

                          color: Colors.blue.shade700,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.grey,),
                          onPressed: () {
                            controller.removeRecord(
                              int.parse(controller.data[index]['id'].toString()),
                            );
                          },
                          color: Colors.red.shade700,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: controller.data.length,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                backgroundColor: const Color(0xffb43b28),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Add Record',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffb43b28),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: homeController.txtAmount,
                            decoration: const InputDecoration(labelText: 'Amount'),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: homeController.txtCategory,
                            decoration: const InputDecoration(labelText: 'Category'),
                          ),
                          SizedBox(height: 16),
                          Obx(
                                () => SwitchListTile(
                              title: const Text('Income/Expense'),
                              value: homeController.isIncome.value,
                              onChanged: (value) {
                                homeController.setIncome(value);
                              },
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Cancel',style: TextStyle(color: Colors.white),),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  double amount = double.parse(homeController.txtAmount.text);
                                  int isIncome = homeController.isIncome.value ? 1 : 0;
                                  String category = homeController.txtCategory.text;
                                  homeController.insertRecord(amount, isIncome, category);

                                  homeController.txtAmount.clear();
                                  homeController.txtCategory.clear();
                                  homeController.setIncome(false);
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffb43b28),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text('Save',style: TextStyle(color: Colors.white),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildOverviewItem({
    required IconData icon,
    required String label,
    required double percentage,
    required Color color,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeWidth: 8,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
