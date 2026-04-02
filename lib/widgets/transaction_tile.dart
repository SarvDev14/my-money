import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel tx;
  final int index;

  const TransactionTile({required this.tx, required this.index});

  @override
  Widget build(BuildContext context) {
    final isExpense = tx.type == 'expense';

    return Card(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  margin: EdgeInsets.symmetric(vertical: 6),
  elevation: 4,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
        colors: 
             [const Color.fromARGB(255, 205, 215, 255), const Color.fromARGB(255, 26, 38, 92)]
            ,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor:
            Colors.grey.shade300,
        child: Icon(
          Icons.currency_rupee_outlined,
          color: Colors.black,
        ),
      ),
      title: Text(tx.category, style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(DateFormat.yMMMd().format(tx.date), style: TextStyle( fontWeight: FontWeight.bold)),
      trailing: Text(
        "${isExpense ? '-' : '+'} ₹${tx.amount}",
        style: TextStyle(
          color: isExpense ? Colors.red : Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      onLongPress: () {
        Provider.of<TransactionProvider>(context, listen: false)
            .deleteTransaction(index);
      },
    ),
  ),
);
  }
}