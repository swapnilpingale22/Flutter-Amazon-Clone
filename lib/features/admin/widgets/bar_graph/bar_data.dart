// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_amazon_clone/features/admin/widgets/bar_graph/individual_bar.dart';

class BarData {
  final double mobilesAmount;
  final double essentialsAmount;
  final double appliancesAmount;
  final double booksAmount;
  final double fashionAmount;

  BarData({
    required this.mobilesAmount,
    required this.essentialsAmount,
    required this.appliancesAmount,
    required this.booksAmount,
    required this.fashionAmount,
  });

  List<IndividualBar> barData = [];

  void iniitializeBarData() {
    barData = [
      IndividualBar(x: 0, y: mobilesAmount),
      IndividualBar(x: 1, y: essentialsAmount),
      IndividualBar(x: 2, y: appliancesAmount),
      IndividualBar(x: 3, y: booksAmount),
      IndividualBar(x: 4, y: fashionAmount),
    ];
  }
}
