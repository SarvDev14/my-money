import 'package:flutter/material.dart';

class OverallInsight extends StatelessWidget {
  final String insightMessage;
  const OverallInsight({super.key, required this.insightMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb, color: Colors.yellow),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              insightMessage,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
      }
}