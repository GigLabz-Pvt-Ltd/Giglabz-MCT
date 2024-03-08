import 'dart:convert';

import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/models/update_milestone.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
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
  int isGoalClicked = -1;
  Response? imgResponse;
  var goal_id, name, tcAgreed = false;
  DashboardResponse? dashboard;
  List<int>? goalID;
  List<DashboardMilestone>? milestone;
  var updateGoalId, userName, milestoneId;
  int? goalCount;
  int tabSelected=0;
  bool isProgressClicked = false;
  var imgUrl, roleId;
  List<PopupMenuEntry<dynamic>> menuItems = [
    PopupMenuItem(
      child: Row(children: [
        SvgPicture.asset("lib/resources/images/share.svg"),
        Text('  Share')
      ]),
      value: 'option1',
    ),
    PopupMenuItem(
      child: Row(children: [
        SvgPicture.asset("lib/resources/images/delete.svg"),
        Text('  Delete')
      ]),
      value: 'option1',
    ),
    // Add more PopupMenuItems as needed
  ];
  var selectedRisk = riskAnalysis[0];
  var selectedStatus = milestoneStatus[0];
  final _descriptionController1 = TextEditingController();
  final _descriptionController2 = TextEditingController();
  final _descriptionController3 = TextEditingController();
  var mileID, mileStatus, mileAnalysis;

  @override
  void initState(){
    super.initState();
    getDashBoard();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    makeApiCall();
  }

  @override
  Widget build(BuildContext context) {
    //getDashBoard();

    return Scaffold(
      floatingActionButton: goalCount != 0
          ? FloatingActionButton(
          child: SvgPicture.asset("lib/resources/images/add_goal.svg"),
          onPressed: () {
            getGoalId();
          })
          : null,
      appBar: AppBar(
        backgroundColor: scaffoldGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        // leading: const Icon(
        //   Icons.menu_rounded,
        //   color: iconBlack,
        //   size: 24,
        // ),
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: SvgPicture.asset(
            "lib/resources/images/toolbar_logo.svg",
            width: 192,
            height: 26,
          ),
        ),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Mycareteam.online is developing this feature for you")));
            },
            icon: Icon(Icons.notifications_none_rounded),
            color: iconBlack,
            iconSize: 24,
          ),
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.all(14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: getImage()),
          ),
        ],
      ),
      backgroundColor: scaffoldGrey,
      body: SafeArea(
        child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: isGoalClicked == -1
                ? Column(
              children: [
                statusTile(),
                if (goalCount != 0)
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
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: goalCount ?? 0,
                    itemBuilder: (context, index) {
                      return goalTile(index);
                    }),
                if (goalCount == 0)
                  Container(
                    width: 130,
                    height: 136,
                    margin: EdgeInsets.only(top: 100, bottom: 12),
                    child: SvgPicture.asset(
                      "lib/resources/images/no_goals.svg",
                    ),
                  ),
                if (goalCount == 0)
                  const Text(
                    "Still you don’t have any goals\n please add a new goal!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff638381)),
                  ),
                if (tcAgreed && goalCount == 0)
                  GestureDetector(
                    onTap: () {
                      getGoalId();
                    },
                    child: SvgPicture.asset(
                      "lib/resources/images/create_goal.svg",
                    ),
                  ),
              ],
            )
                : Column(
              children: [
                Container(
                  height: 20,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isGoalClicked = -1;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 14, bottom: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Take care of and be kind to your body",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: iconBlue),
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 18, left: 20, right: 20, bottom: 20),
                  padding: const EdgeInsets.only(
                      left: 20, right: 12, bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15))),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: dashboard
                          ?.goalList[isGoalClicked].milestone?.length,
                      itemBuilder: (context, index) {
                        mileID = dashboard?.goalList[isGoalClicked].milestone?[index];
                        mileStatus = dashboard!.goalList[isGoalClicked].milestone![index].milestoneStatus;
                        mileAnalysis = dashboard!.goalList[isGoalClicked].milestone![index].riskAnalysis;
                        return milestoneTile(isGoalClicked, index);
                      }),
                ),
              ],
            )),
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
                    Text(
                      name ?? "",
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
                      child: Row(
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
                              dashboard != null &&
                                  dashboard!.dashboardCount.isNotEmpty
                                  ? dashboard!.dashboardCount[0].DraftPercentage
                                  .toString() +
                                  "%"
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.amber,
                        ),
                        value: dashboard != null &&
                            dashboard!.dashboardCount.isNotEmpty
                            ? dashboard!.dashboardCount[0].DraftPercentage / 100
                            : 0.0,
                        minHeight: 6,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              dashboard != null &&
                                  dashboard!.dashboardCount.isNotEmpty
                                  ? dashboard!.dashboardCount[0].Pending
                                  .toString()
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              dashboard != null &&
                                  dashboard!.dashboardCount.isNotEmpty
                                  ? dashboard!.dashboardCount[0].Inprogress
                                  .toString()
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              dashboard != null &&
                                  dashboard!.dashboardCount.isNotEmpty
                                  ? dashboard!.dashboardCount[0].Completed
                                  .toString()
                                  : "",
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
              child: CircularProgressIndicator(
                color: Color(0xff00C3A5),
                strokeWidth: 6,
                value: dashboard != null && dashboard!.dashboardCount.isNotEmpty
                    ? dashboard!.dashboardCount[0].CompletedPercentage / 100
                    : 0.0,
                backgroundColor: Colors.white, //<-- SEE HERE
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 65,
              height: 65,
              child: CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 6,
                value: dashboard != null && dashboard!.dashboardCount.isNotEmpty
                    ? dashboard!.dashboardCount[0].InprogressPercentage / 100
                    : 0.0,
                backgroundColor: Colors.white, //<-- SEE HERE
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          Center(
              child: Text(
                dashboard != null && dashboard!.dashboardCount.isNotEmpty
                    ? (dashboard!.dashboardCount[0].DraftCount +
                    dashboard!.dashboardCount[0].TotalGoals)
                    .toString()
                    : "",
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
          case 1:  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Mycareteam.online is developing this feature for you")));
          break;
          case 2:  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Mycareteam.online is developing this feature for you")));
          break;
          case 3:
            Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen()))
                .then((value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String userPref = prefs.getString('user')!;
              var userMap = jsonDecode(userPref) as Map<String, dynamic>;

              var mDashboard =
              await ApiService().getDashBoard(userMap["user_name"]);

              var mProfile = await ApiService()
                  .getProfile(userMap?["user_name"], userMap?["role_id"]);
              setState(() {
                dashboard = mDashboard;
                goalCount = mDashboard?.goalList.length;
                if (userMap["role_id"] == 4) {
                  name = "Hey, ${mProfile.provider!.firstName} 👋";
                  if (mProfile.provider?.ndisTc == 1) {
                    tcAgreed = true;
                  } else {
                    tcAgreed = false;
                  }
                } else {
                  name = "Hey, ${mProfile.participant!.firstName} 👋";
                  if (userMap["role_id"] == 1) {
                    if (mProfile.participant?.ndisAgreement == 1 &&
                        mProfile.participant?.ndisTc == 1) {
                      tcAgreed = true;
                    } else {
                      tcAgreed = false;
                    }
                  } else {
                    if (mProfile.participant?.ndisTc == 1) {
                      tcAgreed = true;
                    } else {
                      tcAgreed = false;
                    }
                  }
                }
              });
            });
            break;
        }
      },
    );
  }

  void updateMileValues(int index){
    setState(() {
      milestone = dashboard?.goalList[isGoalClicked].milestone?.map((e) =>
          DashboardMilestone(name: e.name, riskAnalysis: e.riskAnalysis, targetDate: e.targetDate, lastReviewDate: e.lastReviewDate, progress: e.progress, celebrations: e.celebrations, milestoneStatus: e.milestoneStatus, sno: e.sno)
      ).toList();
      print("test milestone get: ${milestone![index].sno}");
      print("test milestone get: ${milestone![index].riskAnalysis}");
    });
  }

  void getDashBoard() async {
    if (dashboard == null) {
      makeApiCall();
    }
  }

  goalTile(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isGoalClicked = index;
          updateGoalId = goalID![index];
          milestone = dashboard?.goalList[isGoalClicked].milestone?.map((e) =>
              DashboardMilestone(name: e.name, riskAnalysis: e.riskAnalysis, targetDate: e.targetDate, lastReviewDate: e.lastReviewDate, progress: e.progress, celebrations: e.celebrations, milestoneStatus: e.milestoneStatus, sno: e.sno)
          ).toList();

          // print("test milestone get: ${milestone![0].sno}");
          // print("test milestone get: ${milestone![0].riskAnalysis}");
          //print("test milestone get: ${milestone![0].sno}");
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: const EdgeInsets.only(left: 20, right: 12, bottom: 10),
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
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                const Spacer(),
                Container(
                  height: 8,
                  width: 8,
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      color: dashboard?.goalList[index].GoalPriority == "High"
                          ? goalCategoryRed
                          : dashboard?.goalList[index].GoalPriority == "Medium"
                          ? goalCategoryGreen
                          : dashboard?.goalList[index].GoalPriority ==
                          "Medium"
                          ? goalCategoryBlue
                          : goalCategoryGrey,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 5, right: 10),
                  child: Text(
                    dashboard?.goalList[index].GoalPriority ?? "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: goalCategoryImportance),
                  ),
                ),
                PopupMenuButton<dynamic>(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SvgPicture.asset(
                      "lib/resources/images/menu_button.svg",
                    ),
                  ),
                  itemBuilder: (BuildContext context) {
                    return menuItems;
                  },
                  onSelected: (dynamic value) {
                    // Handle the selected option
                    print('Selected: $value');
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                dashboard?.goalList[index].GoalName ?? "",
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
                // Padding(
                //   padding: EdgeInsets.only(right: 5, top: 8),
                //   child: SvgPicture.asset(
                //     "lib/resources/images/clock.svg",
                //     height: 12,
                //     width: 12,
                //   ),
                // ),
                // const Padding(
                //   padding: EdgeInsets.only(top: 7, right: 12),
                //   child: Text(
                //     "Updated 2 hour ago",
                //     textAlign: TextAlign.left,
                //     style: TextStyle(
                //         fontWeight: FontWeight.w400,
                //         fontSize: 10,
                //         color: goalCategoryGrey),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: RatingBarIndicator(
                    rating: dashboard?.goalList[index].Rating ?? 0.0,
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
                TextButton(
                  onPressed: (){
                    setState(() {
                      tabSelected=3;
                      updateGoalId = goalID![index];
                    });
                    print('Goal id ${updateGoalId}');
                    print("Tab selected : $tabSelected, $roleId");
                    if(updateGoalId!=null){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => CreateGoalScreen(roleId: roleId, goalId: updateGoalId, tabSelected: tabSelected,)));
                    }
                  },
                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Progress Update",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: primaryColor),
                  ),
                ),
                Container(
                  height: 22,
                  width: 22,
                  margin: EdgeInsets.only(top: 6),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: goalCategoryBlue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: EasyPieChart(
                      shouldAnimate: true,
                      animateDuration: Duration(milliseconds: 1500),
                      pieType: PieType.fill,
                      style: TextStyle(fontSize: 0),
                      children: [
                        PieData(value: 75, color: goalCategoryBlue),
                        PieData(value: 25, color: Colors.white),
                      ]),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 1),
                //   child: SvgPicture.asset(
                //     "lib/resources/images/pie_progress.svg",
                //     height: 24,
                //     width: 24,
                //   ),
                // ),
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
                      padding:
                      EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(3)),
                        border: Border.all(color: outlineGrey),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                                color: dashboard?.goalList[index].GoalStatus == 0 ? Colors.grey :
                                dashboard?.goalList[index].GoalStatus == 1 ? Colors.red :
                                dashboard?.goalList[index].GoalStatus == 2 ? Colors.yellow : goalCategoryGreen,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                          ),
                          Text(
                            dashboard?.goalList[index].GoalStatus == 0? "Not Started" :
                            dashboard?.goalList[index].GoalStatus == 1 ? "Pending" :
                            dashboard?.goalList[index].GoalStatus == 2 ? "In Progress" :"Completed",
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
                Column(
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
                        dashboard?.goalList[index].StartDate ?? "00-00-0000",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: goalCategoryGrey),
                      ),
                    ),
                  ],
                ),
                Padding(
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
                          dashboard?.goalList[index].TargetDate ?? "00-00-0000",
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
                    if (dashboard!.goalList[index].SharedWith!.length > 0)
                      Container(
                        height: dashboard!.goalList[index].SharedWith!.length * 20.0,
                        width: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dashboard!.goalList[index].SharedWith!.length,
                          itemBuilder: (context, i) => Text(
                            dashboard!.goalList[index].SharedWith![i]['firstName'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: iconBlack),
                          ),
                        ),
                      ),
                    // Stack(
                    //   children: [
                    //     if (dashboard!.goalList[index].SharedWith!.length > 0)
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 4),
                    //         child: SvgPicture.asset(
                    //           "lib/resources/images/goal_profile.svg",
                    //           height: 24,
                    //           width: 24,
                    //         ),
                    //       ),
                    //     if (dashboard!.goalList[index].SharedWith!.length > 1)
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 4, left: 16),
                    //         child: SvgPicture.asset(
                    //           "lib/resources/images/goal_profile.svg",
                    //           height: 24,
                    //           width: 24,
                    //         ),
                    //       ),
                    //     if (dashboard!.goalList[index].SharedWith!.length > 2)
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 4, left: 32),
                    //         child: SvgPicture.asset(
                    //           "lib/resources/images/goal_profile.svg",
                    //           height: 24,
                    //           width: 24,
                    //         ),
                    //       ),
                    //     if (dashboard!.goalList[index].SharedWith!.length > 3)
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 4, left: 48),
                    //         child: SvgPicture.asset(
                    //           "lib/resources/images/goal_profile.svg",
                    //           height: 24,
                    //           width: 24,
                    //         ),
                    //       ),
                    //   ],
                    // ),
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
                        padding: const EdgeInsets.only(right: 8, top: 8),
                        // child: SvgPicture.asset(
                        //   "lib/resources/images/goal_profile.svg",
                        //   height: 24,
                        //   width: 24,
                        // ),
                        child: Text(
                          (dashboard!.goalList[index].reviewedBy != null &&
                              dashboard!.goalList[index].reviewedBy!.isNotEmpty &&
                              dashboard!.goalList[index].reviewedBy![0]["firstName"] != null)
                              ? dashboard!.goalList[index].reviewedBy![0]["firstName"].toString()
                              : "",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: iconBlack),
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
    );
  }

  milestoneTile(int goalIndex, int index) {
    return Container(
      // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      // padding: const EdgeInsets.only(left: 20, right: 12, bottom: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            width: 44,
            margin: EdgeInsets.only(top: 16),
            decoration: const BoxDecoration(
                color: goalCategoryProgress,
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              dashboard?.goalList[goalIndex].GoalName ?? "Walk",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: goalCategoryBlue),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        "Risk Analysis",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: blueGrey),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: mileAnalysis == 1 ? Image.asset('lib/resources/images/timeline_notOnTrack.png') :
                            mileAnalysis == 2 ? Image.asset('lib/resources/images/timeline_miss.png') :
                            mileAnalysis == 3 ? Image.asset('lib/resources/images/timeline_finish.png') :
                            Image.asset('lib/resources/images/timeline_ahead.png')
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 4),
                            child: mileAnalysis == 1 ? Text("Not on track", style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),) :
                            mileAnalysis == 2 ? Text("Will miss timeline", style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),) :
                            mileAnalysis == 3 ? Text("Right on time", style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),) :
                            Text("Before or ahead of time", style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),)
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 0, top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Milestone Contribution",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: blueGrey),
                      ),
                      Container(
                        height: 22,
                        width: 38,
                        margin: EdgeInsets.only(top: 8),
                        decoration: const BoxDecoration(
                            color: goalCategoryRed,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            mileID.progress.toString()+"%" ?? "25%",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SvgPicture.asset(
                            "lib/resources/images/calendar_last_review_date.svg")),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 8),
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
                          padding: EdgeInsets.only(top: 4, left: 8),
                          child: Text(
                            dashboard?.goalList[goalIndex].StartDate ??
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
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: SvgPicture.asset(
                            "lib/resources/images/calendar_expected.svg")),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              mileID.targetDate ??
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
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context)=> milestoneDialog(index));
                  },
                  child: Container(
                    height: 36,
                    width: 104,
                    margin: EdgeInsets.only(left: 30, top: 8),
                    decoration: BoxDecoration(
                        color: mileStatus == 1 ? goalCategoryRed :
                        mileStatus == 2 ? goalCategoryProgress :
                        mileStatus == 3 ? goalCategoryGreen : goalCategoryGrey,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        mileStatus == 1 ? "Pending" :
                        mileStatus == 2 ? "In Progress" :
                        mileStatus == 3 ? "Completed" : "Not Started",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 22),
            child: Divider(
              color: dividerGrey,
            ),
          )
        ],
      ),
    );
  }

  Widget milestoneDialog(int index){
    return StatefulBuilder(builder: (context, setState){
      return Dialog(
        child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.all(Radius.circular(3))
          // ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: alertDialogTitleBg,
                      borderRadius: BorderRadius.all(Radius.circular(3))
                  ),
                  padding: EdgeInsets.only(left: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Milestone Process",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset('lib/resources/images/dialog_close.svg')),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    "Expected Completion Date",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(color: outlineGrey),
                        borderRadius: BorderRadius.all(Radius.circular(2))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          milestone?[index].targetDate ?? "DD/MM/YYYY",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SvgPicture.asset('lib/resources/images/calendar.svg')
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    "Risk Analysis",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(color: outlineGrey),
                        borderRadius: BorderRadius.all(Radius.circular(2))
                    ),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset('lib/resources/images/dropdownArrow.svg')),
                        Container(
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<RiskAnalysis>(
                              icon: const Icon(null),
                              value: selectedRisk,
                              onChanged: (RiskAnalysis? newValue) {
                                setState((){
                                  selectedRisk = newValue!;
                                  if(selectedRisk.analysis == "Before or ahead of time"){
                                    mileAnalysis = 0;
                                  }
                                  if(selectedRisk.analysis == "Not on track"){
                                    mileAnalysis = 1;
                                  }
                                  if(selectedRisk.analysis == "Will miss timeline"){
                                    mileAnalysis = 2;
                                  }
                                  if(selectedRisk.analysis == "Right on time"){
                                    mileAnalysis = 3;
                                  }
                                });
                                print("Test ${selectedRisk.analysis}");
                              },
                              items: riskAnalysis.map((risk) {
                                return DropdownMenuItem<RiskAnalysis>(
                                  value: risk,
                                  child: Row(
                                    children: [
                                      Image.asset(risk.assetName, width: 24, height: 24),
                                      SizedBox(width: 3),
                                      Text(risk.analysis, style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    "Milestone Status",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border.all(color: outlineGrey),
                        borderRadius: BorderRadius.all(Radius.circular(2))
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset('lib/resources/images/dropdownArrow.svg')),
                        Container(
                          width: double.infinity,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<MilestoneStatus>(
                              icon: const Icon(null),
                              value: selectedStatus,
                              onChanged: (MilestoneStatus? newValue) {
                                setState((){
                                  selectedStatus = newValue!;
                                  if(selectedStatus.status == "Not Started"){
                                    mileStatus = 0;
                                  }
                                  if(selectedStatus.status == "Pending"){
                                    mileStatus = 1;
                                  }
                                  if(selectedStatus.status == "In Progress"){
                                    mileStatus = 2;
                                  }
                                  if(selectedStatus.status == "Completed"){
                                    mileStatus = 3;
                                  }
                                });
                                print("Test ${newValue?.status}");
                                print("Test ${selectedStatus.status}");
                              },
                              items: milestoneStatus.map((status) {
                                return DropdownMenuItem<MilestoneStatus>(
                                  value: status,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: BoxDecoration(
                                            color: status.colour,
                                            borderRadius: BorderRadius.all(Radius.circular(15))),
                                      ),
                                      SizedBox(width: 3),
                                      Text(status.status, style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24, top: 8),
                            child: Text(
                              "Milestone Contribution",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 24, top: 8),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                color: goalCategoryRed
                            ),
                            child: Text(
                              mileID.progress.toString()+"%" ?? "25%",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 24, top: 8),
                            child: Text(
                              "Celebration",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24, top: 8),
                            child: Text(
                              mileID.celebrations ?? "Yes",
                              style: GoogleFonts.poppins(
                                color: iconBlack,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    "What is working well?",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: outlineGrey),
                  ),
                  child: TextField(
                    controller: _descriptionController1,
                    minLines: 1,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400, color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    "What are the things you are enjoying or progressing with?",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: outlineGrey),
                  ),
                  child: TextField(
                    controller: _descriptionController2,
                    minLines: 1,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400, color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 8),
                  child: Text(
                    "What has changed?",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: outlineGrey),
                  ),
                  child: TextField(
                    controller: _descriptionController3,
                    minLines: 1,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400, color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Description",
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    if(_descriptionController1.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter working well comment")));
                    }
                    if(_descriptionController2.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter enjoying and progressing comment")));
                    }
                    if(_descriptionController3.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter what has changed comment")));
                    }
                    print("Testing mile update");
                    print(_descriptionController1.text);
                    print(_descriptionController2.text);
                    print(_descriptionController3.text);
                    print(updateGoalId);
                    print("Status: $mileStatus");
                    print("Analysis $mileAnalysis");
                    milestoneId = dashboard?.goalList[isGoalClicked].milestone?[index].sno;
                    print("mile id: ${milestoneId}");
                    int response = await ApiService().updateMilestone(
                        UpdateMilestone(
                            riskAnalysis: mileAnalysis,
                            milestoneStatus: mileStatus,
                            workingWellComment: _descriptionController1.text,
                            enjoyingAndProgressingComment: _descriptionController2.text,
                            whatHasChanged: _descriptionController3.text,
                            email: userName, roleId: roleId),
                        updateGoalId, milestoneId);
                    if(response == 200) {
                      makeApiCall();
                      updateMileValues(index);
                    }
                    Navigator.of(context).pop();
                    _descriptionController1.clear();
                    _descriptionController2.clear();
                    _descriptionController3.clear();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: primaryColor
                    ),
                    child: Text(
                      "Update",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  // void updatedMileValues(){
  //   mileStatus = mileID.
  // }

  getGoalId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;
    if (!tcAgreed) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Agree TC in profile")));
      return;
    }
    var response = await ApiService().getGoalId(userMap["user_name"]);
    if (response.responseStatus == 200) {
      goal_id = response.goalId;
      print("Check goal id if same: $goal_id");
      setState(() {
        tabSelected=0;
      });
      print("Tab selected : $tabSelected,  $roleId");
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (BuildContext context) =>
              CreateGoalScreen(roleId: roleId, goalId: goal_id, tabSelected: tabSelected,)))
          .then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userPref = prefs.getString('user')!;
        var userMap = jsonDecode(userPref) as Map<String, dynamic>;

        var mDashboard = await ApiService().getDashBoard(userMap["user_name"]);

        var mProfile = await ApiService()
            .getProfile(userMap?["user_name"], userMap?["role_id"]);
        setState(() {
          dashboard = mDashboard;
          goalCount = mDashboard?.goalList.length;
          if (userMap["role_id"] == 4) {
            name = "Hey, ${mProfile.provider!.firstName} 👋";
            if (mProfile.provider?.ndisTc == 1) {
              tcAgreed = true;
            } else {
              tcAgreed = false;
            }
          } else {
            name = "Hey, ${mProfile.participant!.firstName} 👋";
            if (userMap["role_id"] == 1) {
              if (mProfile.participant?.ndisAgreement == 1 &&
                  mProfile.participant?.ndisTc == 1) {
                tcAgreed = true;
              } else {
                tcAgreed = false;
              }
            } else {
              if (mProfile.participant?.ndisTc == 1) {
                tcAgreed = true;
              } else {
                tcAgreed = false;
              }
            }
          }
        });
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.responseMessage)));
    }
  }

  void makeApiCall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;
    roleId = userMap['role_id'];
    var mDashboard = await ApiService().getDashBoard(userMap["user_name"]);

    var mProfile = await ApiService()
        .getProfile(userMap?["user_name"], userMap?["role_id"]);
    userName = userMap["user_name"];

    if(mDashboard != null){
      setState(() {
        dashboard = mDashboard;
        goalCount = mDashboard?.goalList.length;
        if (userMap["role_id"] == 4) {
          imgUrl = mProfile.provider?.profilePic ?? "";

          name = "Hey, ${mProfile.provider!.firstName} 👋";
          if (mProfile.provider?.ndisTc == 1) {
            tcAgreed = true;
          } else {
            tcAgreed = false;
          }
        } else {
          imgUrl = mProfile.participant?.profilePic ?? "";

          name = "Hey, ${mProfile.participant!.firstName} 👋";
          if (userMap["role_id"] == 1) {
            if (mProfile.participant?.ndisAgreement == 1 &&
                mProfile.participant?.ndisTc == 1) {
              tcAgreed = true;
            } else {
              tcAgreed = false;
            }
          } else {
            if (mProfile.participant?.ndisTc == 1) {
              tcAgreed = true;
            } else {
              tcAgreed = false;
            }
          }
        }
        goalID = dashboard!.goalList.map((e) => e.GoalId).toList();
        print("List of goal id $goalID");
      });
    }

    if (userMap["role_id"] == 4 && imgUrl != "") {
      imgResponse = await get(Uri.parse(imgUrl));
    } else if (imgUrl != "") {
      imgResponse = await get(Uri.parse(imgUrl));
    }
  }

  getImage() {
    if (imgResponse?.statusCode == 200) {
      return Image.network(
        imgUrl,
        fit: BoxFit.fill,
      );
    } else {
      if (imgResponse?.statusCode == 200) {
        return Image.network(
          imgUrl,
          fit: BoxFit.fill,
        );
      } else {
        return Image.asset("lib/resources/images/place_holder.png");
      }
    }
  }
}
