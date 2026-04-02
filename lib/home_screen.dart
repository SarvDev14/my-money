import 'package:flutter/material.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:my_money/widgets/add_transaction_sheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);


    return Scaffold(
      appBar: AppBar(title: Text("My Money"),),

      body: ListView.builder(
        itemCount: provider.transactions.length,
        itemBuilder: (context, index){
          final tx = provider.transactions[index];

          return ListTile(
            title: Text(tx.category),
            subtitle: Text(tx.note),
            trailing: Text("₹${tx.amount}"),
            onLongPress: (){
              provider.deleteTransaction(index);
            }
          );
        }),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(context: context, builder: (_)=> AddTransactionSheet());
          }, 
          child: Icon(Icons.add),
        ),
    );
  }
}