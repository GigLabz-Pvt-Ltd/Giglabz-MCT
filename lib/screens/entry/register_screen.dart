import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/models/register_response.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/home/home_screen.dart';
import 'package:mycareteam/service/api_service.dart';
import 'package:mycareteam/widgets/user_type_tile.dart';
import 'dart:developer';

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

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          "Hey, hello 👋",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isParticipant
                              ? "Participant"
                              : isFamily
                                  ? "Family member/Friends"
                                  : isProvider
                                      ? "Provider"
                                      : isReviewer
                                          ? "Reviewer"
                                          : "Select",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                              isParticipant = true;
                              isSelectOpen = false;
                              isFamily = false;
                              isProvider = false;
                              isReviewer = false;
                            });
                          },
                          child: const UserTypeTile(
                            userIcon: "lib/resources/icons/ic_participant.svg",
                            userType: "Participant",
                            userDescription: "Who want to achieve Goal",
                          ),
                        ),
                        const Divider(
                          color: dividerGrey,
                          indent: 40,
                          endIndent: 12,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isParticipant = false;
                              isSelectOpen = false;
                              isFamily = true;
                              isProvider = false;
                              isReviewer = false;
                            });
                          },
                          child: const UserTypeTile(
                            userIcon: "lib/resources/icons/ic_family.svg",
                            userType: "Family member/Friends",
                            userDescription: "To set goal for your well-wisher",
                          ),
                        ),
                        const Divider(
                          color: dividerGrey,
                          indent: 40,
                          endIndent: 12,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isParticipant = false;
                              isSelectOpen = false;
                              isFamily = false;
                              isProvider = true;
                              isReviewer = false;
                            });
                          },
                          child: const UserTypeTile(
                            userIcon: "lib/resources/icons/ic_provider.svg",
                            userType: "Provider",
                            userDescription:
                                "To help Achievers to complete goal",
                          ),
                        ),
                        const Divider(
                          color: dividerGrey,
                          indent: 40,
                          endIndent: 12,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isParticipant = false;
                              isSelectOpen = false;
                              isFamily = false;
                              isProvider = false;
                              isReviewer = true;
                            });
                          },
                          child: const UserTypeTile(
                            userIcon: "lib/resources/icons/ic_reviewer.svg",
                            userType: "Reviewer",
                            userDescription:
                                "Provide feed back on Achievers performance",
                          ),
                        ),
                      ],
                    ),
                  ),
                if (isParticipant || isFamily || isProvider || isReviewer)
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First name',
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last name',
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
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone number',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: const Divider(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        margin: const EdgeInsets.only(top: 11),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          border: Border.all(color: outlineGrey),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email address',
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
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your password',
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
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Re-Enter password',
                                hintStyle: GoogleFonts.poppins(
                                  color: iconGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        rePasswordVisible = !rePasswordVisible;
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
                InkWell(
                  onTap: () async {
                    RegisterResponse response = await ApiService().register(
                        _firstNameController.text,
                        _lastNameController.text,
                        _phoneNumController.text,
                        _emailController.text,
                        _passwordController.text,
                        _repasswordController.text,
                        isParticipant
                            ? 1
                            : isFamily
                                ? 2
                                : isProvider
                                    ? 3
                                    : isReviewer
                                        ? 4
                                        : -1);
                    if (response.responseStatus != null) {
                      if (response.responseStatus == 200) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomeScreen()),
                            (Route<dynamic> route) => false);
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
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
}
