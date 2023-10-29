import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class BorderedEditText extends StatelessWidget {
  final String label, hint;
  final String? suffixIcon;
  final double? padding;
  final TextEditingController controller;

  const BorderedEditText({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.suffixIcon,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 20),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
            fontSize: 16, fontWeight: FontWeight.w400, color: secondaryColor),
        decoration: InputDecoration(
            hintStyle: GoogleFonts.poppins(
              color: iconGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            labelStyle: GoogleFonts.poppins(
              color: iconBlack,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: outlineGrey,
              ),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: outlineGrey,
              ),
            ),
            labelText: label,
            hintText: hint,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.all(padding!),
                    child:
                        SvgPicture.asset("lib/resources/images/calendar.svg"),
                  )
                : null),
      ),
    );
  }
}
