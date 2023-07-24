import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';


// ignore: prefer_const_constructors
void main() => runApp(ExpensesApp());
class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final _transaction = [
    Transaction(
      id: 't1', 
      title: 'Novo Tenis de Corrida', 
      value: 310.76, 
      date: DateTime.now(),
      ),
      Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: const Text('Despesas Pessoas'),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: const Card(
              color: Colors.blue,
              elevation: 5,
              child:  Text('Grafico'),
            ),
          ),
          Column(
            children:_transaction.map((tr){
              return Card(
                child: Row(
                  children: [
                    //Value
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        )
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'R\$ ${tr.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple
                        ),
                      ),
                    ),
                    //Title and Date
                    // Desafio Centralizar Title e Date no inicio, deixar a fonte 16 
                    // do title fontweight bold, date deve ter Colors.grey
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.title,
                          //definir style do title
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          tr.date.toString(),
                          //definir style do date
                          style: const TextStyle(
                            color: Colors.grey
                          ),
                        )
                      ],
                    )
                  ],
                )
              );
            }).toList(),
          )
        ]
      
      )
    );
  }
      
    
}