import 'package:flutter/material.dart';
import 'package:my_money/widgets/add_transaction_sheet.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Transactions",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: provider.transactions.length,
        itemBuilder: (context, index) {
          final tx = provider.transactions[index];
          return TransactionTile(tx: tx, index: index);
        },
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: FloatingActionButton(
            
            backgroundColor: Colors.blue.shade100,
            foregroundColor: Colors.black,
            onPressed: (){
              showModalBottomSheet(context: context, builder: (_)=> AddTransactionSheet());
            }, 
            child: Icon(Icons.add),
          ),
        ),
    );
  }
}