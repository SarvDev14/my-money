import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';

class TransactionDetailSheet extends StatelessWidget {
  final TransactionModel tx;

  const TransactionDetailSheet({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final isExpense = tx.type == 'expense';

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Title
          Center(
            child: Text(
              tx.category,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 20),

          // Amount
          Text(
            "${isExpense ? '-' : '+'} ₹${tx.amount}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isExpense ? Colors.red : Colors.green,
            ),
          ),

          SizedBox(height: 10),

          if (tx.note.trim().isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Note: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  tx.note,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

          SizedBox(height: 10),

          // Date
          Row(
            children: [
              Text(
                "Date: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              
              Text("${DateFormat.yMMMd().format(tx.date)}"),
            ],
          ),

          SizedBox(height: 10),

          // Type
          Row(
            children: [
              Text(
                "Type: ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text("${tx.type} "),
            ],
          ),

          SizedBox(height: 10),

        
        ],
      ),
    );
  }
}