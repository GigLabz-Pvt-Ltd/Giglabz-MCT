import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/get_goal_progress.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalProgressWidget extends StatefulWidget {
  GoalProgressWidget({
    Key? key,
    required int this.goalId,
    required int this.tabSelected,
  }) : super(key: key);

  int goalId, tabSelected;
  DateTime? goalStart, goalEnd;

  @override
  State<GoalProgressWidget> createState() => _GoalProgressWidgetState();
}

class _GoalProgressWidgetState extends State<GoalProgressWidget> {
  GetProfileResponse? user;
  Map<String, dynamic>? userMap;
  GetGoalProgress? progressResponse;
  var userName, roleId;
  List<String>? parameters;
  double? overallProgress,progress, overallRating;

  @override
  void initState(){
    super.initState();
    init();
    // print(progressResponse);
    print(widget.goalId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Over All Goal Progress",
                style: GoogleFonts.poppins(
                  color: blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: Slider(
                  value: overallProgress!=null? overallProgress! : 0,
                  min: 0,
                  max: 3,
                  divisions: 3,
                  onChanged: (double value) {},
                  activeColor: primaryColor,
                  inactiveColor: Color(0xffC0E2FF),
                  thumbColor: thumbColorOverall()//primaryColor,
              )
          ),
          Padding(
            padding: EdgeInsets.only(top: 14, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Progress",
                style: GoogleFonts.poppins(
                  color: blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: Slider(
                value: progress!=null ? progress! : 0,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (double value) {},
                activeColor: primaryColor,
                inactiveColor: Color(0xffC0E2FF),
                thumbColor: primaryColor,
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 14, left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Over All Rating",
                        style: GoogleFonts.poppins(
                          color: blueGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14, left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        overallRating!=null ? overallRating!.toString() : "4.5",
                        style: GoogleFonts.poppins(
                          color: iconBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  RatingBarIndicator(
                    rating: overallRating!=null ? overallRating! : 4.5,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    unratedColor: Colors.amber.withAlpha(50),
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Icon(
                      Icons.auto_graph_outlined,
                      color: primaryColor,
                      size: 35,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Qualitative Analysis",
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 14, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Current Review Cycle Rating",
                style: GoogleFonts.poppins(
                  color: blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              border: Border.all(color: outlineGrey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: parameters!.length,
              itemBuilder: (context, index) {
                  return parametersTile(index);
              }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return okDialog("");
                    });
              },
              child: Container(
                height: 40,
                width: 82,
                margin: EdgeInsets.only(top: 8, right: 20, bottom: 20),
                color: primaryColor,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
          )
          )
        ],
      ),
    );
  }

  Widget okDialog(String fromDialog) {
    return Dialog(
      child: Container(
        height: 250,
        decoration: const BoxDecoration(
            color: scaffoldGrey,
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(35, 35, 35, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("lib/resources/images/ndis_tick.svg"),
              Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'You have set a Goal Successfully',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: secondaryColor),
                        ),
                        TextSpan(
                          text: '',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor),
                        ),
                        TextSpan(
                          text: '',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: secondaryColor),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 24),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Center(
                      child: Text(
                        "OK",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget parametersTile(int index) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: Row(
          children: [
            Expanded(
              flex: 15,
              child: Container(
                child: Text(
                  parameters![index],
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              width: 10,
            ),
            RatingBarIndicator(
              rating: overallRating!=null ? overallRating! : 4.5,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 25.0,
              unratedColor: Colors.amber.withAlpha(50),
              direction: Axis.horizontal,
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            SvgPicture.asset("lib/resources/images/reviewer_parameter_red.svg"),
            Container(
              width: 10,
            ),
          ],
        ),
      ),
      if (index < parameters!.length - 1)
        Padding(
          padding: EdgeInsets.only(top: 0, bottom: 4),
          child: Divider(
            color: dividerGrey,
          ),
        ),
    ]);
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    userMap = jsonDecode(userPref) as Map<String, dynamic>;
    if (userMap != null && user == null) {
      var mProfile = await ApiService()
          .getProfile(userMap?["user_name"], userMap?["role_id"]);
      setState(() {
        userName = userMap?["user_name"];
        roleId = userMap?["role_id"];
      });
    }
    print("$userName, ${widget.goalId}, $roleId");

    progressResponse = await ApiService().getGoalProgress(userMap?["user_name"], widget.goalId, userMap?["role_id"]);
    setState(() {
      overallProgress = progressResponse!.overallProgress!.toDouble();
      progress = progressResponse!.progress!.toDouble();
      overallRating = progressResponse!.overallRating;
      parameters = progressResponse!.currentReviewCycleRating!.map((e) => e.parametersToReview!).toList();
    });
    print(overallProgress);
    print(progress);
    print(overallRating);
  }

  Color thumbColorOverall(){
    if(overallProgress == 0){
      return primaryColor;
    }
    else if(overallProgress == 1){
      return Colors.red;
    }
    else if(overallProgress == 2){
      return Colors.amber;
    }
    else if(overallProgress ==3){
      return Colors.green;
    }
    return primaryColor;
  }
}
