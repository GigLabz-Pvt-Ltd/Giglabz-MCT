import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/create_milestone.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalOutComesWidget extends StatefulWidget {
  GoalOutComesWidget({
    Key? key,
    required int this.goalId,
    required Function this.updateTab,
  }) : super(key: key);

  int goalId;
  Function updateTab;
  @override
  State<GoalOutComesWidget> createState() => _GoalSummaryWidgetState();
}

class _GoalSummaryWidgetState extends State<GoalOutComesWidget> {
  Object? goalFor, goalType, shareGoalTo, goalArea = 1;
  int selectedOption = 0;
  var selectedInterest = null;
  var selectedName = null;
  var selectedRecurring = goalRecurring[0];
  var selectedCelebration = yesNo[0];
  var selectedPercent = progressPercent[0];
  var startSelectedHours = hours[0];
  var startSelectedMinutes = minutes[0];
  var endSelectedHours = hours[0];
  var endSelectedMinutes = minutes[0];
  DateTime? selectedStartDate = null, selectedEndDate = null;
  DateTime selectedDob = DateTime.now();
  final _outcomeController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<Milestone> milestone = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 14, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Outcome",
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
            controller: _outcomeController,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: secondaryColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Expected Outcome of this Goal',
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
              "Do You want to Breakdown one time achievement goal into multiple milestones ? ",
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
                      if (selectedOption == 1) {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = int.parse(value.toString());
                      print("Button value: $value");
                    });
                  },
                ),
                Text(
                  "Yes",
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Row(children: [
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
                    focusColor: grey,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = int.parse(value.toString());
                        print("Button value: $value");
                        milestone.clear();
                        widget.updateTab(2);
                      });
                    },
                  ),
                  Text(
                    "No",
                    style: GoogleFonts.poppins(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
        if (selectedOption == 1)
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: EdgeInsets.only(top: 14, left: 20, right: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Milestones",
                  style: GoogleFonts.poppins(
                    color: blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addMilestoneDialog("");
                    });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 14, right: 20),
                child:
                    SvgPicture.asset("lib/resources/images/add_milestone.svg"),
              ),
            )
          ]),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: milestone?.length,
            itemBuilder: (context, index) {
              return milestoneTile(index);
            }),
        if (milestone.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                var response = await ApiService().createMilestone(
                    CreateMilestone(
                        expectedOutcome: _outcomeController.text,
                        breakdown: selectedOption,
                        milestone: milestone,
                        goalId: widget.goalId));

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
                width: 82,
                margin: EdgeInsets.only(top: 8, right: 20),
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

  selectStartDate(BuildContext context, Function setInnerState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDob)
      setInnerState(() {
        selectedStartDate = picked;
      });
    setState(() {
      selectedStartDate = picked;
    });
  }

  selectEndDate(BuildContext context, Function setInnerState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    setInnerState(() {
      // selectedStartDate = picked;
    });
    if (picked != null && picked != selectedDob)
      setState(() {
        selectedEndDate = picked;
      });
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
                          text: 'Goal Outcomes details are saved Successfully!',
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

  StatefulWidget addMilestoneDialog(String fromDialog) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Dialog(
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
                          "Add Milestone",
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: blueGrey),
                        ),
                        SvgPicture.asset(
                            "lib/resources/images/close_verify_otp.svg"),
                      ]),
                ),
                Divider(
                  color: dividerGrey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Milestone Name",
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
                    controller: _titleController,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Name',
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
                    "Description",
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
                    controller: _descriptionController,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Description',
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
                        "Start Date",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: blueGrey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "End Date",
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
                    child: GestureDetector(
                      onTap: () {
                        selectStartDate(context, setState);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 6, left: 20, right: 8),
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
                                            selectedStartDate!.month
                                                .toString() +
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
                        selectEndDate(context, setState);
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 4, left: 8, right: 20),
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
                  height: 20,
                  margin: const EdgeInsets.only(left: 20, top: 12),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        "Celebrations",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: blueGrey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Progress",
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
                      height: 50,
                      margin: EdgeInsets.only(top: 8, left: 20, right: 8),
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
                                  selectedCelebration = newValue!;
                                });
                              },
                              value: selectedCelebration,
                              items: yesNo.map((String dropDownString) {
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
                  Expanded(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 8, left: 8, right: 20),
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
                                  selectedPercent = newValue!;
                                });
                              },
                              value: selectedPercent,
                              items:
                                  progressPercent.map((String dropDownString) {
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
                    if (_titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Milestone name can't be empty")));
                      return;
                    }
                    if (_descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Description can't be empty")));
                      return;
                    }
                    if (selectedStartDate == null || selectedEndDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Select Start and End date")));
                      return;
                    }
                    milestone.add(Milestone(
                        name: _titleController.text,
                        description: _descriptionController.text,
                        startDate:
                            "${selectedStartDate?.day}/${selectedStartDate?.month}/${selectedStartDate?.year}",
                        targetDate:
                            "${selectedEndDate?.day}/${selectedEndDate?.month}/${selectedEndDate?.year}",
                        celebrations: selectedCelebration,
                        progress: selectedPercent.substring(
                            0, selectedPercent.length - 1),
                        value: false,
                        action: 1));
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
                          "Add Milestone",
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
    });
  }

  Widget milestoneTile(int index) {
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
            Text(
              milestone?[index].name ?? "SomeText",
              style: GoogleFonts.poppins(
                color: iconBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              milestone?[index].celebrations ?? "SomeText",
              style: GoogleFonts.poppins(
                color: secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ]),
          Spacer(),
          GestureDetector(
              onTap: () {
                milestone.removeAt(index);
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
                      "Start Date",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      milestone?[index].startDate ?? "SomeText",
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
                      "End Date",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      milestone?[index].targetDate ?? "SomeText",
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
                      "Celebrations",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      milestone?[index].celebrations ?? "SomeText",
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
          padding: EdgeInsets.only(top: 20),
          child: LinearProgressIndicator(
            backgroundColor: interestNotSelected,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.amber,
            ),
            value: double.parse(milestone[index].progress) / 100,
            minHeight: 6,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ]),
    );
  }

  void update() async {
    setState(() {});
  }
}
