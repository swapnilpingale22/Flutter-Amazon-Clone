// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/models/sales.dart';

class PieChartScreen extends StatefulWidget {
  final List<Sales>? data;
  const PieChartScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      swapAnimationDuration: const Duration(milliseconds: 750),
      swapAnimationCurve: Curves.easeInOut,
      PieChartData(
        centerSpaceRadius: 80,
        sectionsSpace: 4,
        sections: [
          //item 1
          PieChartSectionData(
            badgeWidget: Text(widget.data![0].label.toString()),
            badgePositionPercentageOffset: 1.5,
            value: double.parse(widget.data![0].earnings.toString()),
            color: Colors.blueAccent,
          ),
          //item 2
          PieChartSectionData(
            badgeWidget: Text(widget.data![1].label.toString()),
            badgePositionPercentageOffset: 1.5,
            value: double.parse(widget.data![1].earnings.toString()),
            color: Colors.redAccent,
          ),
          //item 3
          PieChartSectionData(
            badgeWidget: Text(widget.data![2].label.toString()),
            badgePositionPercentageOffset: 1.5,
            value: double.parse(widget.data![2].earnings.toString()),
            color: Colors.greenAccent,
          ),
          //item 4
          PieChartSectionData(
            badgeWidget: Text(widget.data![3].label.toString()),
            badgePositionPercentageOffset: 1.5,
            value: double.parse(widget.data![3].earnings.toString()),
            color: Colors.yellowAccent,
          ),
          //item 5
          PieChartSectionData(
            badgeWidget: Text(widget.data![4].label.toString()),
            badgePositionPercentageOffset: 1.5,
            value: double.parse(widget.data![4].earnings.toString()),
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}
