import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final valueController = TextEditingController();

  final titleController = TextEditingController();

  _submitform() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.00;
    if (title.isEmpty || value <= 0){
      return;
    }
    widget.onSubmit(title, value);
    
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitform(),
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
                controller: valueController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_)=>_submitform(),
                decoration: const InputDecoration(labelText: 'Valor (R\$)')),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Botao de transacao
                TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.purple),
                    onPressed:_submitform,
                    child: const Text('Nova Transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
