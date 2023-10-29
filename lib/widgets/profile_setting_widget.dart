import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/flags_and_code.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/widgets/bordered_edit_text.dart';
import 'package:mycareteam/widgets/calendar_or_dropdown.dart';

class ProfileSettingWidget extends StatefulWidget {

  const ProfileSettingWidget({Key? key})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldGrey,
      floatingActionButton: Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.fromLTRB(0, 0, 8, 16),
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: () {
                  setState(() {
                    isFirstScreen = !isFirstScreen;
                  });
                },
                child: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                ),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: isFirstScreen
              ? Column(
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amberAccent,
                              ),
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
                  Row(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        margin: const EdgeInsets.only(top: 24),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
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
                  Container(
                    margin: const EdgeInsets.only(top: 20),
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
                        labelText: "Phone number",
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
                                    padding: EdgeInsets.only(left: 4),
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
                  BorderedEditText(
                      label: "email",
                      hint: "Enter email *",
                      controller: _emailController)
                ])
              : Column(
                  children: [
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
                              label: "Gender",
                              hint: "",
                              suffixIcon: "dropdownArrow"),
                          Container(
                            height: 70,
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 30, left: 10),
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
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        dropDownString,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: secondaryColor),
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
                    const CalendarOrDropDown(
                        label: "NDIS Number",
                        hint: "Enter NDIS Number",
                        suffixIcon: "ndis_right_arrow"),
                    Row(
                      children: [
                        const Expanded(
                          child: CalendarOrDropDown(
                              label: "NDIS Plan Start Date",
                              hint: "00-00-0000",
                              suffixIcon: "calendar"),
                        ),
                        Container(
                          width: 10,
                        ),
                        const Expanded(
                          child: CalendarOrDropDown(
                              label: "NDIS Plan End Date",
                              hint: "00-00-0000",
                              suffixIcon: "calendar"),
                        ),
                      ],
                    ),
                    Container(
                      height: 70,
                      child: Stack(children: [
                        const CalendarOrDropDown(
                            label: "Country",
                            hint: "",
                            suffixIcon: "dropdownArrow"),
                        Container(
                          height: 70,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 30, left: 10),
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
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      dropDownString,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: secondaryColor),
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
                      margin: EdgeInsets.only(top: 24),
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(15, 0, 0, 0),
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
                            label: "State",
                            hint: "",
                            suffixIcon: "dropdownArrow"),
                        Container(
                          height: 70,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 30, left: 10),
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
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text(
                                      dropDownString,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: secondaryColor),
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
                    Container(
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
        padding: EdgeInsets.fromLTRB(0, 0, 6, 6),
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
}
