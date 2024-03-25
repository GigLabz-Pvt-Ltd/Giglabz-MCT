import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mycareteam/models/get_chart_response.dart';
import 'package:mycareteam/resources/constants/const.dart';

class ChartBar extends StatefulWidget {

  const ChartBar({required this.index, required this.barRatings, Key? key}) : super(key: key);

  final List<Bar> barRatings;
  final index;

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  late List<BarData> data;

  @override
  void initState(){
    super.initState();
    updateBarData();
    // data = [
    //   BarData(x:1, y: widget.barRatings[0].ratings[5].toDouble(), color: Colors.blue),
    //   BarData(x:2, y: widget.barRatings[1].ratings[5].toDouble(), color: Colors.red),
    //   BarData(x:3, y: widget.barRatings[2].ratings[5].toDouble(), color: Colors.yellow),
    //   BarData(x:4, y: widget.barRatings[3].ratings[5].toDouble(), color: Colors.green),
    //   BarData(x:5, y: widget.barRatings[4].ratings[5].toDouble(), color: Colors.purple),
    // ];
  }

  @override
  void didUpdateWidget(covariant ChartBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      updateBarData();
    }
  }

  void updateBarData(){
    data = [];
    for(int i=0;i < widget.barRatings.length; i++){
      data.add(
        BarData(x: i, y: widget.barRatings[i].ratings[widget.index].toDouble(), color: ratingChartColours[i])
      );
    }
  }

  List<BarChartGroupData> barData () {
    return data.map((data) =>
        BarChartGroupData(
            x: data.x,
            barRods: [
              BarChartRodData(
                  toY: data.y,
                  color: data.color,
                  width: (MediaQuery
                      .of(context)
                      .size
                      .width / 30),
                  borderRadius: BorderRadius.all(Radius.circular(0))
              )
            ]
        )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
        BarChartData(
          barGroups: barData(),
          minY: 0,
          maxY: 5,
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1
              ),
            ),
            rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)
            ),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)
            ),
            topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false)
            ),
          ),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.black87.withOpacity(0.1),
              strokeWidth: 2,
            ),
            getDrawingVerticalLine: (value) => FlLine(
                color: Colors.transparent
            ),
            verticalInterval: 2,
          ),
          borderData: FlBorderData(
              border: Border(
                left: BorderSide(color: Colors.black87.withOpacity(0.1), width: 2.0),
                right: BorderSide(color: Colors.black87.withOpacity(0.1), width: 2.0),
                top: BorderSide(color: Colors.black87.withOpacity(0.1), width: 2.0),
                bottom: BorderSide(color: Colors.black87.withOpacity(0.1), width: 2.0),
              )
          ),
        )
    );
  }
}

class BarData{
  BarData({
    required this.x,
    required this.y,
    required this.color
  });
  int x;
  double y;
  Color color;
}

