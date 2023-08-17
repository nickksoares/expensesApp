

import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';
import 'adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _valueController = TextEditingController();
  final _titleController = TextEditingController();

  DateTime? _selectedDate;
  _submitform() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.00;
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: Colors.grey.shade200,
        elevation: 5,
        child: Column(
          children: <Widget>[
            AdaptativeTextFiled(
                controller: _titleController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitform,
                label: 'Titulo'),
            AdaptativeTextFiled(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitform(),
                label: 'Valor (R\$)'),
            AdaptativeDatePicker(
              selectedDate: _selectedDate,
              onDateChange: (newDate){
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Botao de transacao
                AdaptativeButton(
                    label: 'Nova Transação', onPressed: _submitform),
              ],
            )
          ],
        ),
      ),
    );
  }
}
