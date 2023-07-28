import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';


class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTranscation});
  final List<Transaction> recentTranscation;



  List<Map<String, Object>> get groupedTransactions{
    initializeDateFormatting('pt_BR');
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index
        )
      );

      double totalSum = 0.00;
      for(var i = 0; i<recentTranscation.length; i++){
        bool sameDay = recentTranscation[i].date.day == weekDay.day;
        bool sameMonth = recentTranscation[i].date.month == weekDay.month;
        bool sameYear = recentTranscation[i].date.year == weekDay.year;

        if(sameYear && sameDay && sameMonth){
          totalSum += recentTranscation[i].value;
        }
      
      }
      return {
        
        'day': DateFormat.E('pt_BR').format(weekDay)[0].toUpperCase(), 
        'value': totalSum,};
    }).reversed.toList();
  }

  double get _weekTotalValue{
    return groupedTransactions.fold(0.00, (sum, tr) {
      return sum+(tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'] as String, 
                value: tr['value'] as double, 
                percentage: _weekTotalValue == 0 ? 0 :(tr['value'] as double) / _weekTotalValue,
                ),
            );
          }).toList(),
        ),
      ),
    );
  }
}