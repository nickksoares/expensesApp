import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    if (title.isEmpty || value <= 0 || _selectedDate == null){
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }
  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1945), 
      lastDate: DateTime.now()
    ).then((pickedDate){
      if (pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitform(),
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitform(),
                decoration: const InputDecoration(labelText: 'Valor (R\$)')),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Text(
                        textAlign: TextAlign.start,
                         
                        _selectedDate == null  ? 'Nenhuma data selecionada!'
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}'
                        
                        ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.titleMedium),
                        onPressed: _showDatePicker,
                        child: const Text('Selecionar Data')),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Botao de transacao
                ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    textStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                  onPressed: _submitform,
                  child: const Text('Nova Transação')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
