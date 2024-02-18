import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/create_milestone.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/models/get_goal_milestone.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalOutComesWidget extends StatefulWidget {
  GoalOutComesWidget({
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
  State<GoalOutComesWidget> createState() => _GoalSummaryWidgetState();
}

class _GoalSummaryWidgetState extends State<GoalOutComesWidget>
    with AutomaticKeepAliveClientMixin<GoalOutComesWidget> {
  Object? goalFor, goalType, shareGoalTo, goalArea = 1;
  int selectedOption = 1;
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
  bool isBeingEdited = false;
  GetMilestone? getOutcome;
  var outcome_name;
  List<AddMilestone>? get_milestone;
  int? break_down;
  int radio=0;
  var sDate, eDate;

  @override
  void initState() {
    super.initState();
    init();
  }

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
              hintText: outcome_name!=null? outcome_name : 'Enter Expected Outcome of this Goal *',
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
              "Do you want to breakdown one time achievement goal into multiple milestones ? ",
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
                      if (radio == 1) {
                        return iconBlue;
                      }
                      if (selectedOption == 1) {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 1,
                  groupValue: radio!=null? radio : selectedOption,
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
                        if (radio == 0) {
                          return iconBlue;
                        }
                        if (selectedOption == 0) {
                          return iconBlue;
                        }
                        return borderGrey;
                      },
                    ),
                    value: 0,
                    focusColor: grey,
                    groupValue: radio!=null? radio : selectedOption,
                    onChanged: (value) async {
                      if (_outcomeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Outcome cannot be empty")));
                        return;
                      }
                      var response = await ApiService().createMilestone(
                          CreateMilestone(
                              expectedOutcome: _outcomeController.text,
                              breakdown: 0,
                              milestone: null,
                              goalId: widget.goalId));

                      if (response.responseStatus == 200) {
                        setState(() {
                          selectedOption = int.parse(value.toString());
                          print("Button value: $value");
                          // milestone.clear();
                          widget.updateTab(2, widget.goalStart, widget.goalEnd);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response.responseMessage)));
                      }
                    }
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
        if (selectedOption == 1 || (radio!=null && radio==1))
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      _titleController.text = "";
                      _descriptionController.text = "";
                      selectedStartDate = null;
                      selectedEndDate = null;
                      selectedCelebration = "Yes";
                      selectedPercent = "10%";
                      return addMilestoneDialog(-1);
                    });
              },
              child: Padding(
                padding: EdgeInsets.only(top: 14, right: 20),
                child:
                    SvgPicture.asset("lib/resources/images/add_milestone.svg"),
              ),
            )
          ]),
        if (selectedOption == 1 || (radio!=null && radio==1))
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: get_milestone!=null? get_milestone!.length : milestone?.length,
              itemBuilder: (context, index) {
                return milestoneTile(index);
              }),
        if (selectedOption == 1 && milestone.isNotEmpty)
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

                if (_outcomeController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Outcome cannot be empty")));
                  return;
                }

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
      initialDate: widget.goalStart!, // Refer step 1
      firstDate: widget.goalStart!,
      lastDate: widget.goalEnd!,
    );
    if (picked != null && picked != selectedDob)
      setInnerState(() {
        selectedStartDate = picked;
      });
    setState(() {
      selectedStartDate = picked;
      selectedEndDate = null;
    });
  }

  selectEndDate(BuildContext context, Function setInnerState) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate!, // Refer step 1
      firstDate: selectedStartDate ?? widget.goalStart!,
      lastDate: widget.goalEnd!,
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
                  setState(() {
                    widget.updateTab(2, widget.goalStart, widget.goalEnd);
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

  setCurrentMileValues(int index) {
    sDate = get_milestone!.length != 0 ? get_milestone![index].startDate.toString() : null;
    eDate = get_milestone!.length != 0 ? get_milestone![index].targetDate.toString() : null;
    _titleController.text = get_milestone!.length!=0? get_milestone![index].name.toString() : milestone[index].name;
    _descriptionController.text = get_milestone!.length!=0? get_milestone![index].description.toString() : milestone[index].description;
    selectedStartDate = DateFormat("dd/MM/yyyy").parse(milestone[index].startDate);
    selectedEndDate = DateFormat("dd/MM/yyyy").parse(milestone[index].targetDate);
    selectedCelebration = get_milestone!.length != 0 ? get_milestone![index].celebrations.toString() : milestone[index].celebrations;
    selectedPercent = get_milestone!.length != 0 ? get_milestone![index].progress.toString() + "%" : milestone[index].progress + "%";
  }

  StatefulWidget addMilestoneDialog(int indx) {
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
                      hintText: 'Enter Name *',
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
                      hintText: 'Enter Description *',
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
                        "Start Date *",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: blueGrey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "End Date *",
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
                        if (widget.goalStart != null) {
                          selectStartDate(context, setState);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Save goal summary")));
                        }
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
                                    sDate!=null? sDate : selectedStartDate != null
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
                        if (selectedStartDate != null) {
                          selectEndDate(context, setState);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Select start date")));
                        }
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
                                    eDate!=null ? eDate : selectedEndDate != null
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
                        "Celebrations *",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: blueGrey),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Progress *",
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
                    if (isBeingEdited) {
                      milestone[indx] = Milestone(
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
                          action: 1);
                    } else {
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
              get_milestone![index].name!=null? get_milestone![index].name.toString() : milestone?[index].name ?? "SomeText",
              style: GoogleFonts.poppins(
                color: iconBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              get_milestone![index].name!=null? get_milestone![index].description.toString() : milestone?[index].description ?? "SomeText",
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
                isBeingEdited = true;
                setCurrentMileValues(index);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addMilestoneDialog(index);
                    }).then((value) => {isBeingEdited = false});
              },
              child: SvgPicture.asset("lib/resources/images/edit_people.svg")),
          SizedBox(
            width: 18,
          ),
          GestureDetector(
              onTap: () {
                milestone.removeAt(index);
                update();
              },
              child:
                  SvgPicture.asset("lib/resources/images/delete_milestone.svg"))
        ]),
        if(milestone?.length!=0 || widget.tabSelected == 3)
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
                      //"SomeText",
                        get_milestone!.length != 0 ? get_milestone![index].startDate.toString() : milestone?[index].startDate ?? "SomeText",
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
                      //"SomeText",
                      get_milestone!.length != 0 ? get_milestone![index].targetDate.toString() : milestone?[index].targetDate ?? "SomeText",
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
                      //"SomeText",
                      get_milestone!.length != 0 ? get_milestone![index].celebrations.toString() :milestone?[index].celebrations ?? "SomeText",
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
            value: 100, //double.parse(milestone[index].progress) / 100,
            minHeight: 6,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ]),
    );
  }

  void init() async{
    print(widget.goalId);
    if(widget.tabSelected == 3){
      getOutcome = await ApiService().getGoalOutcomes(widget.goalId);
      setState(() {
        outcome_name = getOutcome!.expectedOutcome;
        break_down = getOutcome!.breakdown;
        if(break_down!=0){
          radio = 1;
        }
        get_milestone = getOutcome!.milestone!.map((e) => AddMilestone(
          name: e.name,
          description: e.description,
          startDate: e.startDate,
          targetDate: e.targetDate,
          progress: e.progress,
          celebrations: e.celebrations
        )).toList();
      });
      print("$outcome_name, $break_down, $radio");
    }
  }

  void update() async {
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
