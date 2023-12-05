import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/create_goal.dart';
import 'package:mycareteam/models/create_goal_response.dart';
import 'package:mycareteam/models/create_milestone.dart';
import 'package:mycareteam/models/get_dashboard_response.dart';
import 'package:mycareteam/models/share_goal.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareGoalWidget extends StatefulWidget {
  ShareGoalWidget({
    Key? key,
    required int this.goalId,
  }) : super(key: key);

  int goalId;
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
  List<FamilyColleagueList> people = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Trackability allows you to share your goals to Family, Friends, Colleagues, Motivators etc. You can also add a reviewer to track and monitor your goals...",
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
                  "Reviewer",
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return addPeopleDialog("");
                    });
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 14, right: 20),
              child: selectedOption == 0
                  ? SvgPicture.asset("lib/resources/images/add_people.svg")
                  : SvgPicture.asset("lib/resources/images/add_reviewer.svg"),
            ),
          )
        ]),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: people.length,
            itemBuilder: (context, index) {
              return peopleTile(index);
            }),
        if (people.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () async {
                // var response = await ApiService().createMilestone(
                //     CreateMilestone(
                //         expectedOutcome: _outcomeController.text,
                //         breakdown: selectedOption,
                //         milestone: milestone,
                //         goalId: widget.goalId));

                // if (response.responseStatus == 200) {
                //   showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return okDialog("");
                //       });
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text(response.responseMessage)));
                // }
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

  StatefulWidget addPeopleDialog(String fromDialog) {
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
                          "Add People",
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
                      border: InputBorder.none,
                      hintText: 'Enter First Name',
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
                      border: InputBorder.none,
                      hintText: 'Enter Last Name',
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
                      border: InputBorder.none,
                      hintText: 'Enter email',
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
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Phone Number',
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
                        "Role",
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
                      hintText: 'Write Reason',
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
                        "Permissions",
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
                                items:
                                    goalRecurring.map((String dropDownString) {
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("First name can't be empty")));
                      return;
                    }
                    if (_lastnameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Last name can't be empty")));
                      return;
                    }
                    people.add(FamilyColleagueList(
                        firstName: _firstnameController.text,
                        lastName: _lastnameController.text,
                        email: _emailController.text,
                        phoneNo: _phoneNumController.text,
                        role: selectedPeopleRole,
                        shareReason: _reasonController.text,
                        notificatioin: 0,
                        editable: false,
                        view: selectedPeoplePermission == "View access" ? 0 : 1,
                        frequency: selectedPeoplePermission == "View access"
                            ? ""
                            : selectedFrequency));
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
            Text(
              people[index].firstName ?? "SomeText",
              style: GoogleFonts.poppins(
                color: iconBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              people[index].lastName ?? "SomeText",
              style: GoogleFonts.poppins(
                color: secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                people[index].email ?? "SomeText",
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
                // people.removeAt(index);
                // update();
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
                    Text(
                     peoplePermissions[people[index].view] +", "+ people[index].frequency ?? "SomeText",
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
      ]),
    );
  }

  void update() async {
    setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
