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
  List<CurrentReviewCycleRating> parameters = [
    CurrentReviewCycleRating(
      parametersToReview: "Basic Needs (food, water, air, rest etc)",
      rating: 0
    ),
    CurrentReviewCycleRating(
        parametersToReview: "Security and Stability (home and personal safety)",
        rating: 0
    ),
    CurrentReviewCycleRating(
        parametersToReview: "Love and Belonging (relationships)",
        rating: 0
    ),
    CurrentReviewCycleRating(
        parametersToReview: "Esteem",
        rating: 0
    ),
    CurrentReviewCycleRating(
        parametersToReview: "Self Actualisation",
        rating: 0
    )
  ];
  double? overallProgress,progress, overallRating;
  double progress_changed = 0;
  double _rating=0;

  final List<OverallProgressSlider> checkpoints = [
    OverallProgressSlider(value: 0, label: "Not Started", thumbColor: primaryColor, labelColor: Color(0xffc4c4c4)),
    OverallProgressSlider(value: 1, label: "Pending", thumbColor: Color(0xfff35958), labelColor: Color(0xffc11f27)),
    OverallProgressSlider(value: 2, label: "In Progress", thumbColor: Color(0xfffdd504), labelColor: Color(0xfffdd504)),
    OverallProgressSlider(value: 3, label: "Completed", thumbColor: Color(0xff00a24e), labelColor: Color(0xff00a24e))
  ];

  @override
  void initState(){
    super.initState();
    init();
    //progress_changed= overallProgress!=null? overallProgress! : 0;
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
                    setState(() {
                      overallProgress = value;
                      print(overallProgress);
                    });
                  },
                  activeColor: primaryColor,
                  inactiveColor: Color(0xffC0E2FF),
                  thumbColor: checkpoints[overallProgress!.toInt()].thumbColor,
                  label: checkpoints[overallProgress!.toInt()].label,

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
                  setState(() {
                    progress = value;
                  });
                },
                activeColor: primaryColor,
                inactiveColor: Color(0xffC0E2FF),
                thumbColor: primaryColor,
                label : progress.toString()
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
                    unratedColor: Colors.amber.withAlpha(70),
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
            width: double.infinity,
            margin: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 12),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              border: Border.all(color: outlineGrey),
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: parameters.length,
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
                  parameters[index].parametersToReview.toString(),
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
            RatingBar.builder(
              initialRating: _rating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 24,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double rating) {
                setState(() {
                  _rating = rating;
                });
              },
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

    if(widget.tabSelected == 3){
      progressResponse = await ApiService().getGoalProgress(userMap?["user_name"], widget.goalId, userMap?["role_id"]);
      setState(() {
        overallProgress = progressResponse!.overallProgress!.toDouble();
        progress = progressResponse!.progress!.toDouble();
        overallRating = progressResponse!.overallRating;
        // parameters = progressResponse!.currentReviewCycleRating!.map((e) => CurrentReviewCycleRating(
        //     id: e.id,
        //     parametersToReview: e.parametersToReview,
        //     rating: e.rating
        // )).toList();
      });
      print(overallProgress);
      print(progress);
      print(overallRating);
    }
  }
}

class OverallProgressSlider {
  OverallProgressSlider(
  {
    required this.value,
    required this.label,
    required this.thumbColor,
    required this.labelColor
  }
  );

  final int value;
  final String label;
  final Color thumbColor;
  final Color labelColor;
}