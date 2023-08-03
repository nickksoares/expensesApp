import 'dart:math';
import 'dart:io';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expenses/components/transaction_list.dart';
import '/models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      //Tema do App
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
            primary: Colors.purple,
            secondary: Colors.amber,
            background: Colors.grey.shade200),
        textTheme: tema.textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
            titleSmall: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
        // primaryColor: Colors.purple,
      ),
      //////////////////////////////////////////
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = <Transaction>[];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  Widget _getIconButton({required IconData icon , required Function() function}){
    return Platform.isIOS
    ? GestureDetector(onTap: function,child: Icon(icon))
    : IconButton(icon: Icon(icon) ,onPressed: function, );
  }

////////////////////////////////////////////////////////////////
///                  WIDGET BUILD              ////////////////
//////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    bool isLandscape = mQuery.orientation == Orientation.landscape;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          icon: _showChart ? Icons.list : Icons.bar_chart_rounded,
          function: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
          icon: Platform.isIOS ? CupertinoIcons.add : Icons.add,
          function: _openTransactionFormModal(context),
      )
    ];

    final appBar = AppBar(
      title: const Text(
        'Despesas da Ala',
      ),
      actions: actions,
    );

    final avaliableHeight =
        mQuery.size.height - appBar.preferredSize.height - mQuery.padding.top;

    final bodyPage = ListView(children: <Widget>[
      if (_showChart || !isLandscape)
        SizedBox(
            height: avaliableHeight * (isLandscape ? 0.7 : .25),
            child: Chart(recentTranscation: _recentTransactions)),
      if (!_showChart || !isLandscape)
        SizedBox(
          height: avaliableHeight * (isLandscape ? 1.0 : .75),
          child: TransactionList(
            transactions: _transactions,
            onRemove: _removeTransaction,
          ),
        ),
    ]);

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas da Ala'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
  ///////////////////////////////////////////////////////////////////////////
}
