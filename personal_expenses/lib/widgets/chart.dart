import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues =>
      List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(
          days: index,
        ));
        final filter = recentTransactions.where((element) =>
            DateFormat.yMMMd().format(element.date) ==
            DateFormat.yMMMd().format(weekDay));
        final totalSum = filter.isEmpty
            ? 0
            : filter
                .map((e) => e.amount)
                .reduce((value, element) => value + element);

        return {
          'day': DateFormat.E().format(weekDay).toString().substring(0, 1),
          'amount': totalSum,
        };
      }).reversed.toList();

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + double.parse(element['amount'].toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    e['day'].toString(),
                    double.parse(e['amount'].toString()),
                    totalSpending == 0.0
                        ? 0.0
                        : double.parse(e['amount'].toString()) / totalSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
