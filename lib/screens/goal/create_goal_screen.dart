import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/ndis_ques_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/goal/goal_summary.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:mycareteam/widgets/bordered_edit_text.dart';
import 'package:mycareteam/widgets/profile_setting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGoalScreen extends StatefulWidget {
  const CreateGoalScreen({Key? key}) : super(key: key);

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen>
    with SingleTickerProviderStateMixin {
  final _tabs = [
    "Goal Summary",
    "Outcomes",
    "Share Goal / Reviewer",
    "Goal Progress"
  ];

  late final TabController _tabCont;
  var currentTab = 0;
  Map<String, dynamic>? userMap;
  GetProfileResponse? profile;
  GetNdisQuesResponse? ndis;

  @override
  void initState() {
    _tabCont = TabController(length: 4, vsync: this);
    super.initState();

    _tabCont.addListener(() {
      setState(() {
        currentTab = _tabCont.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getProfile();

    return profile != null
        ? Scaffold(
            backgroundColor: scaffoldGrey,
            body: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverAppBar(
                    backgroundColor: primaryColor,
                    pinned: true,
                    floating: false,
                    forceElevated: true,
                    elevation: 1,
                    titleSpacing: 0,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create Goal",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    centerTitle: false,
                    bottom: PreferredSize(
                      preferredSize: _tabBar.preferredSize,
                      child: ColoredBox(color: Colors.white, child: _tabBar),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabCont,
                children: [
                  GoalSummaryWidget(),
                  Center(child: Text("Coming Soon...")),
                  Center(child: Text("Coming Soon...")),
                  Center(child: Text("Coming Soon...")),
                ],
              ),
            ),
          )
        : const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            )));
  }

  TabBar get _tabBar => TabBar(
        controller: _tabCont,
        isScrollable: true,
        indicatorColor: tabSelected,
        tabAlignment: TabAlignment.start,
        tabs: [
          ..._tabs.map(
            (label) => Tab(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  color: blueGrey,
                  fontSize: 12,
                  fontWeight: _tabs[currentTab] == label
                      ? FontWeight.w500
                      : FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      );

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    userMap = jsonDecode(userPref) as Map<String, dynamic>;

    if (userMap != null && profile == null) {
      var mProfile = await ApiService().getProfile(userMap?["user_name"], userMap?["role_id"]);
      var mNdis = await ApiService().getNdisQues(userMap?["user_name"]);
      setState(() {
        profile = mProfile;
        ndis = mNdis;
      });
    }
  }
}
