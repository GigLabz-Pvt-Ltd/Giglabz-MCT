import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/entry/login_screen.dart';
import 'package:mycareteam/screens/entry/register_screen.dart';
import 'package:mycareteam/service/api_service.dart';

class ForgotPasswordResetScreen extends StatefulWidget {
  ForgotPasswordResetScreen({Key? key, required this.email, required this.code})
      : super(key: key);

  String email, code;
  @override
  State<ForgotPasswordResetScreen> createState() =>
      _ForgotPasswordResetScreenState();
}

class _ForgotPasswordResetScreenState extends State<ForgotPasswordResetScreen> {
  bool passwordVisible = true;
  bool rePasswordVisible = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

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
                  margin: const EdgeInsets.only(top: 24, bottom: 32),
                  child: SvgPicture.asset(
                    "lib/resources/images/app_logo.svg",
                    width: 226,
                    height: 108,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 12),
                  child: SvgPicture.asset(
                    "lib/resources/images/reset_password.svg",
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
                        "Reset Password?",
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
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  margin: const EdgeInsets.only(top: 24),
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
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(3)),
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
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, left: 12),
                    child: Text(
                      "Must be at least 8 characters",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Both passwords must match.",
                      style: GoogleFonts.poppins(
                        color: secondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_passwordController.text.isEmpty) {
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Passwords don't match")));
                      return;
                    }
                    if (!isPasswordValid(_passwordController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Password should be atlest 8 characters with one Upper, one lower case, one number and one special character")));
                      return;
                    }

                    var res = await ApiService().resetPassword(
                        widget.email, _passwordController.text, widget.code);

                    if (res.responseStatus == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Password reset successful")));

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res.responseMessage)));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.only(top: 15, bottom: 20),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const RegisterScreen()));
                      },
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
}
