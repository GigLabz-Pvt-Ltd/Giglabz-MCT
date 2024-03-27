import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class GoalStatusTile extends StatelessWidget {
  final Color progressColour;
  final String iconAsset;
  final String priority;
  final Widget child;
  final Widget numberedProgress;

  const GoalStatusTile({
    required this.progressColour,
    required this.iconAsset,
    required this.priority,
    required this.child,
    required this.numberedProgress,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, bottom: 12, right: 20),
      decoration: BoxDecoration(
          border: Border.all(color: outlineGrey),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 12,
            child: Container(
              height: 40,
              width: 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  color: progressColour
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 12, right: 20, top: 12),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(iconAsset),
                ),
                Container(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          priority,
                          style: GoogleFonts.poppins(
                              color: progressGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          )
                      ),
                      child,
                    ],
                  ),
                ),
                numberedProgress
              ],
            ),
          ),
        ],
      ),
    );
  }
}
