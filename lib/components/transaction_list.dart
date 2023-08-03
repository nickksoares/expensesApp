import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});

  final List<Transaction> transactions;
  final void Function(String) onRemove;
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? //Operation to check if transactions list is empty
        LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                SizedBox(height: constraints.maxHeight * 0.05),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (builderContext, index) {
              final tr = transactions[index];
              return Container(
                margin: const EdgeInsets.all(1),
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 3,
                  ),
                  child: ListTile(
                      tileColor: Theme.of(context).colorScheme.background,
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FittedBox(
                            child: Text(
                              'R\$${tr.value}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                      trailing: MediaQuery.of(context).size.width > 480
                          ? TextButton.icon(
                              onPressed: () => onRemove(tr.id),
                              icon: const Icon(Icons.delete),
                              label: Text(
                                'Excluir',
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            )
                          : IconButton(
                              onPressed: () => onRemove(tr.id),
                              icon: const Icon(Icons.delete),
                              color: Colors.redAccent.shade700,
                            )),
                ),
              );
            },
          );
  }
}
