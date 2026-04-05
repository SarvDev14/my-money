import 'package:flutter/material.dart';
import 'package:my_money/widgets/transaction_detail_sheet.dart';
import 'package:provider/provider.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatefulWidget {
  final TransactionModel tx;
  final int index;

  const TransactionTile({required this.tx, required this.index});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {

  bool showHint = false;

  void _showDeleteHint() {
    setState(() {
      showHint = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          showHint = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isExpense = widget.tx.type == 'expense';

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
          onTap: () {
          _showDeleteHint(); // keep your hint

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => TransactionDetailSheet(tx: widget.tx),
          );
        },
          leading: CircleAvatar(
            backgroundColor:
                Colors.grey.shade300,
            child: Icon(
              Icons.currency_rupee_outlined,
              color: Colors.black,
            ),
          ),
          title: Text(widget.tx.category, style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(DateFormat.yMMMd().format(widget.tx.date), style: TextStyle( fontWeight: FontWeight.bold)),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isExpense ? '-' : '+'} ₹${widget.tx.amount}",
                style: TextStyle(
                  color: isExpense ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (showHint)
              Text(
                "Long press to delete",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        
          onLongPress: () {
            Provider.of<TransactionProvider>(context, listen: false)
                .deleteTransaction(widget.index);
          },
        ),
      ),
    );
  }
}