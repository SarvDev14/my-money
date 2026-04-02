import 'package:flutter/material.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:my_money/widgets/insights_card.dart';
import 'package:my_money/widgets/other_insights.dart';
import 'package:my_money/widgets/overall_insight.dart';
import 'package:provider/provider.dart';

class InsightsScreen extends StatefulWidget {
  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TransactionProvider>(context, listen: false);

    final thisWeek = provider.getThisWeekExpense();
    final lastWeek = provider.getLastWeekExpense();

    final thisWkInc = provider.getThisWeekIncome();
    final lastWeekInc = provider.getLastWeekIncome();

    double percentChange = 0;
    if (lastWeek != 0) {
      percentChange = ((thisWeek - lastWeek) / lastWeek) * 100;
    }

    String insightMessage = "";

    if (lastWeek == 0 && thisWeek > 0) {
      insightMessage = "You started spending this week 💸";
    } else if (percentChange > 20) {
      insightMessage = "Spending increased significantly ⚠️";
    } else if (percentChange < -20) {
      insightMessage = "Great job! You reduced spending 💰";
    } else {
      insightMessage = "Spending is stable 👍";
    }

    double percentChangeInInc = 0;
    if (lastWeekInc != 0) {
      percentChangeInInc = ((thisWkInc - lastWeekInc) / lastWeekInc) * 100;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Insights", style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
        
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    OverallInsight(insightMessage: insightMessage),

                    const SizedBox(height: 20,),
                    
                    Row(children: [
                      Expanded(child: InsightsCard(title: "This Week Spending", subtitle: "₹${thisWeek.toStringAsFixed(0)}")),
                      SizedBox(width: 10,),
        
                      Expanded(child: InsightsCard(title: "Last Week Spending", subtitle: "₹${lastWeek.toStringAsFixed(0)}")),
        
                    ],
                    ),
        
                    SizedBox(height: 20,),
        
                    Row(children: [
                      Expanded(child: InsightsCard(title: "This Week Income", subtitle: "₹${thisWkInc.toStringAsFixed(0)}")),
                      SizedBox(width: 10,),
        
                      Expanded(child: InsightsCard(title: "Last Week Income", subtitle: "₹${lastWeekInc.toStringAsFixed(0)}")),
        
                    ],
                    ),
                    
                    SizedBox(height: 20,),
        
                    OtherInsights(title: 'Change in Spendings from last week', subt: "${percentChange.toStringAsFixed(0)}%", isExp: true,),
        
                    SizedBox(height: 20,),
        
                    OtherInsights(title: 'Change in Income from last week', subt: "${percentChange.toStringAsFixed(0)}%", isExp: false,),

                    SizedBox(height: 20,),

                    


                    
                  ],
                ),
        ),
      ),
    );
  }
}