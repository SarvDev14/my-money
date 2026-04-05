import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:my_money/screens/main_screen.dart';
import 'package:my_money/screens/transactions_screen.dart';
import 'package:my_money/widgets/add_transaction_sheet.dart';
import 'package:my_money/widgets/balance_card.dart';
import 'package:my_money/widgets/bar_chart_widget.dart';
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

    final weeklyData = provider.getWeeklyExpenses();

    return Scaffold(

      

      appBar: AppBar(backgroundColor: Colors.white60,title: Text("My Money", style: TextStyle(fontWeight: FontWeight.bold),),),
      
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            BalanceCard(
              balance: balance,
              income: income,
              expense: expense,
            ),
        
            SizedBox(height: 20),
        
            Container(
              height: 200,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weekly Spending",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 140,
                    child: WeeklyBarChart(weeklyData: weeklyData),
                  )
                ],
              ),
            ),
        
            SizedBox(height: 20),
        
            Card(
              color: Colors.black,
              child: ListTile(
                title: Text("Recent Transactions", style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.trending_up, color: Colors.white,),
              ),
            ),

            recentTx.length == 0 ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Transactions Created, ", style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(onTap:(){
                      MainScreen.navigateToTab(context, 2);
                    } , 
                    child: Text("Tap Here", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),),
                  
                ]
                ),
            ):
        
            ListView.builder(
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(), 
              itemCount: recentTx.length,
              itemBuilder: (context, index) {
                final tx = recentTx[index];
                return TransactionTile(tx: tx, index: index);
              },
            ),


             SizedBox(height: 120,),
          ],
        ),
            ),
      ),

        
    );
  }
}