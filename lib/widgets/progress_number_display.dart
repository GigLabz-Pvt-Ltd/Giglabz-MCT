import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class NumberedProgress extends StatelessWidget {
  final bool isProgressBlueTile;
  final int pendingGoals;
  final int inProgressGoals;
  final int completedGoals;

  const NumberedProgress({
    required this.isProgressBlueTile,
    required this.pendingGoals,
    required this.inProgressGoals,
    required this.completedGoals,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
            children: [
              Text(
                pendingGoals.toString(),
                  style: GoogleFonts.poppins(
                      color: isProgressBlueTile ? Colors.white : progressRed,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  )),
              Text(
                  "Pending",
                  style: GoogleFonts.poppins(
                      color: isProgressBlueTile ? Colors.white : dashboardGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                  )),
            ]
        ),
        Column(
            children: [
              Text(
                  inProgressGoals.toString(),
                  style: GoogleFonts.poppins(
                      color: isProgressBlueTile ? Colors.white : progressYellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  )),
              Text(
                  "In Progress",
                  style: GoogleFonts.poppins(
                      color: isProgressBlueTile ? Colors.white : dashboardGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                  )),
            ]
        ),
        Column(
            children: [
              Text(
                completedGoals.toString(),
                style: GoogleFonts.poppins(
                    color: isProgressBlueTile ? Colors.white : progressGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),
              ),
              Text(
                  "Completed",
                  style: GoogleFonts.poppins(
                      color: isProgressBlueTile ? Colors.white : dashboardGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                  )),
            ]
        ),
      ],
    );
  }
}
