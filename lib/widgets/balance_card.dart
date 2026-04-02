import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expense;

  const BalanceCard({
    required this.balance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.blueAccent],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Balance", style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text(
            "₹${balance.toStringAsFixed(2)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("Income", income, Colors.green),
              _info("Expense", expense, Colors.red),
            ],
          )
        ],
      ),
    );
  }

  Widget _info(String title, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.white70)),
        SizedBox(height: 4),
        Text(
          "₹${value.toStringAsFixed(0)}",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}