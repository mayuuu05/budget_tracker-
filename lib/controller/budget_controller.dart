import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helper/budget_helper.dart';

class HomeController extends GetxController {
  RxList data = [].obs;
  RxBool isIncome = false.obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;


  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtCategory = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initDb();
  }

  void setIncome(bool value) {
    isIncome.value = value;
  }

  Future initDb() async {
    await DbHelper.dbHelper.database;
    await getRecords();
  }

  Future insertRecord(double amount, int isIncome, String category) async {
    await DbHelper.dbHelper.insertData(amount, isIncome, category);
    await getRecords();
  }
  Future updateRecord(int id, double amount, int isIncome, String category) async {
    await DbHelper.dbHelper.updateData(id, amount, isIncome, category);
    await getRecords();
  }


  Future getRecords() async {
    totalExpense.value = 0.0;
    totalIncome.value = 0.0;
    data.value = await DbHelper.dbHelper.readData();
    for (var i in data) {
      if (i['isIncome'] == 1) {
        totalIncome.value += i['amount'];
      } else {
        totalExpense.value += i['amount'];
      }
    }
  }

  Future removeRecord(int id) async {
    await DbHelper.dbHelper.deleteData(id);
    await getRecords();
  }
}
