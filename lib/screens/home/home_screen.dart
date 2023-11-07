import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/goal/create_goal_screen.dart';
import 'package:mycareteam/screens/home/profile_screen.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  var dashboard;

  @override
  Widget build(BuildContext context) {
    getDashBoard();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffoldGrey,
        elevation: 0,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              statusTile(),
              if (false)
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Goals Category",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: iconBlue),
                    ),
                  ),
                ),
              if (false)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding:
                      const EdgeInsets.only(left: 20, right: 12, bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 4,
                            width: 44,
                            margin: EdgeInsets.only(top: 16),
                            decoration: const BoxDecoration(
                                color: goalCategoryProgress,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          const Spacer(),
                          Container(
                            height: 8,
                            width: 8,
                            margin: EdgeInsets.only(top: 16),
                            decoration: const BoxDecoration(
                                color: goalCategoryRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 12, left: 5, right: 10),
                            child: const Text(
                              "High",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: goalCategoryImportance),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: SvgPicture.asset(
                              "lib/resources/images/menu_button.svg",
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          "To Practice on self-love and self-compassion",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: goalCategoryBlue),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 5, top: 8),
                            child: SvgPicture.asset(
                              "lib/resources/images/clock.svg",
                              height: 12,
                              width: 12,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 7, right: 12),
                            child: Text(
                              "Updated 2 hour ago",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: goalCategoryGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: RatingBarIndicator(
                              rating: 4.5,
                              itemCount: 5,
                              itemSize: 14.0,
                              unratedColor: starEmpty,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: starFilled,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: SvgPicture.asset(
                              "lib/resources/images/pie_progress.svg",
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 6),
                                child: Text(
                                  "Current Status",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: iconBlack),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, top: 3, right: 8, bottom: 3),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  border: Border.all(color: outlineGrey),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      margin: const EdgeInsets.only(right: 4),
                                      decoration: const BoxDecoration(
                                          color: goalCategoryGreen,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                    const Text(
                                      "Completed",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: goalCategoryImportance),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Text(
                                  "Start Date",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: goalCategoryBlue),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  "00-00-0000",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: goalCategoryGrey),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, top: 12),
                            child: Column(
                              children: [
                                Text(
                                  "End Date",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: goalCategoryBlue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    "00-00-0000",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: goalCategoryGrey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 4),
                                child: Text(
                                  "Shared With",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: iconBlack),
                                ),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: SvgPicture.asset(
                                      "lib/resources/images/goal_profile.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 16),
                                    child: SvgPicture.asset(
                                      "lib/resources/images/goal_profile.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 32),
                                    child: SvgPicture.asset(
                                      "lib/resources/images/goal_profile.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 4, left: 48),
                                    child: SvgPicture.asset(
                                      "lib/resources/images/goal_profile.svg",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Reviewed By",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: iconBlack),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8, top: 8),
                                  child: SvgPicture.asset(
                                    "lib/resources/images/goal_profile.svg",
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              Container(
                width: 130,
                height: 136,
                margin: EdgeInsets.only(top: 100, bottom: 12),
                child: SvgPicture.asset(
                  "lib/resources/images/no_goals.svg",
                ),
              ),
              const Text(
                "Still you don’t have any goals\n please add a new goal!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff638381)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CreateGoalScreen()));
                },
                child: SvgPicture.asset(
                  "lib/resources/images/create_goal.svg",
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Material(child: bottomNavBar()),
    );
  }

  Widget statusTile() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Color(0xff1182EA),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            circularProgressBar(),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(26, 8, 16, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hey, Gabriel",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      "Your Goals",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xff64B4F5),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "0%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.amber,
                        ),
                        value: 0.8,
                        minHeight: 6,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "00",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ]),
                    ),
                    const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "To do",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "In Progress",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }

  circularProgressBar() {
    return Container(
      height: 87,
      width: 87,
      margin: const EdgeInsets.fromLTRB(18, 25, 0, 18),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: 87,
              height: 87,
              child: const CircularProgressIndicator(
                color: Color(0xff00C3A5),
                strokeWidth: 6,
                value: 0.3,
                backgroundColor: Colors.white, //<-- SEE HERE
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          const Center(
              child: Text(
            "00",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }

  bottomNavBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "lib/resources/images/dashboard.svg",
            width: 24,
            height: 24,
          ),
          activeIcon: SvgPicture.asset(
            "lib/resources/images/dashboard_active.svg",
            width: 24,
            height: 24,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "lib/resources/images/goals.svg",
            width: 24,
            height: 24,
          ),
          label: 'Goals',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "lib/resources/images/refer.svg",
            width: 24,
            height: 24,
          ),
          activeIcon: SvgPicture.asset(
            "lib/resources/images/refer_active.svg",
            width: 24,
            height: 24,
          ),
          label: 'Refer',
        ),
        BottomNavigationBarItem(
          icon: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
          ),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      // currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xff019FFE),
      iconSize: 40,
      elevation: 5,
      unselectedLabelStyle:
          const TextStyle(color: Color(0xFFe0f2f1), fontSize: 12),
      showSelectedLabels: true,
      unselectedItemColor: const Color(0xFF019FFE),
      unselectedFontSize: 12.0,
      onTap: (index) {
        // setState(() {
        //   _currentIndex = index;
        // });
        switch (index) {
          case 0:
            break;
          case 1:
            break;
          case 2:
            break;
          case 3:
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const ProfileScreen()));
            break;
        }
      },
    );
  }

  void getDashBoard() async {
    if (dashboard == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userPref = prefs.getString('user')!;
      var userMap = jsonDecode(userPref) as Map<String, dynamic>;

      var mDashboard = await ApiService().getDashBoard(userMap["user_name"]);

      setState(() {
        dashboard = mDashboard;
      });
    }
  }
}
