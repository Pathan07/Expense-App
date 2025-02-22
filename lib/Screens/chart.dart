import 'package:expense_app/Screens/chart_bar.dart';
import 'package:expense_app/model/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransaction, {Key? key}) : super(key: key);

  final List<TransactionsModel> recentTransaction;

  List<Map<String, Object>> getGroupedTransactions() {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date!.day == weekday.day &&
            recentTransaction[i].date!.month == weekday.month &&
            recentTransaction[i].date!.year == weekday.year) {
          totalSum += recentTransaction[i].amount!;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalMaxSpending {
    return getGroupedTransactions().fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getGroupedTransactions().map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'] as String,
                  (data['amount'] as double),
                  totalMaxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalMaxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
