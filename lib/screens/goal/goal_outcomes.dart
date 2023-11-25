import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/service/api_service.dart';

class GoalOutComesWidget extends StatefulWidget {
  GoalOutComesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GoalOutComesWidget> createState() => _GoalSummaryWidgetState();
}

class _GoalSummaryWidgetState extends State<GoalOutComesWidget> {
  Object? selectedOption, goalFor, goalType, shareGoalTo, goalArea = 1;
  var selectedInterest = null;
  var selectedName = null;
  var selectedRecurring = goalRecurring[0];
  var startSelectedHours = hours[0];
  var startSelectedMinutes = minutes[0];
  var endSelectedHours = hours[0];
  var endSelectedMinutes = minutes[0];
  DateTime? selectedStartDate = null, selectedEndDate = null;
  DateTime selectedDob = DateTime.now();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

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
            controller: _titleController,
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
                      if (selectedOption == "Yes") {
                        return iconBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: "Yes",
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
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
                        if (selectedOption == "No") {
                          return iconBlue;
                        }
                        return borderGrey;
                      },
                    ),
                    value: "No",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
          Padding(
            padding: EdgeInsets.only(top: 14, right: 20),
            child: SvgPicture.asset(
              "lib/resources/images/add_milestone.svg"),
          )
        ]),
      ]),
    );
  }

  selectGoalArea() {
    return Container(
      height: 88,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: outlineGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: Wrap(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedInterest = 0;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selectedInterest == 0
                    ? interestSelected
                    : interestNotSelected,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Health",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: selectedInterest == 0
                          ? Colors.white
                          : secondaryColor),
                ),
                Container(
                  height: 24,
                  width: 12,
                ),
                selectedInterest == 0
                    ? SvgPicture.asset(
                        "lib/resources/images/interest_remove_selected.svg")
                    : SvgPicture.asset(
                        "lib/resources/images/interest_remove.svg")
              ]),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedInterest = 1;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selectedInterest == 1
                    ? interestSelected
                    : interestNotSelected,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Sports",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: selectedInterest == 1
                          ? Colors.white
                          : secondaryColor),
                ),
                Container(
                  height: 24,
                  width: 12,
                ),
                selectedInterest == 1
                    ? SvgPicture.asset(
                        "lib/resources/images/interest_remove_selected.svg")
                    : SvgPicture.asset(
                        "lib/resources/images/interest_remove.svg")
              ]),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedInterest = 2;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selectedInterest == 2
                    ? interestSelected
                    : interestNotSelected,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Education",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: selectedInterest == 2
                          ? Colors.white
                          : secondaryColor),
                ),
                Container(
                  height: 24,
                  width: 12,
                ),
                selectedInterest == 2
                    ? SvgPicture.asset(
                        "lib/resources/images/interest_remove_selected.svg")
                    : SvgPicture.asset(
                        "lib/resources/images/interest_remove.svg")
              ]),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedInterest = 3;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: selectedInterest == 3
                    ? interestSelected
                    : interestNotSelected,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "Engineering",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: selectedInterest == 3
                          ? Colors.white
                          : secondaryColor),
                ),
                Container(
                  height: 24,
                  width: 12,
                ),
                selectedInterest == 3
                    ? SvgPicture.asset(
                        "lib/resources/images/interest_remove_selected.svg")
                    : SvgPicture.asset(
                        "lib/resources/images/interest_remove.svg")
              ]),
            ),
          ),
        ],
      ),
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
      });
  }

  selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDob, // Refer step 1
      firstDate: DateTime(1900),
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
}
