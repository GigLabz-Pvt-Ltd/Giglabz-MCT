import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/flags_and_code.dart';
import 'package:mycareteam/models/get_roles_response.dart';
import 'package:mycareteam/models/register_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/resources/constants/const.dart';
import 'package:mycareteam/screens/entry/login_screen.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:mycareteam/widgets/user_type_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSelectOpen = false;
  bool isParticipant = false;
  bool isFamily = false;
  bool isProvider = false;
  bool isReviewer = false;
  bool passwordVisible = true;
  bool rePasswordVisible = true;
  var selectedCountry = countries[0];
  var selectedRole = -1;
  List<Roles>? roles;
  var otpFull = false;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  FocusNode fNode1 = FocusNode();
  FocusNode fNode2 = FocusNode();
  FocusNode fNode3 = FocusNode();
  FocusNode fNode4 = FocusNode();
  FocusNode fNode5 = FocusNode();
  FocusNode fNode6 = FocusNode();

  final TextEditingController _1otpController = TextEditingController();
  final TextEditingController _2otpController = TextEditingController();
  final TextEditingController _3otpController = TextEditingController();
  final TextEditingController _4otpController = TextEditingController();
  final TextEditingController _5otpController = TextEditingController();
  final TextEditingController _6otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getRoles();

    if (roles != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 32),
                    child: SvgPicture.asset(
                      "lib/resources/images/app_logo.svg",
                      width: 226,
                      height: 108,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 32),
                          child: Text(
                            "Hey 👋",
                            style: GoogleFonts.poppins(
                              color: darkGrey,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Please choose your required role from the below drop down for registration",
                            style: GoogleFonts.poppins(
                              color: blueGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelectOpen = !isSelectOpen;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        borderRadius: isSelectOpen
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(3),
                                topRight: Radius.circular(3),
                              )
                            : const BorderRadius.all(Radius.circular(3)),
                        color: primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (selectedRole == 0)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(
                                "lib/resources/icons/ic_participant.svg",
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          if (selectedRole == 1)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(
                                "lib/resources/icons/ic_family.svg",
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          if (selectedRole == 2)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(
                                "lib/resources/icons/ic_provider.svg",
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          if (selectedRole == 3)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: SvgPicture.asset(
                                "lib/resources/icons/ic_reviewer.svg",
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ),
                          Text(
                            selectedRole != -1
                                ? roles![selectedRole].name
                                : "Select *",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            isSelectOpen
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isSelectOpen)
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            width: 2,
                            color: borderGrey,
                          ),
                          right: BorderSide(
                            width: 2,
                            color: borderGrey,
                          ),
                          top: BorderSide(
                            width: 2,
                            color: borderGrey,
                          ),
                          bottom: BorderSide(
                            width: 2,
                            color: borderGrey,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                // isParticipant = true;
                                isSelectOpen = false;
                                // isFamily = false;
                                // isProvider = false;
                                // isReviewer = false;
                                selectedRole = 0;
                              });
                            },
                            child: UserTypeTile(
                              userIcon:
                                  "lib/resources/icons/ic_participant.svg",
                              userType: roles![0].name,
                              userDescription: roles![0].description,
                            ),
                          ),
                          Divider(
                            color: dividerGrey,
                            indent: 40,
                            endIndent: 12,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // isParticipant = false;
                                isSelectOpen = false;
                                // isFamily = true;
                                // isProvider = false;
                                // isReviewer = false;
                                selectedRole = 1;
                              });
                            },
                            child: UserTypeTile(
                              userIcon: "lib/resources/icons/ic_family.svg",
                              userType: roles![1].name,
                              userDescription: roles![1].description,
                            ),
                          ),
                          Divider(
                            color: dividerGrey,
                            indent: 40,
                            endIndent: 12,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // isParticipant = false;
                                isSelectOpen = false;
                                // isFamily = false;
                                // isProvider = true;
                                // isReviewer = false;
                                selectedRole = 2;
                              });
                            },
                            child: UserTypeTile(
                              userIcon: "lib/resources/icons/ic_provider.svg",
                              userType: roles![2].name,
                              userDescription: roles![2].description,
                            ),
                          ),
                          Divider(
                            color: dividerGrey,
                            indent: 40,
                            endIndent: 12,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                // isParticipant = false;
                                isSelectOpen = false;
                                // isFamily = false;
                                // isProvider = false;
                                // isReviewer = true;
                                selectedRole = 3;
                              });
                            },
                            child: UserTypeTile(
                              userIcon: "lib/resources/icons/ic_reviewer.svg",
                              userType: roles![3].name,
                              userDescription: roles![3].description,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (selectedRole != -1)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: _firstNameController,
                              maxLines: 1,
                              maxLength: 50,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                hintText: 'First name *',
                                hintStyle: GoogleFonts.poppins(
                                  color: iconGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: _lastNameController,
                              maxLines: 1,
                              maxLength: 50,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: 'Last name *',
                                hintStyle: GoogleFonts.poppins(
                                  color: iconGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: SizedBox(
                            width: double.infinity,
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
                                border: InputBorder.none,
                                hintText: 'Phone number *',
                                hintStyle: GoogleFonts.poppins(
                                  color: iconGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                    items: countries
                                        .map((FlagsAndCode dropDownString) {
                                      return DropdownMenuItem<FlagsAndCode>(
                                        value: dropDownString,
                                        child: Row(children: [
                                          Image.asset(
                                            "lib/resources/images/" +
                                                dropDownString.svg! +
                                                ".png",
                                            width: 30,
                                            height: 20,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Text(
                                              "(" + dropDownString.code! + ")",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: iconGrey),
                                            ),
                                          ),
                                        ]),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                suffixIcon: SvgPicture.asset(
                                  "lib/resources/icons/ic_verified.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: _emailController,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email address *',
                                hintStyle: GoogleFonts.poppins(
                                  color: iconGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: SvgPicture.asset(
                                  "lib/resources/icons/ic_verified.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: _passwordController,
                              obscureText: passwordVisible,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your password *',
                                hintStyle: GoogleFonts.poppins(
                                  color: iconGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                      },
                                    );
                                  },
                                  icon: passwordVisible
                                      ? const Icon(
                                          Icons.visibility_off_outlined,
                                          color: iconGrey,
                                          size: 24,
                                        )
                                      : const Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: iconGrey,
                                          size: 24,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          margin: const EdgeInsets.only(top: 24),
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: outlineGrey),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: _repasswordController,
                              obscureText: rePasswordVisible,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: secondaryColor),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Re-Enter password *',
                                  hintStyle: GoogleFonts.poppins(
                                    color: iconGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          rePasswordVisible =
                                              !rePasswordVisible;
                                        },
                                      );
                                    },
                                    icon: rePasswordVisible
                                        ? const Icon(
                                            Icons.visibility_off_outlined,
                                            color: iconGrey,
                                            size: 24,
                                          )
                                        : const Icon(
                                            Icons.remove_red_eye_outlined,
                                            color: iconGrey,
                                            size: 24,
                                          ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  GestureDetector(
                    onTap: () async {
                      if (selectedRole == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Select a Role")));
                        return;
                      }
                      if (_firstNameController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter first name")));
                        return;
                      }
                      if (_lastNameController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter last name")));
                        return;
                      }
                      if (_phoneNumController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Enter phone number")));
                        return;
                      }
                      final bool phoneValid = RegExp(
                          r'^[0-9]{10}$')
                          .hasMatch(_phoneNumController.text);
                      if (!phoneValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Phone Number is not valid")));
                        return;
                      }
                      if (_passwordController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter password")));
                        return;
                      }
                      if (_repasswordController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Re-enter password")));
                        return;
                      }
                      if (_passwordController.text !=
                          _repasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Passwords don't match")));
                        return;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                          .hasMatch(_emailController.text);
                      if (!emailValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid Email")));
                        return;
                      }
                      if (!isPasswordValid(_passwordController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Password should be atlest 8 characters with one Upper, one lower case, one number and one special character")));
                        return;
                      }
                      RegisterResponse response = await ApiService().register(
                          _firstNameController.text,
                          _lastNameController.text,
                          selectedCountry.code! + _phoneNumController.text,
                          _emailController.text,
                          _passwordController.text,
                          _repasswordController.text,
                          selectedRole + 1);
                      if (response.responseStatus != null) {
                        if (response.responseStatus == 200) {
                          otpFull = false;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return okDialog("update_profile");
                              });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(response.responseMessage.toString())));
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      margin: const EdgeInsets.only(top: 32, bottom: 20),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Register",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Divider(),
                        ),
                      ),
                      Text(
                        "or",
                        style: GoogleFonts.poppins(
                          color: iconBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Divider(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(
                          "lib/resources/images/google.svg",
                          width: 30,
                          height: 30,
                        ),
                        SvgPicture.asset(
                          "lib/resources/images/instagram.svg",
                          width: 30,
                          height: 30,
                        ),
                        SvgPicture.asset(
                          "lib/resources/images/linkedin.svg",
                          width: 30,
                          height: 30,
                        ),
                        SvgPicture.asset(
                          "lib/resources/images/facebook.svg",
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.poppins(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: CircularProgressIndicator(
          color: primaryColor,
        )));
  }

  void getRoles() async {
    GetRolesResponse response = await ApiService().getRoles();
    if (roles == null) {
      setState(() {
        roles = response.roles;
      });
    }
  }

  bool isPasswordValid(String text) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (text.isEmpty) {
      return false;
    } else {
      if (!regex.hasMatch(text)) {
        return false;
      } else {
        return true;
      }
    }
  }

  Widget okDialog(String fromDialog) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.fromLTRB(25, 12, 12, 25),
          decoration: const BoxDecoration(
              color: scaffoldGrey,
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                      "lib/resources/images/close_verify_otp.svg")),
              Padding(
                padding: EdgeInsets.only(right: 13),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor),
                      ),
                      TextSpan(
                        text: 'Verify Email OTP',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 14, right: 13),
                child: Text(
                  "Please enter the OTP sent to",
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 14, right: 13),
                  child: Text(
                    _emailController.text,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: secondaryColor),
                  )),
              Container(
                height: 44,
                padding: EdgeInsets.only(right: 13),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 44,
                        width: 28,
                        margin: const EdgeInsets.only(top: 22),
                        child: TextField(
                          controller: _1otpController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: iconBlue),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          focusNode: fNode1,
                          onChanged: (value) {
                            updateOtpBtn(setState);
                            if (value.length == 1) {
                              fNode2.requestFocus();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 28,
                        margin: const EdgeInsets.only(top: 22),
                        child: TextField(
                          controller: _2otpController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: iconBlue),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          focusNode: fNode2,
                          onChanged: (value) {
                            updateOtpBtn(setState);

                            if (value.length == 1) {
                              fNode3.requestFocus();
                            }
                            if (value.length == 0) {
                              fNode1.requestFocus();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 28,
                        margin: const EdgeInsets.only(top: 22),
                        child: TextField(
                          controller: _3otpController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: iconBlue),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          focusNode: fNode3,
                          onChanged: (value) {
                            updateOtpBtn(setState);

                            if (value.length == 1) {
                              fNode4.requestFocus();
                            }
                            if (value.length == 0) {
                              fNode2.requestFocus();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 28,
                        margin: const EdgeInsets.only(top: 22),
                        child: TextField(
                          controller: _4otpController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: iconBlue),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          focusNode: fNode4,
                          onChanged: (value) {
                            updateOtpBtn(setState);

                            if (value.length == 1) {
                              fNode5.requestFocus();
                            }
                            if (value.length == 0) {
                              fNode3.requestFocus();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 28,
                        margin: const EdgeInsets.only(top: 22),
                        child: TextField(
                          controller: _5otpController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: iconBlue),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          focusNode: fNode5,
                          onChanged: (value) {
                            updateOtpBtn(setState);
                            if (value.length == 1) {
                              fNode6.requestFocus();
                            }
                            if (value.length == 0) {
                              fNode4.requestFocus();
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 28,
                        margin: const EdgeInsets.only(top: 22),
                        child: TextField(
                          controller: _6otpController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: iconBlue),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            counterText: "",
                          ),
                          focusNode: fNode6,
                          onChanged: (value) {
                            updateOtpBtn(setState);
                            if (value.length == 0) {
                              fNode5.requestFocus();
                            }
                          },
                        ),
                      ),
                    ]),
              ),
              GestureDetector(
                onTap: () async {
                  if (!otpFull) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Enter OTP...")));
                    return;
                  }
                  var code = _1otpController.text +
                      _2otpController.text +
                      _3otpController.text +
                      _4otpController.text +
                      _5otpController.text +
                      _6otpController.text;
                  var res = await ApiService().emailVerify(
                      _emailController.text, code, _emailController.text);
                  if (res.responseStatus == 200) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    bool result = await prefs.setString('isFirstTime', "true");

                    Navigator.pop(context);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginScreen()),
                        (Route<dynamic> route) => false);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Registration successful...")));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Registration not successful...")));
                  }
                },
                child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 24, right: 13),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: !otpFull
                          ? iconBlue.withOpacity(0.5)
                          : iconBlue.withOpacity(1),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Center(
                      child: Text(
                        "Enter OTP",
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
    });
  }

  void updateOtpBtn(Function set) {
    if (_1otpController.text.isEmpty ||
        _2otpController.text.isEmpty ||
        _3otpController.text.isEmpty ||
        _4otpController.text.isEmpty ||
        _5otpController.text.isEmpty ||
        _6otpController.text.isEmpty) {
      set(() {
        otpFull = false;
      });
    } else {
      set(() {
        otpFull = true;
      });
    }
  }
}
