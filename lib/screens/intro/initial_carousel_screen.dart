import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/entry/login_screen.dart';
import 'package:mycareteam/widgets/intro_carousel_tile.dart';

class InitialCarouselScreen extends StatefulWidget {
  const InitialCarouselScreen({Key? key}) : super(key: key);

  @override
  State<InitialCarouselScreen> createState() => _InitialCarouselScreenState();
}

class _InitialCarouselScreenState extends State<InitialCarouselScreen> {
  var carouselImages = [
    "lib/resources/images/initial_carousel_1.png",
    "lib/resources/images/initial_carousel_2.png",
    "lib/resources/images/initial_carousel_3.png"
  ];
  var carouselTexts = [
    "Trackability refers to the ability to monitor and progress.",
    "Trackability refers to the ability to monitor and progress.",
    "Trackability refers to the ability to monitor and progress."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "lib/resources/images/app_logo.svg",
                  width: 226,
                  height: 108,
                ),
                Text(
                  "\"Own your growth\"",
                  style: GoogleFonts.poppins(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(milliseconds: 2000),
                    initialPage: 0,
                    height: 300,
                    viewportFraction: 1,
                  ),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      IntroCarouselTile(
                          imagePath: carouselImages[itemIndex],
                          imageText: carouselTexts[itemIndex]),
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: outlineGrey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Quick Tour",
                            style: GoogleFonts.poppins(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            child: SvgPicture.asset(
                              "lib/resources/icons/ic_circle_play_right_arrow.svg",
                              width: 22,
                              height: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()));
                        },
                        child: Text(
                          "Skip",
                          style: GoogleFonts.poppins(
                            color: secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginScreen())),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
