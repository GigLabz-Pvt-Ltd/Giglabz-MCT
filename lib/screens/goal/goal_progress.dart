import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:mycareteam/models/get_goal_progress.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalProgressWidget extends StatefulWidget {
  GoalProgressWidget({
    Key? key,
    required int this.goalId,
  }) : super(key: key);

  int goalId;
  DateTime? goalStart, goalEnd;

  @override
  State<GoalProgressWidget> createState() => _GoalProgressWidgetState();
}

class _GoalProgressWidgetState extends State<GoalProgressWidget> {
  GetProfileResponse? user;
  Map<String, dynamic>? userMap;
  //GetGoalProgressResponse? progressResponse;
  var overallProgress, progress, overallRating;

  @override
  void initState(){
    super.initState();
    // init();
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
                  value: overallProgress ?? 0,
                  min: 0,
                  max: 3,
                  divisions: 3,
                  onChanged: (double value) {
                    // setState(() {
                    //   overallProgress = progressResponse!.overallProgress;
                    //   value = overallProgress;
                    // });
                  },
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
                value: progress ?? 0,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (double value) {
                  // setState(() {
                  //   progress = progressResponse?.progress;
                  //   value = progress;
                  // });
                },
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
                        "4.5",
                        style: GoogleFonts.poppins(
                          color: iconBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  RatingBarIndicator(
                    rating: 4.5,
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
            decoration: BoxDecoration(
              border: Border.all(color: outlineGrey),
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ],
      ),
    );
  }

  // void init() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userPref = prefs.getString('user')!;
  //   userMap = jsonDecode(userPref) as Map<String, dynamic>;
  //   if (userMap != null && user == null) {
  //     var mProfile = await ApiService()
  //         .getProfile(userMap?["user_name"], userMap?["role_id"]);
  //     setState(() {
  //       if(userMap?["role_id"]==3) {
  //         user = mProfile;
  //         print(userMap?["user_name"]);
  //         print(userMap?["role_id"]);
  //       }
  //     });
  //   }
  //
  //   progressResponse = await ApiService().getGoalProgress(userMap?["user_name"], widget.goalId, userMap?["role_id"]);
  // }

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
