import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/create_milestone.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/models/share_goal.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareGoalWidget extends StatefulWidget {
  ShareGoalWidget({
    Key? key,
    required int this.goalId,
    required Function this.updateTab,
    DateTime? this.goalStart,
    DateTime? this.goalEnd,
    required int this.tabSelected
  }) : super(key: key);

  int goalId, tabSelected;
  Function updateTab;
  DateTime? goalStart, goalEnd;
  @override
  State<ShareGoalWidget> createState() => _ShareGoalWidgetState();
}

class _ShareGoalWidgetState extends State<ShareGoalWidget>
    with AutomaticKeepAliveClientMixin<ShareGoalWidget> {
  int selectedOption = 0;
  var selectedFrequency = goalRecurring[0];
  var selectedPeopleRole = peopleRole[0];
  var selectedPeoplePermission = peoplePermissions[0];
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumController = TextEditingController();
  final _reasonController = TextEditingController();

  var selectedRFrequency = goalRecurring[0];
  // var selectedRRole = peopleRole[0];
  var selectedRRole = "Nominated by";
  final _firstnameRController = TextEditingController();
  final _lastnameRController = TextEditingController();
  final _emailRController = TextEditingController();
  final _phoneNumRController = TextEditingController();
  final _parameterRController = TextEditingController();
  final _reasonRController = TextEditingController();

  final _paramController = TextEditingController();

  Map<String, dynamic>? userMap;
  bool isImplementer=false;
  GetProfileResponse? implementer;
  //Participant? implementer;

  bool isBeingEdited = false;
  List<FamilyColleagueList> people = [];
  List<ReviewerList> reviewer = [];
  List<ParametersToReview> parametersToReview = [
    ParametersToReview(
        id: 1,
        parameter: "Basic Needs (food, water, air, rest etc)",
        frequency: goalRecurring[0],
        proofOfProgress: ""),
    ParametersToReview(
        id: 2,
        parameter: "Security and Stability (home and personal safety)",
        frequency: goalRecurring[0],
        proofOfProgress: ""),
    ParametersToReview(
        id: 3,
        parameter: "Love and Belonging (relationships)",
        frequency: goalRecurring[0],
        proofOfProgress: ""),
    ParametersToReview(
        id: 4,
        parameter: "Esteem",
        frequency: goalRecurring[0],
        proofOfProgress: ""),
    ParametersToReview(
        id: 5,
        parameter: "Self Actualisation",
        frequency: goalRecurring[0],
        proofOfProgress: ""),
  ];

  @override
  Widget build(BuildContext context) {
    getImplementerProfile();
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "MyCareTeam allows you to share your goals to Family, Friends, Colleagues, Motivators etc. You can also add a implementer to track and monitor your goals...",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 4),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select someone whom you want to share this goal with, you could add one more people",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Container(
          height: 28,
          margin: EdgeInsets.only(top: 18),
          child: Row(
            children: [
              Row(children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (selectedOption == 0) {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 0,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = int.parse(value.toString());
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Family friends / Colleagues",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
              Row(children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (selectedOption == 1) {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 1,
                  focusColor: grey,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = int.parse(value.toString());
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Implementer",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Spacer(),
          GestureDetector(
            onTap: () {
              if (selectedOption == 0) {
                if (people.length >= 3) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("3 People is maximum")));
                  return;
                }
                resetPeopleFields();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addPeopleDialog("");
                    });
              }
              if (selectedOption == 1) {
                if (reviewer.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("1 Implementer is maximum")));
                  return;
                }
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addReviewerDialog("");
                    });
              }
            },
            child: Padding(
                padding: EdgeInsets.only(top: 14, right: 20),
                child: Row(
                  children: [
                    if (selectedOption == 0 && people.length < 3)
                      SvgPicture.asset("lib/resources/images/add_people.svg"),
                    if (selectedOption == 0 && people.length == 3)
                      SvgPicture.asset(
                          "lib/resources/images/add_people_disabled.svg"),
                    if (selectedOption == 1 && reviewer.isEmpty)
                      SvgPicture.asset("lib/resources/images/add_implementer.svg"),
                    if (selectedOption == 1 && reviewer.isNotEmpty)
                      SvgPicture.asset(
                          "lib/resources/images/add_implementer.svg"),
                  ],
                )),
          )
        ]),
        if (selectedOption == 0)
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: people.length,
              itemBuilder: (context, index) {
                return peopleTile(index);
              }),
        if (selectedOption == 1)
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: reviewer.length,
              itemBuilder: (context, index) {
                return reviewerTile(index);
              }),
        if (selectedOption == 1 && reviewer.isNotEmpty)
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Parameters to Review",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        if (selectedOption == 1 && reviewer.isNotEmpty)
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
                itemCount: parametersToReview.length,
                itemBuilder: (context, index) {
                  return paramsToReview(index);
                }),
          ),
        if (selectedOption == 1 && reviewer.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                var response = await ApiService().shareGoal(ShareGoal(
                    shareGoalTo: 2,
                    goalId: widget.goalId,
                    family: Family(familyColleagueList: people),
                    reviewer: Reviewer(
                        parametersToReview: parametersToReview,
                        reviewerList: reviewer)));

                if (response.responseStatus == 200) {
                  print(response.responseMessage);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return okDialog("");
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.responseMessage)));
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
              ),
            ),
          )
      ]),
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
                          text: isImplementer == true ? 'Goal details are shared Successfully!' : 'Goal details saved Successfully!',
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
                  // if(isImplementer == true){
                  //   Navigator.pop(context);
                  //   setState(() {
                  //     widget.updateTab(3, widget.goalStart, widget.goalEnd);
                  //   });
                  // }
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())).then((value) => setState((){}));
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

  StatefulWidget addPeopleDialog(String index) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Dialog(
          child: Container(
            decoration: const BoxDecoration(
                color: scaffoldGrey,
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 14),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add People",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: blueGrey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                                "lib/resources/images/close_verify_otp.svg"),
                          ),
                        ]),
                  ),
                  Divider(
                    color: dividerGrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "First Name",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: TextField(
                      controller: _firstnameController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Enter First Name *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Last Name",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: TextField(
                      controller: _lastnameController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Enter Last Name *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Email",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: TextField(
                      controller: _emailController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Enter email *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Phone Number",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: TextField(
                      controller: _phoneNumController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Phone Number *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20, top: 12),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "Role *",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: blueGrey),
                        ),
                      ),
                    ]),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                        padding: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          border: Border.all(color: outlineGrey),
                        ),
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                  "lib/resources/images/dropdownArrow.svg")),
                          Container(
                            height: 50,
                            width: double.infinity,
                            // color: Colors.amber,
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Icon(null),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPeopleRole = newValue!;
                                  });
                                },
                                value: selectedPeopleRole,
                                items: peopleRole.map((String dropDownString) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownString,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        dropDownString,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: secondaryColor),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Reason to share",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: TextField(
                      controller: _reasonController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write Reason *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    margin: const EdgeInsets.only(left: 20, top: 12),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "Permissions *",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: blueGrey),
                        ),
                      ),
                    ]),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                        padding: EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          border: Border.all(color: outlineGrey),
                        ),
                        child: Stack(children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                  "lib/resources/images/dropdownArrow.svg")),
                          Container(
                            height: 50,
                            width: double.infinity,
                            // color: Colors.amber,
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: const Icon(null),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedPeoplePermission = newValue!;
                                  });
                                },
                                value: selectedPeoplePermission,
                                items: peoplePermissions
                                    .map((String dropDownString) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownString,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        dropDownString,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: secondaryColor),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                  if (selectedPeoplePermission == "Frequency of Notification")
                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(left: 20, top: 12),
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            "Frequency",
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: blueGrey),
                          ),
                        ),
                      ]),
                    ),
                  if (selectedPeoplePermission == "Frequency of Notification")
                    Row(children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                          padding: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: Stack(children: [
                            Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset(
                                    "lib/resources/images/dropdownArrow.svg")),
                            Container(
                              height: 50,
                              width: double.infinity,
                              // color: Colors.amber,
                              padding: const EdgeInsets.only(top: 0, left: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Icon(null),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedFrequency = newValue!;
                                    });
                                  },
                                  value: selectedFrequency,
                                  items: goalRecurring
                                      .map((String dropDownString) {
                                    return DropdownMenuItem<String>(
                                      value: dropDownString,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Text(
                                          dropDownString,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: secondaryColor),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ]),
                  GestureDetector(
                    onTap: () {
                      if (_firstnameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("First name can't be empty")));
                        return;
                      }
                      if (_lastnameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Last name can't be empty")));
                        return;
                      }
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Email can't be empty")));
                        return;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text);
                      if (!emailValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Email is not valid")));
                        return;
                      }
                      if (_phoneNumController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Phone num can't be empty")));
                        return;
                      }
                      if (_reasonController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Reason can't be empty")));
                        return;
                      }
                      if (selectedPeopleRole == "Select Role") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Role can't be empty")));
                        return;
                      }
                      if (isBeingEdited) {
                        var inde = int.parse(index);

                        people[inde] = FamilyColleagueList(
                            firstName: _firstnameController.text,
                            lastName: _lastnameController.text,
                            email: _emailController.text,
                            phoneNo: _phoneNumController.text,
                            role: selectedPeopleRole,
                            shareReason: _reasonController.text,
                            notificatioin: selectedPeoplePermission ==
                                    "Frequency of Notification"
                                ? 1
                                : 0,
                            editable: false,
                            view: selectedPeoplePermission == "View access"
                                ? 1
                                : 0,
                            frequency: selectedPeoplePermission == "View access"
                                ? ""
                                : selectedFrequency);
                      } else {
                        people.add(FamilyColleagueList(
                            firstName: _firstnameController.text,
                            lastName: _lastnameController.text,
                            email: _emailController.text,
                            phoneNo: _phoneNumController.text,
                            role: selectedPeopleRole,
                            shareReason: _reasonController.text,
                            notificatioin: selectedPeoplePermission ==
                                    "Frequency of Notification"
                                ? 1
                                : 0,
                            editable: false,
                            view: selectedPeoplePermission == "View access"
                                ? 1
                                : 0,
                            frequency: selectedPeoplePermission == "View access"
                                ? ""
                                : selectedFrequency));
                      }
                      update();
                      Navigator.pop(context);
                      isBeingEdited = false;
                    },
                    child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            top: 24, left: 20, right: 20, bottom: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Center(
                          child: Text(
                            "Add People",
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
        ),
      );
    });
  }

  Widget peopleTile(int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      margin: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: outlineGrey),
      ),
      child: Column(children: [
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  people[index].firstName ?? "SomeText",
                  style: GoogleFonts.poppins(
                    color: iconBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  " ",
                  style: GoogleFonts.poppins(
                    color: iconBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  people[index].lastName ?? "SomeText",
                  style: GoogleFonts.poppins(
                    color: iconBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              people[index].email ?? "SomeText",
              style: GoogleFonts.poppins(
                color: secondaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                people[index].phoneNo ?? "SomeText",
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
          Spacer(),
          GestureDetector(
              onTap: () {
                isBeingEdited = true;
                setCurrentPeopleValues(index);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addPeopleDialog(index.toString());
                    }).then((value) => {isBeingEdited = false});
              },
              child: SvgPicture.asset("lib/resources/images/edit_people.svg")),
          Container(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                people.removeAt(index);
                update();
              },
              child:
                  SvgPicture.asset("lib/resources/images/delete_milestone.svg"))
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Role",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      people[index].role ?? "SomeText",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reason to share",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      people[index].shareReason ?? "SomeText",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Permissions",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          if (people[index].view == 1)
                            TextSpan(
                              text: peoplePermissions[0],
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                            ),
                          if (people[index].notificatioin == 1)
                            TextSpan(
                              text: peoplePermissions[
                                  people[index].notificatioin],
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                            ),
                          if (people[index].notificatioin == 1)
                            TextSpan(
                              text: ', ',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                            ),
                          if (people[index].notificatioin == 1)
                            TextSpan(
                              text: people[index].frequency,
                              style: GoogleFonts.poppins(
                                color: secondaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            ),
          ]),
        ),
      ]),
    );
  }

  void update() async {
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void resetPeopleFields() {
    _firstnameController.text = "";
    _lastnameController.text = "";
    _emailController.text = "";
    _phoneNumController.text = "";
    _reasonController.text = "";
    selectedPeopleRole = peopleRole[0];
    selectedPeoplePermission = peoplePermissions[0];
    selectedFrequency = goalRecurring[0];
  }

  setCurrentPeopleValues(int index) {
    _firstnameController.text = people[index].firstName;
    _lastnameController.text = people[index].lastName;
    _emailController.text = people[index].email;
    _phoneNumController.text = people[index].phoneNo;
    _reasonController.text = people[index].shareReason;
    selectedPeopleRole = people[index].role;
    print("selectedPeoplePermission ${people[index].view}");
    if (people[index].view == 1) {
      selectedPeoplePermission = peoplePermissions[0];
      selectedFrequency = goalRecurring[0];
    } else {
      selectedPeoplePermission = peoplePermissions[1];
      selectedFrequency = people[index].frequency;
    }
  }

  StatefulWidget addReviewerDialog(String index) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Dialog(
          child: Container(
            decoration: const BoxDecoration(
                color: scaffoldGrey,
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 14),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Implementer",
                            style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: blueGrey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                                "lib/resources/images/close_verify_otp.svg"),
                          ),
                        ]),
                  ),
                  Divider(
                    color: dividerGrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "First Name",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: isImplementer?Text(
                      implementer!.participant!.firstName.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor
                      ),
                    ):TextField(
                      controller: _firstnameRController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Enter First Name *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Last Name",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: isImplementer?Text(
                      implementer!.participant!.lastName.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor
                      ),
                    ):TextField(
                      controller: _lastnameRController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Enter Last Name *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Email",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: isImplementer?Text(
                      implementer!.participant!.email.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor
                      ),
                    ):TextField(
                      controller: _emailRController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Enter email *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Phone Number",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: isImplementer?Text(
                      implementer!.participant!.phone.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor
                      ),
                    ):TextField(
                      controller: _phoneNumRController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Phone Number *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 20,
                  //   margin: const EdgeInsets.only(left: 20, top: 12),
                  //   child: Row(children: [
                  //     Expanded(
                  //       child: Text(
                  //         "Role",
                  //         style: GoogleFonts.poppins(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w400,
                  //             color: blueGrey),
                  //       ),
                  //     ),
                  //   ]),
                  // ),
                  // Row(children: [
                  //   Expanded(
                  //     child: Container(
                  //       height: 40,
                  //       margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                  //       padding: EdgeInsets.only(right: 12),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //             const BorderRadius.all(Radius.circular(3)),
                  //         border: Border.all(color: outlineGrey),
                  //       ),
                  //       child: Stack(children: [
                  //         Align(
                  //             alignment: Alignment.centerRight,
                  //             child: SvgPicture.asset(
                  //                 "lib/resources/images/dropdownArrow.svg")),
                  //         Container(
                  //           height: 50,
                  //           width: double.infinity,
                  //           // color: Colors.amber,
                  //           padding: const EdgeInsets.only(top: 0, left: 10),
                  //           child: DropdownButtonHideUnderline(
                  //             child: DropdownButton<String>(
                  //               icon: const Icon(null),
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedRRole = newValue!;
                  //                 });
                  //               },
                  //               value: selectedRRole,
                  //               items: peopleRole.map((String dropDownString) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: dropDownString,
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 4),
                  //                     child: Text(
                  //                       dropDownString,
                  //                       textAlign: TextAlign.center,
                  //                       style: const TextStyle(
                  //                           color: secondaryColor),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //         ),
                  //       ]),
                  //     ),
                  //   ),
                  // ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 14),
                    child: Text(
                      "Reason to share",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: TextField(
                      controller: _reasonRController,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondaryColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write Reason *',
                        hintStyle: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, top: 14),
                  //   child: Text(
                  //     "Parameters to Review",
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400,
                  //         color: blueGrey),
                  //   ),
                  // ),
                  // Container(
                  //   height: 40,
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 18,
                  //   ),
                  //   margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                  //   decoration: BoxDecoration(
                  //     borderRadius: const BorderRadius.all(Radius.circular(3)),
                  //     border: Border.all(color: outlineGrey),
                  //   ),
                  //   child: TextField(
                  //     controller: _parameterRController,
                  //     style: GoogleFonts.poppins(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         color: secondaryColor),
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       hintText: 'Write Parameter',
                  //       hintStyle: GoogleFonts.poppins(
                  //         color: secondaryColor,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 20,
                  //   margin: const EdgeInsets.only(left: 20, top: 12),
                  //   child: Row(children: [
                  //     Expanded(
                  //       child: Text(
                  //         "Frequency",
                  //         style: GoogleFonts.poppins(
                  //             fontSize: 15,
                  //             fontWeight: FontWeight.w400,
                  //             color: blueGrey),
                  //       ),
                  //     ),
                  //   ]),
                  // ),
                  // Row(children: [
                  //   Expanded(
                  //     child: Container(
                  //       height: 40,
                  //       margin: EdgeInsets.only(top: 8, left: 20, right: 20),
                  //       padding: EdgeInsets.only(right: 12),
                  //       decoration: BoxDecoration(
                  //         borderRadius:
                  //             const BorderRadius.all(Radius.circular(3)),
                  //         border: Border.all(color: outlineGrey),
                  //       ),
                  //       child: Stack(children: [
                  //         Align(
                  //             alignment: Alignment.centerRight,
                  //             child: SvgPicture.asset(
                  //                 "lib/resources/images/dropdownArrow.svg")),
                  //         Container(
                  //           height: 50,
                  //           width: double.infinity,
                  //           // color: Colors.amber,
                  //           padding: const EdgeInsets.only(top: 0, left: 10),
                  //           child: DropdownButtonHideUnderline(
                  //             child: DropdownButton<String>(
                  //               icon: const Icon(null),
                  //               onChanged: (String? newValue) {
                  //                 setState(() {
                  //                   selectedRFrequency = newValue!;
                  //                 });
                  //               },
                  //               value: selectedRFrequency,
                  //               items:
                  //                   goalRecurring.map((String dropDownString) {
                  //                 return DropdownMenuItem<String>(
                  //                   value: dropDownString,
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 4),
                  //                     child: Text(
                  //                       dropDownString,
                  //                       textAlign: TextAlign.center,
                  //                       style: const TextStyle(
                  //                           color: secondaryColor),
                  //                     ),
                  //                   ),
                  //                 );
                  //               }).toList(),
                  //             ),
                  //           ),
                  //         ),
                  //       ]),
                  //     ),
                  //   ),
                  // ]),
                  GestureDetector(
                    onTap: () {
                      if (_firstnameRController.text.isEmpty && isImplementer==false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("First name can't be empty")));
                        return;
                      }
                      if (_lastnameRController.text.isEmpty && isImplementer==false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Last name can't be empty")));
                        return;
                      }
                      if (_emailRController.text.isEmpty && isImplementer==false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("email can't be empty")));
                        return;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                          .hasMatch(_emailRController.text);
                      if (!emailValid && isImplementer==false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Email is not valid")));
                        return;
                      }
                      if (_phoneNumRController.text.isEmpty && isImplementer==false) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Phone number can't be empty")));
                        return;
                      }
                      // if (_parameterRController.text.isEmpty) {
                      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //       content:
                      //           Text("Parameters to review can't be empty")));
                      //   return;
                      // }
                      if (_reasonRController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Reason can't be empty")));
                        return;
                      }
                      // if (selectedRRole == "Select Role") {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text("Role can't be empty")));
                      //   return;
                      // }
                      if (reviewer.isNotEmpty) {
                        reviewer[0] = ReviewerList(
                            firstName: _firstnameRController.text,
                            lastName: _lastnameRController.text,
                            email: _emailRController.text,
                            phoneNo: _phoneNumRController.text,
                            role: selectedRRole,
                            shareReason: _reasonRController.text,
                            editable: false);
                      } else {
                        reviewer.add(ReviewerList(
                            firstName: isImplementer ? implementer!.participant!.firstName.toString() :_firstnameRController.text,
                            lastName: isImplementer ? implementer!.participant!.lastName.toString() : _lastnameRController.text,
                            email: isImplementer?implementer!.participant!.email.toString(): _emailRController.text,
                            phoneNo: isImplementer?implementer!.participant!.phone.toString(): _phoneNumRController.text,
                            role: selectedRRole,
                            shareReason: _reasonRController.text,
                            editable: false));
                      }
                      update();
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            top: 24, left: 20, right: 20, bottom: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Center(
                          child: Text(
                            "Add Implementer",
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
        ),
      );
    });
  }

  Widget reviewerTile(int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      margin: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: outlineGrey),
      ),
      child: Column(children: [
        Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  reviewer[index].firstName ?? "SomeText",
                  style: GoogleFonts.poppins(
                    color: iconBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  " ",
                  style: GoogleFonts.poppins(
                    color: iconBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  reviewer[index].lastName ?? "SomeText",
                  style: GoogleFonts.poppins(
                    color: iconBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              reviewer[index].email ?? "SomeText",
              style: GoogleFonts.poppins(
                color: secondaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                reviewer[index].phoneNo ?? "SomeText",
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
          Spacer(),
          GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addReviewerDialog(index.toString());
                    });
              },
              child: SvgPicture.asset("lib/resources/images/edit_people.svg")),
          Container(
            width: 10,
          ),
          GestureDetector(
              onTap: () {
                reviewer.removeAt(index);
                update();
              },
              child:
                  SvgPicture.asset("lib/resources/images/delete_milestone.svg"))
        ]),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(children: [
            // Expanded(
            //   child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           "Role",
            //           style: GoogleFonts.poppins(
            //             color: secondaryColor,
            //             fontSize: 13,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //         Text(
            //           reviewer[index].role ?? "SomeText",
            //           style: GoogleFonts.poppins(
            //             color: secondaryColor,
            //             fontSize: 12,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ]),
            // ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reason to share",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      reviewer[index].shareReason ?? "SomeText",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 8.0),
        //   child: Row(children: [
        //     Expanded(
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               "Parameters to Review",
        //               style: GoogleFonts.poppins(
        //                 color: secondaryColor,
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //             Text(
        //               // _parameterRController.text,
        //               "Self Actulaisation",
        //               style: GoogleFonts.poppins(
        //                 color: secondaryColor,
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //           ]),
        //     ),
        //     Container(
        //       width: 10,
        //     ),
        //     Expanded(
        //       child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               "Review Frequency",
        //               style: GoogleFonts.poppins(
        //                 color: secondaryColor,
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //             Text(
        //               selectedRFrequency,
        //               style: GoogleFonts.poppins(
        //                 color: secondaryColor,
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w400,
        //               ),
        //             ),
        //           ]),
        //     ),
        //     //SvgPicture.asset("lib/resources/images/download.svg")
        //   ]),
        // ),
      ]),
    );
  }

  paramsToReview(int index) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: Row(
          children: [
            Expanded(
              flex: 15,
              child: Container(
                child: Text(
                  parametersToReview[index].parameter,
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
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                alignment: Alignment.center,
                icon: Visibility(
                    visible: false, child: Icon(Icons.arrow_drop_down)),
                onChanged: (String? newValue) {
                  setState(() {
                    parametersToReview[index].frequency = newValue!;
                  });
                },
                value: parametersToReview[index].frequency,
                items: goalRecurring.map((String dropDownString) {
                  return DropdownMenuItem<String>(
                    value: dropDownString,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        dropDownString,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: iconBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Container(
              width: 10,
            ),
            SvgPicture.asset("lib/resources/images/reviewer_parameter_red.svg"),
            Container(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  setParamInField(index);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return updateParameter(index);
                      });
                },
                child:
                    SvgPicture.asset("lib/resources/images/edit_people.svg")),
          ],
        ),
      ),
      if (index < parametersToReview.length - 1)
        Padding(
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: Divider(
            color: dividerGrey,
          ),
        ),
    ]);
  }

  StatefulWidget updateParameter(int index) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Dialog(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: scaffoldGrey,
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Update Parameter",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: blueGrey),
                        ),
                        SvgPicture.asset(
                            "lib/resources/images/close_verify_otp.svg"),
                      ]),
                ),
                addParamWidget(),
                Container(
                  height: 80,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(
                                    top: 24, left: 20, right: 10, bottom: 20),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: iconGrey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_paramController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Parameter can't be empty")));
                                return;
                              }

                              parametersToReview[index] = ParametersToReview(
                                  id: parametersToReview[index].id,
                                  parameter: _paramController.text,
                                  frequency:
                                      parametersToReview[index].frequency,
                                  proofOfProgress: parametersToReview[index]
                                      .proofOfProgress);

                              update();
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(
                                    top: 24, left: 10, right: 20, bottom: 20),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Update",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  addParamWidget() {
    return Stack(children: [
      Container(
        height: 90,
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.fromLTRB(0, 0, 6, 6),
        child: Align(
          alignment: Alignment.bottomRight,
          child: SvgPicture.asset(
            "lib/resources/images/about_me.svg",
          ),
        ),
      ),
      Container(
        height: 90,
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: outlineGrey),
        ),
        child: TextField(
          keyboardType: TextInputType.multiline,
          controller: _paramController,
          minLines: 1,
          maxLines: 2,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w400, color: secondaryColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter your parameter",
            hintStyle: GoogleFonts.poppins(
              color: secondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ]);
  }

  void setParamInField(int index) {
    _paramController.text = parametersToReview[index].parameter;
  }

  void getImplementerProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    userMap = jsonDecode(userPref) as Map<String, dynamic>;

    if (userMap != null && implementer == null) {
      var mProfile = await ApiService()
          .getProfile(userMap?["user_name"], userMap?["role_id"]);
      setState(() {
        if(userMap?["role_id"]==3) {
          implementer = mProfile;
          isImplementer = true;
          print(userMap?["user_name"]);
          print(userMap?["role_id"]);
        }
      });
    }
  }
}
