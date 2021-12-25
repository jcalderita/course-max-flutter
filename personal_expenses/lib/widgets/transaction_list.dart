import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this._deleteTransaction, {Key? key})
      : super(key: key);

  final List<Transaction> transactions;

  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
                  children: [
                    Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ))
        : ListView.builder(
            itemBuilder: (context, index) => Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 8.0,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                      child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                  radius: 30.0,
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: MediaQuery.of(context).size.width > 360
                    ? TextButton.icon(
                        style: TextButton.styleFrom(
                          primary: Theme.of(context).errorColor,
                        ),
                        onPressed: () =>
                            _deleteTransaction(transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        label: const Text('Delete'))
                    : IconButton(
                        onPressed: () =>
                            _deleteTransaction(transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                      ),
              ),
            ),
            itemCount: transactions.length,
          );
  }
}
