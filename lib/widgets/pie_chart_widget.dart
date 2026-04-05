import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const PieChartWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    int i = 0;

    final sections = data.entries.map((entry) {
      final section = PieChartSectionData(
        color: colors[i % colors.length],
        value: entry.value,
        title: "",
        radius: 40,
      );
      i++;
      return section;
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: (sections.length).toDouble(),
        centerSpaceRadius: 30,
      ),
    );
  }
}