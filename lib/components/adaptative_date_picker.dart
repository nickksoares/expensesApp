

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker(
      {super.key, required this.selectedDate, required this.onDateChange});

  final DateTime? selectedDate;
  final Function(DateTime) onDateChange;

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1945),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
          height: 180,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateTime(2020),
              maximumDate: DateTime.now(),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: onDateChange),
        )
        : SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                      textAlign: TextAlign.start,
                       selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : "Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate!)}"),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.titleMedium),
                      onPressed: () => _showDatePicker(context),
                      child: const Text('Selecionar Data')),
                )
              ],
            ),
          );
  }
}
