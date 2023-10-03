import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class IntroCarouselTile extends StatelessWidget {
  final String imagePath, imageText;

  const IntroCarouselTile(
      {Key? key, required this.imagePath, required this.imageText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 200,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          imageText,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
