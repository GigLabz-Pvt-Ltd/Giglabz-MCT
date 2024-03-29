import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(33, 16, 33, 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 24, bottom: 32),
                  child: SvgPicture.asset(
                    "lib/resources/images/app_logo.svg",
                    width: 226,
                    height: 108,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.west,
                      color: appBlack,
                      size: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 32),
                  child: SvgPicture.asset(
                    "lib/resources/images/forgot_password_email.svg",
                    width: 256,
                    height: 190,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: Text(
                        "Forgot Password?",
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
                        "Don't worry! it happens. Please enter the address associated with your account.",
                        style: GoogleFonts.poppins(
                          color: blueGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email id',
                        hintStyle: GoogleFonts.poppins(
                          color: iconGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: const Icon(
                          Icons.mail_outline_rounded,
                          color: iconGrey,
                          size: 24,
                        ),
                      ),
                    ),
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
                      "Submit",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                    Container(
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
