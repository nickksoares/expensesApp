import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatefulWidget {
  const AdaptativeDatePicker(
      {super.key, required this.selectedDate, required this.onDateChange});

  final DateTime? selectedDate;
  final Function(DateTime) onDateChange;

  @override
  State<AdaptativeDatePicker> createState() => _AdaptativeDatePickerState();
}

class _AdaptativeDatePickerState extends State<AdaptativeDatePicker> {
  DateTime currentDate = DateTime.now();
  String dateSelect = 'Selecionar Data';
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
      widget.onDateChange(pickedDate);
    });
  }
      void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system
          // navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      );
    }
  /*_iOSDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 5.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          child: CupertinoDatePicker(
              onDateTimeChanged: onDateChange,
              minimumDate: DateTime(2020),
              maximumDate: DateTime.now(),
              initialDateTime: DateTime.now()),
        ),
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {


    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: Column(
              children: <Widget>[
                CupertinoButton(
                    child: Text(dateSelect),
                    onPressed: () => _showDialog(CupertinoDatePicker(
                          onDateTimeChanged: (DateTime newDate){
                            setState(() {
                              currentDate = newDate;
                              dateSelect = newDate.toString();
                            });
                          },
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                        )))
              ],
            ))
        : SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Text(
                      textAlign: TextAlign.start,
                      widget.selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : "Data Selecionada: ${DateFormat('dd/MM/y').format(widget.selectedDate!)}"),
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
