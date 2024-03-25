import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartLine extends StatefulWidget {
  const ChartLine({required this.lineRatings, required this.index, Key? key}) : super(key: key);
  final List<num> lineRatings;
  final index;

  @override
  State<ChartLine> createState() => _ChartLineState();
}

class _ChartLineState extends State<ChartLine> {
  late List<LineData> lineData;

  @override
  void initState(){
    super.initState();
    updateLineData();
  }

  @override
  void didUpdateWidget(covariant ChartLine oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      updateLineData();
    }
  }

  void updateLineData(){
    lineData = [
      LineData(x: 2, y: 0.0),
      LineData(x: 4, y: widget.lineRatings[widget.index].toDouble()),
      LineData(x: 5, y: 0.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
            minY: 0,
            maxY: 5,
            lineBarsData: [
              LineChartBarData(
                  spots: lineData.map((e) => FlSpot(e.x, e.y)).toList(),
                  isCurved: false,
                  dotData: FlDotData(
                      show: false
                  ),
                  shadow: Shadow(color: Colors.grey)
              )
            ],
            titlesData: FlTitlesData(
                show: false
            ),
            gridData: FlGridData(
              show: false,
            ),
            borderData: FlBorderData(
                show: false
            )
        )
    );
  }
}

class LineData{
  LineData({
    required this.x,
    required this.y,
  });
  double x;
  double y;
}