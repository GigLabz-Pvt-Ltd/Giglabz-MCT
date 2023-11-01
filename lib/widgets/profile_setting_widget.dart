import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/flags_and_code.dart';
import 'package:mycareteam/models/get_profile_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/widgets/bordered_edit_text.dart';
import 'package:mycareteam/widgets/calendar_or_dropdown.dart';

class ProfileSettingWidget extends StatefulWidget {
  ProfileSettingWidget({Key? key, required GetProfileResponse this.user})
      : super(key: key);

  GetProfileResponse user;
  @override
  State<ProfileSettingWidget> createState() => _ProfileSettingWidgetState();
}

class _ProfileSettingWidgetState extends State<ProfileSettingWidget> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumController = TextEditingController();
  var selectedCountry = countries[0];
  final _emailController = TextEditingController();
  var selectedGender = genders[0];
  DateTime selectedDate = DateTime.now();
  bool isFirstScreen = true;
  bool ndisFilled = false;
  var selectedInterest = null;

  List<bool> toggleValues = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(4, 14, 0, 0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              child: Image.network(
                                  widget.user.participant.profilePic!)),
                        ),
                        Positioned(
                          top: 63,
                          left: 63,
                          child: Container(
                            height: 37,
                            width: 37,
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: cameraBg,
                            ),
                            child: SvgPicture.asset(
                                "lib/resources/images/camera.svg"),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gabriel Jackson",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                            ),
                            Text(
                              "Participant",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              Container(
                height: 88,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
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
              ),
              Row(mainAxisSize: MainAxisSize.max, children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: const EdgeInsets.only(top: 24),
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
                        hintText: 'Enter any other interests',
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
                    var a = _firstNameController.text;
                    var b = a;
                  },
                  child: Container(
                    height: 40,
                    width: 82,
                    margin: const EdgeInsets.fromLTRB(13, 24, 0, 0),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("lib/resources/images/add.svg"),
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              "ADD",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ]),
                  ),
                )
              ]),
              BorderedEditText(
                  label: "First Name",
                  hint: "Enter First Name *",
                  controller: _firstNameController),
              BorderedEditText(
                  label: "Last Name",
                  hint: "Enter Last Name *",
                  controller: _lastNameController),
              Stack(children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: outlineGrey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: TextField(
                    controller: _phoneNumController,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: GoogleFonts.poppins(
                        color: iconBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      // focusedBorder: const OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: outlineGrey,
                      //   ),
                      // ),
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: outlineGrey,
                        ),
                      ),
                      labelText: "",
                      border: InputBorder.none,
                      hintText: 'Enter Phone number *',
                      prefixIcon: DropdownButtonHideUnderline(
                        child: DropdownButton<FlagsAndCode>(
                          alignment: Alignment.center,
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (FlagsAndCode? newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                            });
                          },
                          value: selectedCountry,
                          items: countries.map((FlagsAndCode dropDownString) {
                            return DropdownMenuItem<FlagsAndCode>(
                              value: dropDownString,
                              child: Row(children: [
                                SvgPicture.asset(
                                  "lib/resources/images/${dropDownString.svg!}.svg",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    "(${dropDownString.code!})",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: iconGrey),
                                  ),
                                ),
                              ]),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: const EdgeInsets.only(top: 12, left: 16),
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      color: Colors.white,
                      child: Text(
                        "Phone Number",
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor),
                      )),
                )
              ]),
              BorderedEditText(
                  label: "email",
                  hint: "Enter email *",
                  controller: _emailController),
              Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: CalendarOrDropDown(
                        label: "Date of birth",
                        hint: selectedDate.day.toString() +
                            "-" +
                            selectedDate.month.toString() +
                            "-" +
                            selectedDate.year.toString(),
                        suffixIcon: "calendar"),
                  ),
                ),
                Container(
                  width: 10,
                ),
                Expanded(
                  child: Stack(children: [
                    const CalendarOrDropDown(
                        label: "Gender", hint: "", suffixIcon: "dropdownArrow"),
                    Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 30, left: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          alignment: Alignment.center,
                          icon: const Icon(null),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                          value: selectedGender,
                          items: genders.map((String dropDownString) {
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
              ]),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ndisPlanInfoDialog();
                      });
                },
                child: CalendarOrDropDown(
                    label: "NDIS Number",
                    hint: "Enter NDIS Number",
                    suffixIcon: !ndisFilled ? "ndis_right_arrow" : null,
                    bgColor: ndisFilled ? ndisSelectedBg : null),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ndisPlanInfoDialog();
                      });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: CalendarOrDropDown(
                          label: "NDIS Plan Start Date",
                          hint: "00-00-0000",
                          suffixIcon: "calendar",
                          bgColor: ndisFilled ? ndisSelectedBg : null),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      child: CalendarOrDropDown(
                          label: "NDIS Plan End Date",
                          hint: "00-00-0000",
                          suffixIcon: "calendar",
                          bgColor: ndisFilled ? ndisSelectedBg : null),
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                child: Stack(children: [
                  const CalendarOrDropDown(
                      label: "Country", hint: "", suffixIcon: "dropdownArrow"),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        icon: const Icon(null),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                        value: selectedGender,
                        items: genders.map((String dropDownString) {
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
              Container(
                height: 44,
                margin: const EdgeInsets.only(top: 24),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      color: secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: GoogleFonts.poppins(
                      color: iconBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: outlineGrey,
                      ),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: outlineGrey,
                      ),
                    ),
                    labelText: "Postal Code",
                    border: InputBorder.none,
                    hintText: 'Postal Code *',
                  ),
                ),
              ),
              Container(
                height: 70,
                child: Stack(children: [
                  const CalendarOrDropDown(
                      label: "State", hint: "", suffixIcon: "dropdownArrow"),
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        alignment: Alignment.center,
                        icon: const Icon(null),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                        value: selectedGender,
                        items: genders.map((String dropDownString) {
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
              BorderedEditText(
                  label: "Area / Sub urban",
                  hint: "Sub Area Name *",
                  controller: _emailController),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "About Me",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: blueGrey),
                    ),
                  )),
              aboutMeWidget(),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return okDialog("update_profile");
                      });
                },
                child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Center(
                      child: Text(
                        "Update Profile",
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

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
          minLines: 1,
          maxLines: 2,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w400, color: secondaryColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write your Bio, e.g your hobbies, interests, etc...',
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

  Widget ndisPlanInfoDialog() {
    return Dialog(
      child: Container(
        height: 364,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: alertDialogTitleBg,
                  borderRadius: BorderRadius.all(Radius.circular(3.0))),
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NDIS Plan Information",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                          child: SvgPicture.asset(
                              "lib/resources/images/dialog_close.svg")),
                    ),
                  ]),
            ),
            Container(
              height: 44,
              margin: const EdgeInsets.only(top: 24, left: 20, right: 20),
              child: TextField(
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: secondaryColor),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    color: iconBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: outlineGrey,
                    ),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: outlineGrey,
                    ),
                  ),
                  labelText: "NDIS Number",
                  border: InputBorder.none,
                  hintText: 'Enter NDIS Number',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CalendarOrDropDown(
                    label: "NDIS Plan Start Date",
                    hint: "00-00-0000",
                    suffixIcon: "calendar"),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CalendarOrDropDown(
                    label: "NDIS Plan End Date",
                    hint: "00-00-0000",
                    suffixIcon: "calendar"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  "Your NDIS Plan Expiry",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                ),
                Container(
                  height: 2,
                  width: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: dividerGrey,
                ),
                Text(
                  "Days",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                ),
              ]),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  ndisFilled = true;
                });
              },
              child: Container(
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
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
              if (fromDialog == "update_profile")
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please Complete the ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: 'NDIS',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: ' Declaration Form',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: secondaryColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
              if (fromDialog == "ndis_agreement")
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please Complete the ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
              if (fromDialog == "terms_and_conditions")
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Your Profile has been ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: 'Updated ',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor),
                          ),
                          TextSpan(
                            text: 'Successfully',
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
                  if (fromDialog == "update_profile") {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ndisAgreementDialog();
                        });
                  }
                  if (fromDialog == "ndis_agreement") {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return termsAndConditionsDialog();
                        });
                  }
                  if (fromDialog == "terms_and_conditions") {
                    Navigator.pop(context);
                  }
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

  Widget ndisAgreementDialog() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          child: Stack(children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: alertDialogTitleBgLite,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          "Confirm that the following topics have been discussed and understood by the participant.",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: iconBlack),
                        ),
                      ),
                      toggle(0,
                          "Plan Funding Included in the participant’s NDIS Plan"),
                      toggle(1,
                          "The different support categories and their flexibility"),
                      toggle(2, "Fund management and claiming"),
                      toggle(3,
                          "Organising and planning supports over the life of the NDIS Plan"),
                      toggle(
                          4, "The role of community and mainstream supports"),
                      toggle(5,
                          "How to access and use the My NDIS portal and App"),
                      toggle(
                          6, "The value and importance of service agreements"),
                      toggle(7,
                          "If any supports have been listed in the plan, the participant knows who can deliver the support and how it may be provided"),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return okDialog("ndis_agreement");
                              });
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                            decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            child: Center(
                              child: Text(
                                "Submit",
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
            Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: alertDialogTitleBg,
                  borderRadius: BorderRadius.all(Radius.circular(3.0))),
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "NDIS Agreement",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                          child: SvgPicture.asset(
                              "lib/resources/images/dialog_close.svg")),
                    ),
                  ]),
            ),
          ]),
        );
      },
    );
  }

  toggle(int toggleValueIndex, String message) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(message)),
            Container(
              width: 8,
            ),
            FlutterSwitch(
              height: 22,
              width: 40,
              value: toggleValues[toggleValueIndex],
              toggleSize: 20,
              padding: 2,
              valueFontSize: 10,
              borderRadius: 10,
              activeToggleColor: activeToggle,
              inactiveColor: toggleTrack,
              activeColor: toggleTrack,
              inactiveIcon:
                  SvgPicture.asset("lib/resources/images/toggle_inactive.svg"),
              onToggle: (val) {
                setState(() {
                  toggleValues[toggleValueIndex] = val;
                });
              },
            ),
          ],
        ),
      );
    });
  }

  Widget termsAndConditionsDialog() {
    return Dialog(
      child: Stack(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Text(
                      termsAndCondition,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: iconBlack),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return okDialog("terms_and_conditions");
                          });
                    },
                    child: Container(
                        height: 40,
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Center(
                          child: Text(
                            "Accept",
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
        Container(
          height: 50,
          decoration: const BoxDecoration(
              color: alertDialogTitleBg,
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          padding: const EdgeInsets.only(left: 24),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Terms and Conditions",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                  child: SvgPicture.asset(
                      "lib/resources/images/dialog_close.svg")),
            ),
          ]),
        ),
      ]),
    );
  }
}
