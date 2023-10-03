import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/widgets/user_type_tile.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isSelectOpen = false;

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
                          "Select",
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
                    child: const Column(
                      children: [
                        UserTypeTile(
                          userIcon: "lib/resources/icons/ic_participant.svg",
                          userType: "Participant",
                          userDescription: "Who want to achieve Goal",
                        ),
                        Divider(
                          color: dividerGrey,
                          indent: 40,
                          endIndent: 12,
                        ),
                        UserTypeTile(
                          userIcon: "lib/resources/icons/ic_family.svg",
                          userType: "Family member/Friends",
                          userDescription: "To set goal for your well-wisher",
                        ),
                        Divider(
                          color: dividerGrey,
                          indent: 40,
                          endIndent: 12,
                        ),
                        UserTypeTile(
                          userIcon: "lib/resources/icons/ic_provider.svg",
                          userType: "Provider",
                          userDescription: "To help Achievers to complete goal",
                        ),
                        Divider(
                          color: dividerGrey,
                          indent: 40,
                          endIndent: 12,
                        ),
                        UserTypeTile(
                          userIcon: "lib/resources/icons/ic_reviewer.svg",
                          userType: "Reviewer",
                          userDescription:
                              "Provide feed back on Achievers performance",
                        ),
                      ],
                    ),
                  ),
                Container(
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
