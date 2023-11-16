import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class GoalSummaryWidget extends StatefulWidget {
  GoalSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GoalSummaryWidget> createState() => _GoalSummaryWidgetState();
}

class _GoalSummaryWidgetState extends State<GoalSummaryWidget> {
  Object? selectedOption, goalFor, goalArea = 1;
  var selectedInterest = null;

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
                      if (selectedOption == 1) {
                        return goalCategoryBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 1,
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
                      if (selectedOption == 2) {
                        return goalCategoryBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 2,
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
                      if (selectedOption == 3) {
                        return goalCategoryBlue;
                      }
                      return borderGrey;
                    },
                  ),
                  value: 3,
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
                        return goalCategoryBlue;
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
                        return goalCategoryBlue;
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
              Radio(
                fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (goalFor == 1) {
                      return goalCategoryBlue;
                    }
                    return borderGrey;
                  },
                ),
                value: 1,
                groupValue: goalFor,
                onChanged: (value) {
                  setState(() {
                    goalFor = value;
                    print("Button value: $value");
                  });
                },
              ),
              Text(
                "Self",
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
                    if (goalFor == 2) {
                      return goalCategoryBlue;
                    }
                    return borderGrey;
                  },
                ),
                value: 2,
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
            Row(children: [
              Radio(
                fillColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (goalFor == 3) {
                      return goalCategoryBlue;
                    }
                    return borderGrey;
                  },
                ),
                value: 3,
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
}
