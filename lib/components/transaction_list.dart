import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty ?  //Operation to check if transactions list is empty
      Column(
        children: <Widget>[
          Text(
            'Nenhuma transação cadastrada!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      ): ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (builderContext, index) {
          final tr = transactions[index];
          return Container(
            margin: const EdgeInsets.all(1),
            child: Card(
                child: Row(
              children: [
                //Value
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  )),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                //Title and Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr.title,
                      //definir style do title
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('d MMM y').format(tr.date),
                      //definir style do date
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
