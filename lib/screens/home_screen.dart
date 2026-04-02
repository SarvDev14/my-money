import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:my_money/widgets/add_transaction_sheet.dart';
import 'package:my_money/widgets/balance_card.dart';
import 'package:my_money/widgets/transaction_tile.dart';
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
    double income = 0;
    double expense = 0;

    for (var tx in provider.transactions) {
      if (tx.type == 'income') {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }

    double balance = income - expense;

    final recentTx = provider.transactions.reversed.take(3).toList();
    return Scaffold(

      

      appBar: AppBar(backgroundColor: Colors.white60,title: Text("My Money", style: TextStyle(fontWeight: FontWeight.bold),),),
      
      body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          BalanceCard(
            balance: balance,
            income: income,
            expense: expense,
          ),

          SizedBox(height: 20),

          Card(
            color: Colors.black,
            child: ListTile(
              title: Text("Recent Transactions", style: TextStyle(color: Colors.white),),
              trailing: Icon(Icons.trending_up, color: Colors.white,),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: recentTx.length,
              itemBuilder: (context, index) {
                final tx = recentTx[index];

                return TransactionTile(tx: tx, index: index);
              },
            ),
          ),
        ],
      ),
    ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(context: context, builder: (_)=> AddTransactionSheet());
          }, 
          child: Icon(Icons.add),
        ),
    );
  }
}