import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/get_goal_progress.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/get_review_comments.dart';
import 'package:mycareteam/models/update_progress.dart';
import 'package:mycareteam/models/update_review_comments.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart';

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
  List<String>? getParameters;
  List<double>? getRating;
  double? overallProgress,progress, overallRating;
  double overallProgress_changed=0;
  double progress_changed = 0;
  List<int>? getId;
  double? rate;
  final _chatController = TextEditingController();
  final _scrollController = ScrollController();
  List<ReviewChat> messages=[];
  GetReviewComments? reviewComments;
  bool onIconPressed = false;
  Response? imgResponse;
  List<String>? imgUrl;

  final List<OverallProgressSlider> checkpoints = [
    OverallProgressSlider(value: 0, label: "Not Started", thumbColor: Colors.white, labelColor: Color(0xffc4c4c4)),
    OverallProgressSlider(value: 1, label: "Pending", thumbColor: Color(0xfff35958), labelColor: Color(0xffc11f27)),
    OverallProgressSlider(value: 2, label: "In Progress", thumbColor: Color(0xffEFE7AE), labelColor: Color(0xfffdd504)),
    OverallProgressSlider(value: 3, label: "Completed", thumbColor: Color(0xff7CF1B4), labelColor: Color(0xff00a24e))
  ];

  List<ReviewRating> reviewRating = [
    ReviewRating(
        id: 1,
        parametersToReview: "",
        //proofOfProgress: "",
        proofOfProgressUrl: "",
        rating: 0,
        current: true
    ),
    ReviewRating(
        id: 2,
        parametersToReview: "",
        //proofOfProgress: "",
        proofOfProgressUrl: "",
        rating: 0,
        current: true
    ),
    ReviewRating(
        id: 3,
        parametersToReview: "",
        //proofOfProgress: "",
        proofOfProgressUrl: "",
        rating: 0,
        current: true
    ),
    ReviewRating(
        id: 4,
        parametersToReview: "",
        //proofOfProgress: "",
        proofOfProgressUrl: "",
        rating: 0,
        current: true
    ),
    ReviewRating(
        id: 5,
        parametersToReview: "",
        //proofOfProgress: "",
        proofOfProgressUrl: "",
        rating: 0,
        current: true
    )
  ];

  @override
  void initState(){
    super.initState();
    init();
    print(widget.goalId);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
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
              Expanded(flex:1, child: Container()),
              Padding(
                padding: EdgeInsets.only(top: 14, left: 20, right: 20),
                child: GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => FractionallySizedBox(
                            heightFactor: 0.9,
                            child: chatWidget(),
                          ));
                    },
                    child: SvgPicture.asset("lib/resources/icons/chat_icon.svg", height: 70, width: 70,)
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 14, left: 20, right: 20),
            child: SfSliderTheme(
              data: SfSliderThemeData(
                  tooltipBackgroundColor: checkpoints[overallProgress_changed.toInt()].labelColor,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Color(0xffC0E2FF),
                  thumbColor: checkpoints[overallProgress_changed.toInt()].thumbColor,
                  thumbStrokeColor: checkpoints[overallProgress_changed.toInt()].labelColor,
                  thumbStrokeWidth: 4,
                  thumbRadius: 12
              ),
              child: SfSlider(
                min: 0,
                max: 3,
                value: overallProgress_changed,
                stepSize: 1,
                enableTooltip: true,
                //activeColor: Colors.blue,
                //inactiveColor: Color(0xffC0E2FF),
                interval: 20,
                tooltipTextFormatterCallback: (dynamic value, String actual){
                  return checkpoints[overallProgress_changed.toInt()].label;
                },
                onChanged: (dynamic newValue) {
                  setState(() {
                    overallProgress_changed = newValue;
                  });
                },
              ),
            ),
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
            child: SfSliderTheme(
              data: SfSliderThemeData(
                  tooltipBackgroundColor: primaryColor,
                  activeTrackColor: primaryColor,
                  inactiveTrackColor: Color(0xffC0E2FF),
                  thumbColor: primaryColor,
                  thumbRadius: 12
              ),
              child: SfSlider(
                min: 0,
                max: 100,
                value: progress_changed,
                enableTooltip: true,
                stepSize: 1,
                interval: 20,
                onChanged: (dynamic newValue) {
                  setState(() {
                    progress_changed = newValue;
                    print(progress_changed);
                  });
                },
              ),
            ),
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
                    unratedColor: Colors.grey,
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
                itemCount: getParameters!=null ? getParameters!.length : 0,
                itemBuilder: (context, index) {
                  return parametersTile(index);
                }),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () async{
                    UpdateGoalProgress response = await ApiService().updateProgress(
                        UpdateGoalProgress(
                            overallProgress: overallProgress_changed.toInt(),
                            progress: progress_changed.toInt(),
                            overallRating: overallRating!,
                            currentReviewCycleRating: reviewRating,
                            responseStatus: 200,
                            responseMessage: "Successfull",
                            goalId: widget.goalId,
                            roleId: roleId,
                            email: userName
                        )
                    );
                    if(response.responseStatus == 200){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return okDialog("");
                          });
                    }
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
                          text: 'You have saved a Goal Progress Successfully',
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
                  getParameters![index],
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
              initialRating: getRating![index],
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24,
              unratedColor: Colors.grey,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double rating) {
                print("manasa : $rating");
                setState(() {
                  rate = rating;
                  reviewRating[index].rating = rate!;
                  reviewRating[index].parametersToReview = getParameters![index];
                  reviewRating[index].id = getId![index];
                  reviewRating[index].proofOfProgressUrl = "https://trackability-dev-files.s3.amazonaws.com/goal-documents/${widget.goalId}_${index+1}";
                  print("manasa : $rate");
                  print("manasa ${getParameters![index]}");
                  print("manasa ${reviewRating[index].rating}");
                  print("manasa ${reviewRating[index].parametersToReview}");
                  print("manasa ${reviewRating[index].id}");
                  print("manasa ${reviewRating[index].proofOfProgressUrl}");
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
      if (index < getParameters!.length - 1)
        Padding(
          padding: EdgeInsets.only(top: 0, bottom: 4),
          child: Divider(
            color: dividerGrey,
          ),
        ),
    ]);
  }

  chatWidget(){
    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          Container(
            //alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 60,
            color: Color(0xff06284b),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Review Comments",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                  ),
                ),
                IconButton(
                    onPressed: (){Navigator.pop(context);},
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    )
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: messages.length!=0 ? messages.length : 0,
              itemBuilder: (context, index){
                return Column(
                  crossAxisAlignment: messages[index].role == "participant" ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: messages[index].role == "participant" ? MainAxisAlignment.start : MainAxisAlignment.end,
                      children: [
                        if(messages[index].role == "participant")
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: CircleAvatar(
                              // backgroundImage: NetworkImage(
                              //   messages[index].profilePic.toString()
                              // ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                      messages[index].profilePic.toString(),
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) => Image.asset(
                                        'lib/resources/images/place_holder.png',
                                        fit: BoxFit.contain,
                                        height: 50, width: 50,
                                      )
                                  ),
                                )
                            ),
                          ),
                        Flexible(
                          child: UnconstrainedBox(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              padding: EdgeInsets.all(12),
                              constraints: BoxConstraints(minWidth: 50,minHeight: 10, maxWidth : MediaQuery.of(context).size.width * 0.6),
                              alignment: messages[index].role == "participant" ? Alignment.centerLeft : Alignment.centerRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffC0E2FF),
                              ),
                              child: Text(
                                messages[index].comment,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        ),
                        if(messages[index].role != "participant")
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                                backgroundImage: AssetImage(
                                  'lib/resources/images/place_holder.png',
                                )
                            ),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        messages[index].updatedAt ?? "Some text",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            //alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                border: Border.all(color: outlineGrey),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex:1,
                    child: TextField(
                      controller: _chatController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Send a message',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async{
                      setState(() {
                        onIconPressed = true;
                      });
                      if(_chatController.text.isNotEmpty){
                        UpdateReviewComments response = await ApiService().updateReviewComments(UpdateReviewComments(
                            reviewComment: ReviewComment(comment: _chatController.text),
                            roleId: roleId,
                            email: userName,
                            goalId: widget.goalId));
                        _chatController.clear();
                        setState(() {
                          init();
                          print("Testing what is the last comment ${messages[4].comment}");
                        });
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.send, color: secondaryColor),
                  )
                ],
              )
          )
        ],
      ),
    );
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

    progressResponse = await ApiService().getGoalProgress(userName, widget.goalId, roleId);
    setState(() {
      overallProgress = progressResponse!.overallProgress!.toDouble();
      progress = progressResponse!.progress!.toDouble();
      overallRating = progressResponse!.overallRating;
      overallProgress_changed = overallProgress!;
      progress_changed = progress!;
      getParameters = progressResponse!.currentReviewCycleRating!.map((e) => e.parametersToReview!).toList();
      getRating = progressResponse!.currentReviewCycleRating!.map((e) => e.rating!).toList();
      getId = progressResponse!.currentReviewCycleRating!.map((e) => e.id!).toList();
    });

    if(onIconPressed == true || widget.tabSelected == 3){
      reviewComments = await ApiService().getReviewComments(userMap?["user_name"], widget.goalId);
      imgUrl = reviewComments!.reviewComments!.map((e) => e.profilePic).toList();
      setState(() {
        messages = reviewComments!.reviewComments!.map((e) =>
            ReviewChat(
                id: e.id,
                comment: e.comment,
                updatedAt: e.updatedAt,
                role: e.role, name: e.name,
                profilePic: e.profilePic)).toList();
      });
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