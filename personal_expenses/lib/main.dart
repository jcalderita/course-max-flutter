import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.amber,
            accentColor: Colors.amber,
            backgroundColor: Colors.amber,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: const TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Quicksand',
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(
        days: 1,
      )),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(
        days: 2,
      )),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoes3',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(
        days: 1,
      )),
    ),
    Transaction(
      id: 't4',
      title: 'Weekly Groceries3',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(
        days: 2,
      )),
    ),
    Transaction(
      id: 't5',
      title: 'New Shoes5',
      amount: 69.99,
      date: DateTime.now().subtract(const Duration(
        days: 1,
      )),
    ),
    Transaction(
      id: 't6',
      title: 'Weekly Groceries6',
      amount: 16.53,
      date: DateTime.now().subtract(const Duration(
        days: 2,
      )),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions => _userTransactions
      .where((element) =>
          element.date.isAfter(DateTime.now().subtract(const Duration(
            days: 7,
          ))))
      .toList();

  void _addNewTransact(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: txDate);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransact(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (_) => NewTransaction(_addNewTransact),
      );

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget _appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ) as PreferredSizeWidget);

    final txtListWidget = SizedBox(
      height: (_mediaQuery.size.height -
              _appBar.preferredSize.height -
              _mediaQuery.padding.vertical) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransact),
    );

    final _pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Show Chart',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (value) => setState(
                          () {
                            _showChart = value;
                          },
                        )),
              ],
            ),
          if (!_isLandscape)
            SizedBox(
              height: (_mediaQuery.size.height -
                      _appBar.preferredSize.height -
                      _mediaQuery.padding.vertical) *
                  0.3,
              child: Chart(_recentTransactions),
            ),
          if (!_isLandscape) txtListWidget,
          if (_isLandscape)
            _showChart
                ? SizedBox(
                    height: (_mediaQuery.size.height -
                            _appBar.preferredSize.height -
                            _mediaQuery.padding.vertical) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                : txtListWidget,
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: _appBar as ObstructingPreferredSizeWidget,
            child: _pageBody,
          )
        : Scaffold(
            appBar: _appBar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? const SizedBox()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
