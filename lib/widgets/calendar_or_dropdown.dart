import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class CalendarOrDropDown extends StatelessWidget {
  final String label, hint;
  final String? suffixIcon;
  final Color? bgColor;

  const CalendarOrDropDown({
    Key? key,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20),
        child: Stack(children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(top: 7),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              border: Border.all(color: bgColor ?? outlineGrey),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        hint,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor),
                      ),
                    ),
                    if(suffixIcon != null)
                    SvgPicture.asset("lib/resources/images/$suffixIcon.svg")
                  ]),
            ),
          ),
          Container(
            height: 20,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: bgColor ?? Colors.white,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w400, color: iconBlack),
            ),
          )
        ]),
    );
  }
}
