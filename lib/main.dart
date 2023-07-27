import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expenses/components/transaction_list.dart';
import '/models/transaction.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return  MaterialApp(
      
      //Tema do App
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
          
        ),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        // primaryColor: Colors.purple,
      ),
      //////////////////////////////////////////
      home: const MyHomePage(
        
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _transactions = <Transaction>[
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 't2',
      title: 'Consul',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    )
  ];
    List<Transaction> get _recentTransactions{
      return _transactions.where((tr) {
        return tr.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7)
          )
        );
      }).toList();
    }
    _addTransaction(String title, double value){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(), 
      title: title, 
      value: value, 
      date: DateTime.now(),
      );

      setState(() {
        _transactions.add(newTransaction);
      });
      Navigator.of(context).pop();
    }

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_){
        return TransactionForm(
          onSubmit: _addTransaction,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Despesas da Ala',
          ),
          actions: [
            IconButton(
              onPressed: ()=>_openTransactionFormModal(context), 
              icon: const Icon(Icons.add)
              )
          ],
        ),
        body: ListView(
          children:  <Widget>[
            // const SizedBox(
            //   width: double.infinity,
            //   child: Card(
            //     color: Colors.blue,
            //     elevation: 5,
            //     child: Text('Grafico'),
            //   ),
            // ),
            Chart(recentTranscation: _recentTransactions),
            TransactionList(transactions: _transactions),

          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:()=>_openTransactionFormModal(context),
          child: const Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }
}


