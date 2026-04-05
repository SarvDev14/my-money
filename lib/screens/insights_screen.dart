import 'package:flutter/material.dart';
import 'package:my_money/providers/transaction_provider.dart';
import 'package:my_money/widgets/insights_card.dart';
import 'package:my_money/widgets/other_insights.dart';
import 'package:my_money/widgets/overall_insight.dart';
import 'package:my_money/widgets/pie_chart_widget.dart';
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
      insightMessage = "You started spending this week";
    } else if (percentChange > 20) {
      insightMessage = "Spending increased significantly ⚠️";
    } else if (percentChange < -20) {
      insightMessage = "Great job! You reduced spending";
    } else {
      insightMessage = "Spending is stable";
    }

    double percentChangeInInc = 0;
    if (lastWeekInc != 0) {
      percentChangeInInc = ((thisWkInc - lastWeekInc) / lastWeekInc) * 100;
    }

    

    final categoryData = provider.getCategoryTotals();
    if (categoryData.isEmpty) {
      return Center(child: Text("Please Create Transactions"));
    }


    List<String> getTopCategory(Map<String, double> data) {
      if (data.isEmpty) return ["N/A"];

      String topCategory = "";
      double maxAmount = 0;

      data.forEach((category, amount) {
        if (amount > maxAmount) {
          maxAmount = amount;
          topCategory = category;
        }
      });

      return [topCategory, "${maxAmount}"];
    }


    final topCategory = getTopCategory(categoryData);

    Color getColorForCategory(String category) {
      switch (category) {
        case 'Food':
          return Colors.red;
        case 'Shopping':
          return Colors.green;
        case 'Travel':
          return Colors.blue;
        case 'Bills':
          return Colors.orange;
        default:
          return Colors.grey;
      }
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
                    

                   Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Top spending: ${topCategory[0]} (₹ ${topCategory[1]})",
                           style: TextStyle(fontWeight: FontWeight.bold),),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: PieChartWidget(data: categoryData,getColor: getColorForCategory,),
                                ),
                              ),

                              SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: categoryData.entries.map((entry) {
                                    final color = getColorForCategory(entry.key);

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: color,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Text("${entry.key} (₹${entry.value.toStringAsFixed(0)})",style: TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    

                    SizedBox(height: 20,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OtherInsights(title: 'Change in Spendings from last week', subt: "${percentChange.toStringAsFixed(0)}%", isExp: true,),
                          ],
                        ),
        
                        SizedBox(height: 20,),
            
                        OtherInsights(title: 'Change in Income from last week', subt: "${percentChangeInInc.toStringAsFixed(0)}%", isExp: false,),
                      ],
                    ),

                    

                    SizedBox(height: 60,),

                    


                    
                  ],
                ),
        ),
      ),
    );
  }
}