// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/bar_graph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List salesData;
  const MyBarGraph({
    Key? key,
    required this.salesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      mobilesAmount: double.parse(salesData[0].earnings.toString()),
      essentialsAmount: double.parse(salesData[1].earnings.toString()),
      appliancesAmount: double.parse(salesData[2].earnings.toString()),
      booksAmount: double.parse(salesData[3].earnings.toString()),
      fashionAmount: double.parse(salesData[4].earnings.toString()),
    );
    myBarData.iniitializeBarData();

    var valY = 0;

    valY = (salesData[0].earnings +
        salesData[1].earnings +
        salesData[2].earnings +
        salesData[3].earnings +
        salesData[4].earnings);

    return BarChart(
      BarChartData(
        maxY: double.parse(valY.toString()),
        minY: 0,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: double.parse(valY.toString()),
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Mobiles', style: style);
      break;
    case 1:
      text = const Text('Essentials', style: style);
      break;
    case 2:
      text = const Text('Appliances', style: style);
      break;
    case 3:
      text = const Text('Books', style: style);
      break;
    case 4:
      text = const Text('Fashion', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
