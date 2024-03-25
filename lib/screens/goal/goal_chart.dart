import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/get_chart_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/widgets/bar_chart.dart';
import 'package:mycareteam/widgets/line_chart.dart';
import 'package:mycareteam/widgets/radar_chart.dart';

class ChartDialog extends StatefulWidget {
  const ChartDialog({
    required this.currentRatingData,
    required this.overallRatingData,
    required this.parameters,
    required this.monthLabels,
    required this.barRatings,
    required this.lineRatings,
    Key? key}) : super(key: key);
  final List<double> currentRatingData;
  final List<double> overallRatingData;
  final List<String> parameters;
  final List<String> monthLabels;
  final List<Bar> barRatings;
  final List<num> lineRatings;

  @override
  State<ChartDialog> createState() => _ChartDialogState();
}

class _ChartDialogState extends State<ChartDialog> {
  var currentIndex;
  var currentMonth;
  List<num> zeroLineRating = [0,0,0,0,0];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.monthLabels.length - 1;
    currentMonth = widget.monthLabels[currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                    color: alertDialogTitleBg,
                    borderRadius: BorderRadius.all(Radius.circular(3.0))),
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Qualitative Analysis",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                            child: SvgPicture.asset(
                                "lib/resources/images/dialog_close.svg")),
                      ),
                    ]),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Overall Rating Chart",
                  style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                //padding: EdgeInsets.only(top: 150),
                child: CustomPaint(
                  painter: RadarRatingChart(
                      rating: widget.overallRatingData,
                      features: widget.parameters,
                      radarChartBackground: fillRadarGraphOverall
                  ),
                  child: Container()
                )
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Current Rating Chart",
                  style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  //padding: EdgeInsets.only(top: 150),
                  child: CustomPaint(
                      painter: RadarRatingChart(
                          rating: widget.currentRatingData,
                          features: widget.parameters,
                          radarChartBackground: fillRadarGraphOverall
                      ),
                      child: Container()
                  )
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 10, top: 10),
                child: Text(
                  "Rating Chart Trends",
                  style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 15, top: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.4,
                  //padding: EdgeInsets.only(top: 150),
                  child: Stack(
                    children: [
                      ChartLine(
                        lineRatings: widget.lineRatings,
                        index: currentIndex,
                      ),
                      ChartBar(
                        barRatings: widget.barRatings,
                        index: currentIndex
                      ),
                    ],
                  )
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      //alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: outlineGrey, width: 2.0),
                        color: Colors.white
                      ),
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            currentIndex = (currentIndex - 1 + widget.monthLabels.length) % widget.monthLabels.length;
                            currentMonth = widget.monthLabels[currentIndex];
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_ios
                        ),
                      ),
                    ),
                    Text(
                      currentMonth,
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      //alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: outlineGrey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white
                      ),
                      child: IconButton(
                        onPressed: (){
                          setState(() {
                            currentIndex = (currentIndex + 1) % widget.monthLabels.length;
                            currentMonth = widget.monthLabels[currentIndex];
                          });
                        },
                        icon: Icon(
                            Icons.arrow_forward_ios
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TempPage extends StatefulWidget {
  const TempPage({required this.overallRatingData, required this.parameters, Key? key}) : super(key: key);
  //final List<double> currentRatingData;
  final List<double> overallRatingData;
  final List<String> parameters;

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CustomPaint(
              painter: RadarRatingChart(
                  rating: widget.overallRatingData,
                  features: widget.parameters,
                  radarChartBackground: fillRadarGraphOverall
              ),
              child: Container(),
            )
        )
    );
  }
}

