import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/get_achiever_goal_area_response.dart';
import 'package:mycareteam/models/get_influencer_goal_area_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalSummaryWidget extends StatefulWidget {
  GoalSummaryWidget({
    Key? key,
    required int this.goalId,
    required Function this.updateTab,
  }) : super(key: key);

  int goalId;
  Function updateTab;

  @override
  State<GoalSummaryWidget> createState() => _GoalSummaryWidgetState();
}

class _GoalSummaryWidgetState extends State<GoalSummaryWidget>
    with AutomaticKeepAliveClientMixin<GoalSummaryWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Object? goalArea = 1;
  Object? shareGoalTo = "family";
  Object? goalType = "Recurring";
  Object? selectedOption = "High";
  Object? goalFor = "Self";
  var selectedName = null;
  List<String> goalTypeList = [];
  List<GoalArea> goalAreaList = [];
  var selectedRecurring = goalRecurring[0];
  var selectedGoalType;
  GetAchieverGoalAreaResponse? areaResponse;
  int selectedGoalAreaIndex = 0;
  GoalArea? selectedGoalArea;
  var startSelectedHours = hours[0];
  var startSelectedMinutes = minutes[0];
  var endSelectedHours = hours[0];
  var endSelectedMinutes = minutes[0];
  DateTime? selectedStartDate = null, selectedEndDate = null;
  DateTime selectedDob = DateTime.now();
  final _titleController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _customAreaController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool isParticipant = false;
  List<ForSomeoneElse> someoneElse = [];
  var selectedSomeoneIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 14, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Goal Title",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
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
            controller: _titleController,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: secondaryColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Goal Title',
              hintStyle: GoogleFonts.poppins(
                color: secondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Goal Priority",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Container(
          height: 28,
          child: Row(
            children: [
              Row(children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (selectedOption == "High") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "High",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "High",
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
                      if (selectedOption == "Medium") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "Medium",
                  focusColor: grey,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Medium",
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
                      if (selectedOption == "Low") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "Low",
                  focusColor: grey,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Low",
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Trackability has a set of pre-configured goal areas for you to select. Do you want to select one of them or set your own goal ?",
              style: GoogleFonts.poppins(
                color: iconBlack,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )),
        Container(
          height: 28,
          margin: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Row(children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (goalArea == 1) {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 1,
                  groupValue: goalArea,
                  onChanged: (value) {
                    setState(() {
                      goalArea = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Select Goal Area",
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
                      if (goalArea == 2) {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 2,
                  focusColor: grey,
                  groupValue: goalArea,
                  onChanged: (value) {
                    setState(() {
                      goalArea = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Enter your goal area",
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        if (goalArea == 1)
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 10),
            padding: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
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
                        selectedGoalType = newValue!;
                        selectedGoalAreaIndex = 0;
                        updateAreas();
                      });
                    },
                    value: selectedGoalType,
                    items: goalTypeList.map((String dropDownString) {
                      return DropdownMenuItem<String>(
                        value: dropDownString,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            dropDownString,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: secondaryColor),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ]),
          ),
        if (goalArea == 1) selectGoalArea(),
        if (goalArea == 2)
          Padding(
            padding: EdgeInsets.only(top: 0, left: 20, right: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Give Your area of goal",
                style: GoogleFonts.poppins(
                  color: blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        if (goalArea == 2)
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
              controller: _customAreaController,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: secondaryColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Your area of Goal',
                hintStyle: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Are you setting this goal for?",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Row(children: [
              if (isParticipant)
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (goalFor == "Self") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "Self",
                  groupValue: goalFor,
                  onChanged: (value) {
                    setState(() {
                      goalFor = value;
                      print("Button value: $value");
                    });
                  },
                ),
              if (isParticipant)
                Text(
                  "Self",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
            ]),
            if (!isParticipant)
              Row(children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (goalFor == "Someone Else") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "Someone Else",
                  focusColor: grey,
                  groupValue: goalFor,
                  onChanged: (value) {
                    setState(() {
                      goalFor = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Someone Else",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
            if (!isParticipant)
              Row(children: [
                Radio(
                  fillColor: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) {
                      if (goalFor == "For Group") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "For Group",
                  focusColor: grey,
                  groupValue: goalFor,
                  onChanged: (value) {
                    setState(() {
                      goalFor = value;
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "For Group",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
          ],
        ),
        if (!isParticipant && goalFor != "Self")
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 8, left: 20, right: 20),
            child: Row(children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 0),
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                    border: Border.all(color: outlineGrey),
                  ),
                  child: TextField(
                    controller: _nameController,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 0),
                  margin: EdgeInsets.only(left: 6),
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
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter name..")));
                    return;
                  }
                  final bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text);
                  if (emailValid) {
                    setState(() {
                      someoneElse.add(ForSomeoneElse(
                          name: _nameController.text,
                          email: _emailController.text));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email not valid")));
                  }
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                        "lib/resources/images/create_goal_add.svg")),
              )
            ]),
          ),
        if (!isParticipant && goalFor != "Self") selectInterestsLayout(),
        // Container(
        //   margin: EdgeInsets.only(top: 16, left: 20, right: 20),
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: Wrap(
        //       children: [
        //         GestureDetector(
        //           onTap: () {
        //             setState(() {
        //               selectedName = 0;
        //             });
        //           },
        //           child: Container(
        //             margin: EdgeInsets.only(right: 10, bottom: 10),
        //             padding: EdgeInsets.symmetric(horizontal: 8),
        //             decoration: BoxDecoration(
        //               color: selectedName == 0
        //                   ? interestSelected
        //                   : interestNotSelected,
        //               borderRadius: const BorderRadius.all(
        //                 Radius.circular(20),
        //               ),
        //             ),
        //             child: Row(mainAxisSize: MainAxisSize.min, children: [
        //               Text(
        //                 "John",
        //                 style: GoogleFonts.poppins(
        //                     fontSize: 12,
        //                     fontWeight: FontWeight.w400,
        //                     color: selectedName == 0
        //                         ? Colors.white
        //                         : secondaryColor),
        //               ),
        //               Container(
        //                 height: 24,
        //                 width: 12,
        //               ),
        //               selectedName == 0
        //                   ? SvgPicture.asset(
        //                       "lib/resources/images/interest_remove_selected.svg")
        //                   : SvgPicture.asset(
        //                       "lib/resources/images/interest_remove.svg")
        //             ]),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             setState(() {
        //               selectedName = 1;
        //             });
        //           },
        //           child: Container(
        //             margin: EdgeInsets.only(right: 10, bottom: 10),
        //             padding: EdgeInsets.symmetric(horizontal: 8),
        //             decoration: BoxDecoration(
        //               color: selectedName == 1
        //                   ? interestSelected
        //                   : interestNotSelected,
        //               borderRadius: const BorderRadius.all(
        //                 Radius.circular(20),
        //               ),
        //             ),
        //             child: Row(mainAxisSize: MainAxisSize.min, children: [
        //               Text(
        //                 "Williams",
        //                 style: GoogleFonts.poppins(
        //                     fontSize: 12,
        //                     fontWeight: FontWeight.w400,
        //                     color: selectedName == 1
        //                         ? Colors.white
        //                         : secondaryColor),
        //               ),
        //               Container(
        //                 height: 24,
        //                 width: 12,
        //               ),
        //               selectedName == 1
        //                   ? SvgPicture.asset(
        //                       "lib/resources/images/interest_remove_selected.svg")
        //                   : SvgPicture.asset(
        //                       "lib/resources/images/interest_remove.svg")
        //             ]),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             setState(() {
        //               selectedName = 2;
        //             });
        //           },
        //           child: Container(
        //             margin: EdgeInsets.only(right: 10, bottom: 10),
        //             padding: EdgeInsets.symmetric(horizontal: 8),
        //             decoration: BoxDecoration(
        //               color: selectedName == 2
        //                   ? interestSelected
        //                   : interestNotSelected,
        //               borderRadius: const BorderRadius.all(
        //                 Radius.circular(20),
        //               ),
        //             ),
        //             child: Row(mainAxisSize: MainAxisSize.min, children: [
        //               Text(
        //                 "James",
        //                 style: GoogleFonts.poppins(
        //                     fontSize: 12,
        //                     fontWeight: FontWeight.w400,
        //                     color: selectedName == 2
        //                         ? Colors.white
        //                         : secondaryColor),
        //               ),
        //               Container(
        //                 height: 24,
        //                 width: 12,
        //               ),
        //               selectedName == 2
        //                   ? SvgPicture.asset(
        //                       "lib/resources/images/interest_remove_selected.svg")
        //                   : SvgPicture.asset(
        //                       "lib/resources/images/interest_remove.svg")
        //             ]),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Goal Type",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Row(children: [
              Radio(
                fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (goalType == "Recurring") {
                      return iconBlue;
                    }
                    return borderGrey;
                  },
                ),
                value: "Recurring",
                groupValue: goalType,
                onChanged: (value) {
                  setState(() {
                    goalType = value;
                    print("Button value: $value");
                  });
                },
              ),
              Text(
                "Recurring",
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]),
            Row(children: [
              Radio(
                fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (goalType == "OneTime") {
                      return iconBlue;
                    }
                    return borderGrey;
                  },
                ),
                value: "OneTime",
                focusColor: grey,
                groupValue: goalType,
                onChanged: (value) {
                  setState(() {
                    goalType = value;
                    print("Button value: $value");
                  });
                },
              ),
              Text(
                "One-Time Achievement",
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ]),
          ],
        ),
        if (goalType == "Recurring")
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8, left: 20, right: 20),
            padding: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
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
                        selectedRecurring = newValue!;
                      });
                    },
                    value: selectedRecurring,
                    items: goalRecurring.map((String dropDownString) {
                      return DropdownMenuItem<String>(
                        value: dropDownString,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            dropDownString,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: secondaryColor),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ]),
          ),
        Row(children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                selectStartDate(context);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 12, left: 20, right: 6),
                padding: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(color: outlineGrey),
                ),
                child: Stack(children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                          "lib/resources/images/calendar.svg")),
                  Container(
                      height: 50,
                      width: double.infinity,
                      // color: Colors.amber,
                      padding: const EdgeInsets.only(top: 0, left: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedStartDate != null
                                ? selectedStartDate!.day.toString() +
                                    "/" +
                                    selectedStartDate!.month.toString() +
                                    "/" +
                                    selectedStartDate!.year.toString()
                                : "Start Date",
                            style: GoogleFonts.poppins(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ))),
                ]),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (selectedStartDate != null) {
                  selectEndDate(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Select start date")));
                }
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.only(top: 12, left: 6, right: 20),
                padding: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(color: outlineGrey),
                ),
                child: Stack(children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                          "lib/resources/images/calendar.svg")),
                  Container(
                      height: 50,
                      width: double.infinity,
                      // color: Colors.amber,
                      padding: const EdgeInsets.only(top: 0, left: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedEndDate != null
                                ? selectedEndDate!.day.toString() +
                                    "/" +
                                    selectedEndDate!.month.toString() +
                                    "/" +
                                    selectedEndDate!.year.toString()
                                : "End Date",
                            style: GoogleFonts.poppins(
                              color: secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ))),
                ]),
              ),
            ),
          ),
        ]),
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 20, right: 20, top: 12),
          child: Row(children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(color: outlineGrey),
                ),
                child: Row(children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 6),
                      child: Row(children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: SvgPicture.asset(
                                "lib/resources/images/time_dropdown_arrow.svg"),
                            onChanged: (String? newValue) {
                              setState(() {
                                startSelectedHours = newValue!;
                              });
                            },
                            value: startSelectedHours,
                            items: hours.map((String dropDownString) {
                              return DropdownMenuItem<String>(
                                value: dropDownString,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    dropDownString,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: secondaryColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 6),
                      child: Row(children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: SvgPicture.asset(
                                "lib/resources/images/time_dropdown_arrow.svg"),
                            onChanged: (String? newValue) {
                              setState(() {
                                startSelectedMinutes = newValue!;
                              });
                            },
                            value: startSelectedMinutes,
                            items: minutes.map((String dropDownString) {
                              return DropdownMenuItem<String>(
                                value: dropDownString,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    dropDownString,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: secondaryColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 6),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(color: outlineGrey),
                ),
                child: Row(children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 6),
                      child: Row(children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: SvgPicture.asset(
                                "lib/resources/images/time_dropdown_arrow.svg"),
                            onChanged: (String? newValue) {
                              setState(() {
                                endSelectedHours = newValue!;
                              });
                            },
                            value: endSelectedHours,
                            items: hours.map((String dropDownString) {
                              return DropdownMenuItem<String>(
                                value: dropDownString,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    dropDownString,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: secondaryColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 6),
                      child: Row(children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: SvgPicture.asset(
                                "lib/resources/images/time_dropdown_arrow.svg"),
                            onChanged: (String? newValue) {
                              setState(() {
                                endSelectedMinutes = newValue!;
                              });
                            },
                            value: endSelectedMinutes,
                            items: minutes.map((String dropDownString) {
                              return DropdownMenuItem<String>(
                                value: dropDownString,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    dropDownString,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: secondaryColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Divider(
            color: dividerGrey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Goal Summary",
              style: GoogleFonts.poppins(
                color: blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 8),
          child: aboutMeWidget(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () async {
              if (_titleController.text == "") {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Enter Goal Title")));
                return;
              }
              if (selectedStartDate == null || selectedEndDate == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter start Date and End Date")));
                return;
              }
              if (_descriptionController.text == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Enter Goal Summary")));
                return;
              }
              var goal = CreateGoal(
                  title: _titleController.text,
                  priority: selectedOption.toString(),
                  area: goalArea == 1
                      ? goalAreaList[selectedGoalAreaIndex]
                      : null,
                  areaCustom: goalArea == 2 ? _customAreaController.text : null,
                  goalFor: goalFor.toString(),
                  forSomeoneElse: someoneElse,
                  recurring: goalType == "Recurring" ? selectedRecurring : null,
                  startDate:
                      "${selectedStartDate!.day}/${selectedStartDate!.month}/${selectedStartDate!.year}",
                  targetDate:
                      "${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}",
                  description: _descriptionController.text);

              print("goal : " +
                  createGoalApiToJson(goal) +
                  "id : " +
                  widget.goalId.toString());
              CreateGoalResponse response =
                  await ApiService().createGoal(widget.goalId, goal);

              if (response.responseStatus == 200) {
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
              width: 80,
              margin: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  selectGoalArea() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: outlineGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Wrap(children: areaItems()),
    );
  }

  selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDob)
      setState(() {
        selectedStartDate = picked;
        selectedEndDate = null;
      });
  }

  selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate!, // Refer step 1
      firstDate: selectedStartDate!,
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDob)
      setState(() {
        selectedEndDate = picked;
      });
  }

  aboutMeWidget() {
    return Stack(children: [
      Container(
        height: 90,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          border: Border.all(color: outlineGrey),
        ),
        child: TextField(
          keyboardType: TextInputType.multiline,
          controller: _descriptionController,
          minLines: 1,
          maxLines: 2,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w400, color: secondaryColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "",
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
                          text: 'Goal summary details are saved Successfully!',
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
                  setState(() {
                    widget.updateTab(1, selectedStartDate, selectedEndDate);
                  });
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

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString('user')!;
    var userMap = jsonDecode(userPref) as Map<String, dynamic>;

    if (userMap["role_id"] == 1) {
      areaResponse = await ApiService().getAchieverGoalAreas();

      setState(() {
        isParticipant = true;
        areaResponse?.achiever.forEach((element) {
          goalTypeList.add(element.type);
        });
        selectedGoalType = goalTypeList[0];

        areaResponse?.achiever[0].subTypes.forEach((element) {
          goalAreaList.add(element);
        });
      });
    } else {
      setState(() {
        isParticipant = false;
        goalFor = "Someone Else";
      });
    }

    // else {
// values to be mapped once ui shared from the client
    GetInfluencerGoalAreaResponse Iarea =
        await ApiService().getInfluencerGoalAreas();
    var b = Iarea;
    // }
  }

  List<Widget> areaItems() {
    List<Widget> items = [];
    goalAreaList.asMap().forEach((index, element) {
      items.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedGoalAreaIndex = index;
          });
        },
        child: Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: selectedGoalAreaIndex == index
                ? interestSelected
                : interestNotSelected,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              element.name,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: selectedGoalAreaIndex == index
                      ? Colors.white
                      : secondaryColor),
            ),
            Container(
              height: 24,
              width: 12,
            ),
            selectedGoalAreaIndex == index
                ? SvgPicture.asset(
                    "lib/resources/images/interest_remove_selected.svg")
                : SvgPicture.asset("lib/resources/images/interest_remove.svg")
          ]),
        ),
      ));
    });
    return items;
  }

  void updateAreas() {
    goalAreaList.clear();
    int index = goalTypeList.indexOf(selectedGoalType);
    areaResponse?.achiever[index].subTypes.forEach((element) {
      goalAreaList.add(element);
    });
  }

  selectInterestsLayout() {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.only(top: 20, left: 0, right: 0),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 1, color: outlineGrey),
      //   borderRadius: const BorderRadius.all(
      //     Radius.circular(3),
      //   ),
      // ),
      child: Wrap(children: interestItems()),
    );
  }

  List<Widget> interestItems() {
    List<Widget> items = [];
    someoneElse.asMap().forEach((index, element) {
      items.add(Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: interestNotSelected,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedSomeoneIndex = index;
              });
            },
            child: Text(
              element.name,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: secondaryColor),
            ),
          ),
          Container(
            height: 24,
            width: 12,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  someoneElse.removeAt(index);
                });
              },
              child:
                  SvgPicture.asset("lib/resources/images/interest_remove.svg"))
        ]),
      ));
    });
    return items;
  }

  @override
  bool get wantKeepAlive => true;
}
