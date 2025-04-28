import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/functions/authFunctions.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/mobileOtpVerification.dart';
import 'package:sapphire/utils/constWidgets.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController _email = TextEditingController();
  bool _isEmailInvalid = false; // Tracks invalid email state

  /// Email Validation Function
  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// Handles Continue Button Click
  void _validateAndProceed() {
    navi(
        MobileOtpVerification(
            isEmail: true,
            email: "email",
            mobileOrEmail: "himanshusarode@gmail.com"),
        context);
    // if (_email.text.isEmpty ||
    //     !isValidEmail(_email.text) ||
    //     _email.text.endsWith(".com") == false) {
    //   setState(() {
    //     _isEmailInvalid = true; // Change border color to red
    //   });

    //   // Show error snackbar
    //   constWidgets.snackbar("Enter a valid email address", Colors.red, context);

    //   // Clear email field after a short delay
    //   Future.delayed(Duration(seconds: 1), () {
    //     setState(() {
    //       _isEmailInvalid = false; // Reset border color
    //     });
    //     _email.clear();
    //   });
    // } else {
    //   AuthFunctions().emailVerification(_email.text.toString());
    //   navi(
    //       MobileOtpVerification(
    //           isEmail: true,
    //           email: _email.text.toString(),
    //           mobileOrEmail: _email.text.toString()),
    //       context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/whiteLogo.png",
                    scale: 0.7,
                  ),
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome to\nSapphire",
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Get started in just a few easy steps!")),
                SizedBox(height: 40.h),

                /// Email Input Field
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._]')),
                  ],
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle:
                        TextStyle(color: Color(0xFFC9CACC), fontSize: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: _isEmailInvalid
                              ? Colors.red
                              : Colors.grey.shade700), // Turns red on error
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: _isEmailInvalid
                              ? Colors.red
                              : Colors.green, // Turns red on focus if invalid
                          width: 2.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 32.h),

                /// OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade800)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade800)),
                  ],
                ),
                SizedBox(height: 32.h),

                /// Google & Apple Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 54.h,
                        width: 54.w,
                        child: Image.asset("assets/icons/google.png")),
                    SizedBox(width: 50.w),
                    SizedBox(
                        height: 54.h,
                        width: 54.w,
                        child: Image.asset("assets/icons/apple.png"))
                  ],
                ),
                // Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Moves elements to the bottom
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 11.sp, color: Color(0xFF9B9B9B)),
                  ),
                ),
                // Prevents UI from sticking to bottom
              ],
            ),

            /// Continue Button
            // constWidgets.greenButton("Continue", onTap: _validateAndProceed),
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_email.text.isNotEmpty && !_isEmailInvalid)
                    ? _validateAndProceed
                    : null,
                child: Text(
                  "Continue",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_email.text.isNotEmpty && !_isEmailInvalid)
                      ? Color(0xFF1DB954)
                      : Color(0xff2f2f2f),
                  foregroundColor: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// Need Help Button
            constWidgets.needHelpButton(context),
          ],
        ),
      ),
    );
  }
}
