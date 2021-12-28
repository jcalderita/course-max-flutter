import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required Function deleteTransaction,
  })  : _transaction = transaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _transaction;
  final Function _deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _bgColor;
  final avilableColors = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.purple,
  ];

  @override
  void initState() {
    _bgColor = avilableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 8.0,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$${widget._transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
          radius: 30.0,
        ),
        title: Text(
          widget._transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget._transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
                onPressed: () =>
                    widget._deleteTransaction(widget._transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: const Text('Delete'))
            : IconButton(
                onPressed: () =>
                    widget._deleteTransaction(widget._transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );
  }
}
