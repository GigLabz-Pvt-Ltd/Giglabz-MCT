import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/ndis_ques_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/goal/goal_outcomes.dart';
import 'package:mycareteam/screens/goal/goal_progress.dart';
import 'package:mycareteam/screens/goal/goal_summary.dart';
import 'package:mycareteam/screens/goal/share_goal.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:mycareteam/widgets/bordered_edit_text.dart';
import 'package:mycareteam/widgets/profile_setting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGoalScreen extends StatefulWidget {
  CreateGoalScreen({
    Key? key,
    required int this.roleId,
    required int this.goalId,
    required int this.tabSelected
  }) : super(key: key);

  int goalId, roleId;
  int tabSelected;

  @override
  State<CreateGoalScreen> createState() => _CreateGoalScreenState();
}

class _CreateGoalScreenState extends State<CreateGoalScreen>
    with SingleTickerProviderStateMixin {
  // final _tabs = [
  //   "Goal Summary",
  //   "Outcomes",
  //   "Share Goal / Reviewer",
  //   "Goal Progress"
  // ];
  var _tabs=[];

  late final TabController _tabCont;
  var currentTab = 0;
  var goalStartDate, goalEndDate;

  @override
  void initState() {
    //_tabCont = TabController(length: _getNumberOfTabs(widget.roleId, widget.tabSelected), vsync: this);
    super.initState();
    ((widget.tabSelected == 3) || (widget.tabSelected == 0 && widget.roleId ==3)) ? _tabs = ["Goal Summary", "Outcomes", "Share Goal / Reviewer", "Goal Progress"] : _tabs = ["Goal Summary", "Outcomes", "Share Goal / Reviewer"];
    _tabCont = TabController(length: _getNumberOfTabs(widget.roleId, widget.tabSelected), vsync: this);
    _tabCont.addListener(() {
      setState(() {
        currentTab = _tabCont.index;
      });
    });
    if(widget.tabSelected==3) {
      updateSelectedTab(_tabCont.length - 1, goalStartDate, goalEndDate);
    }
    print("Tab selected: $widget.tabSelected");

    var w = widget.goalId;
  }

  @override
  void dispose() {
    _tabCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              title: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    // updateSelectedTab(3, null, null);
                  },
                  child: Text(
                    "Create Goal",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
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
            GoalSummaryWidget(
                goalId: widget.goalId, updateTab: updateSelectedTab, tabSelected: widget.tabSelected,),
            GoalOutComesWidget(
                goalId: widget.goalId,
                updateTab: updateSelectedTab,
                goalStart: goalStartDate,
                goalEnd: goalEndDate,
                tabSelected: widget.tabSelected,),
            ShareGoalWidget(goalId: widget.goalId,
                goalStart: goalStartDate,
                goalEnd: goalEndDate,
                updateTab: updateSelectedTab,
                tabSelected: widget.tabSelected,),
            //Center(child: Text("Coming Soon...")),
            if(_getNumberOfTabs(widget.roleId, widget.tabSelected) == 4)
            GoalProgressWidget(
                goalId: widget.goalId,
                tabSelected: widget.tabSelected,),
          ],
        ),
      ),
    );
  }

  updateSelectedTab(int index, DateTime? goalStartDate, DateTime? goalEndDate) {
    setState(() {
      this.goalStartDate = goalStartDate;
      this.goalEndDate = goalEndDate;
    });
    _tabCont.animateTo(index);
  }

  int _getNumberOfTabs(int roleId, int tabSelected) {
    if(tabSelected==3)
      return 4;
    if(roleId==1 && tabSelected==0)
      return 3;
    if(roleId==2 && tabSelected==0)
      return 3;
    if(roleId==3 && tabSelected==0)
      return 4;
    if(roleId==4 && tabSelected==0)
      return 3;
    return -1;
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
}
