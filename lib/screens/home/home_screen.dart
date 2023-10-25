import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_rounded,
          color: iconBlack,
          size: 24,
        ),
        title: SvgPicture.asset(
          "lib/resources/images/toolbar_logo.svg",
          width: 192,
          height: 26,
        ),
        titleSpacing: 0,
        actions: [
          const Icon(
            Icons.notifications_none_rounded,
            color: iconBlack,
            size: 24,
          ),
          Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: darkGrey,
            ),
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(16, 0, 20, 0),
            child: Text(
              "R",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: scaffoldGrey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [],
      // ),
    );
  }
}
