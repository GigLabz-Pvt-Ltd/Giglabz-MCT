import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/get_roles_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/entry/forgot_password_screen.dart';
import 'package:mycareteam/screens/entry/register_screen.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/screens/home/profile_screen.dart';
import 'package:mycareteam/widgets/user_type_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_service.dart';
import '../../models/login_response.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;
  bool isSelectOpen = false;
  bool isParticipant = false;
  bool isFamily = false;
  bool isProvider = false;
  bool isReviewer = false;
  bool passwordVisible = true;
  var selectedRole = -1;
  List<Roles>? roles;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                            "Enter the information you entered while registering",
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
                  InkWell(
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(color: outlineGrey),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextField(
                        controller: _userNameController,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your user name *',
                          hintStyle: GoogleFonts.poppins(
                            color: iconGrey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          suffixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: iconGrey,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
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
                            )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                value: isRememberMe,
                                onChanged: (bool? value) =>
                                    setState(() => isRememberMe = value!),
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (!states
                                      .contains(MaterialState.selected)) {
                                    return Colors.transparent;
                                  }
                                  return primaryColor;
                                }),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                      width: 1.0,
                                      color: isRememberMe
                                          ? primaryColor
                                          : secondaryColor),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: GoogleFonts.poppins(
                              color: secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ForgotPasswordScreen())),
                        child: Text(
                          "Forgot Password?",
                          style: GoogleFonts.poppins(
                            color: secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (selectedRole == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Select a Role")));
                        return;
                      }
                      if (_userNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter User Name")));
                        return;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(_userNameController.text);
                      if (!emailValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Invalid User Name")));
                        return;
                      }
                      if (_passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter Password")));
                        return;
                      }
                      LoginResponse response = await ApiService().login(
                          _userNameController.text,
                          _passwordController.text,
                          selectedRole + 1);
                      if (response.statusCode != null) {
                        if (response.statusCode == 200) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          Map<String, dynamic> user = {
                            'user_name': _userNameController.text,
                            'role_id': selectedRole + 1
                          };
                          bool result =
                              await prefs.setString('user', jsonEncode(user));
                          // var s = await prefs.setString("isFirstTime", "true");
                          String? isFirstTime = prefs.getString('isFirstTime');

                          if (isFirstTime == "true") {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const ProfileScreen()),
                                (Route route) => false);
                          } else {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const HomeScreen()));
                          }
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response.message.toString())));
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
                          "Login",
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
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RegisterScreen())),
                        child: Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: Text(
                            "Register",
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
}
