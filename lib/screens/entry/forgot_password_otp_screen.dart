import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycareteam/resources/constants/colors.dart';
import 'package:mycareteam/screens/entry/forgot_password_reset_screen.dart';
import 'package:mycareteam/screens/entry/register_screen.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
   ForgotPasswordOtpScreen({Key? key, required this.email}) : super(key: key);

String email;
  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  var otpFull = false;

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
                    "lib/resources/images/enter_otp.svg",
                    width: 256,
                    height: 190,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 28),
                      child: Text(
                        "A Four Digit code has been sent to your associated email address",
                        style: GoogleFonts.poppins(
                          color: blueGrey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: outlineGrey),
                    ),
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
                        border: InputBorder.none,
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
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 14, left: 8),
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: outlineGrey),
                    ),
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
                        border: InputBorder.none,
                      ),
                      focusNode: fNode2,
                      onChanged: (value) {
                        updateOtpBtn(setState);
                        fNode2.requestFocus();
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
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 14, left: 8),
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: outlineGrey),
                    ),
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
                        border: InputBorder.none,
                      ),
                      focusNode: fNode3,
                      onChanged: (value) {
                        updateOtpBtn(setState);
                        fNode3.requestFocus();
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
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 14, left: 8),
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: outlineGrey),
                    ),
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
                        border: InputBorder.none,
                      ),
                      focusNode: fNode4,
                      onChanged: (value) {
                        updateOtpBtn(setState);
                        fNode4.requestFocus();
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
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 14, left: 8),
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: outlineGrey),
                    ),
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
                        border: InputBorder.none,
                      ),
                      focusNode: fNode5,
                      onChanged: (value) {
                        updateOtpBtn(setState);
                        fNode5.requestFocus();
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
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(top: 14, left: 8),
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: outlineGrey),
                    ),
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
                        border: InputBorder.none,
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
                Container(
                  margin: const EdgeInsets.only(top: 28),
                  child: Row(children: [
                    Text(
                      "1.20",
                      style: GoogleFonts.poppins(
                        color: blueGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      " sec",
                      style: GoogleFonts.poppins(
                        color: blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Resend Otp",
                      style: GoogleFonts.poppins(
                        decoration: TextDecoration.underline,
                        color: blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    if (!otpFull) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter OTP...")));
                      return;
                    }
                    var codeEntered = _1otpController.text +
                      _2otpController.text +
                      _3otpController.text +
                      _4otpController.text +
                      _5otpController.text +
                      _6otpController.text;
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                             ForgotPasswordResetScreen(email : widget.email, code: codeEntered)));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: !otpFull
                          ? primaryColor.withOpacity(0.5)
                          : primaryColor.withOpacity(1),
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
