import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class UserTypeTile extends StatelessWidget {
  final String userIcon, userType, userDescription;

  const UserTypeTile({
    Key? key,
    required this.userIcon,
    required this.userType,
    required this.userDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: SvgPicture.asset(
              userIcon,
              width: 24,
              height: 24,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userType,
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                userDescription,
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
