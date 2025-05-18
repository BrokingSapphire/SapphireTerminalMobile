// File: loginOtp.dart
// Description: OTP verification screen for login flow in Sapphire Trading application.
// This screen handles verification of both email and mobile numbers during login.

import 'dart:async'; // For timer functionality
import 'package:flutter/gestures.dart'; // For advanced gesture handling
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:pinput/pinput.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/auth/signUp/contactDetails/email.dart';
import 'package:sapphire/screens/home/riskDisclosure.dart';
import 'package:sapphire/utils/constWidgets.dart'; // Specialized OTP input widget

/// loginOtp - Screen for OTP verification during login
/// This screen handles verification of OTP sent to user's registered email and mobile
class loginOtp extends StatefulWidget {
  loginOtp({
    super.key,
  });

  @override
  State<loginOtp> createState() => _loginOtpState();
}

/// State class for the loginOtp widget
/// Manages OTP input, verification, countdown timer, and UI states
class _loginOtpState extends State<loginOtp> {
  TextEditingController otpController =
      TextEditingController(); // Controls OTP input
  int _timerSeconds = 59; // Initial countdown timer value (59 seconds)
  late Timer _timer; // Timer instance for countdown
  bool _isOtpIncorrect = false; // Tracks if entered OTP is invalid

  @override
  void initState() {
    super.initState();
    startTimer(); // Begin the resend countdown timer when screen initializes
  }

  /// Starts the countdown timer for OTP resend functionality
  /// Updates UI every second and stops when countdown reaches zero
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--; // Decrement timer every second
        });
      } else {
        _timer.cancel(); // Stop timer when countdown reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel timer to prevent memory leaks
    otpController.dispose(); // Clean up text controller
    super.dispose();
  }

  /// Handles OTP verification process for login
  /// Validates OTP and navigates to dashboard on success
  /// Handles OTP verification for login
  /// Validates the OTP and navigates to the dashboard if successful
  /// If verification fails, displays an error message
  /// Note: Actual API verification is not yet implemented
  Future<void> verifyOtp() async {
    // TODO: Implement actual API verification
    // Example implementation:
    // if (otpController.text.length != 6) {
    //   constWidgets.snackbar('Enter a valid 6-digit OTP', Colors.red, context);
    //   return;
    // }
    // bool isOtpVerified = await AuthFunctions().loginOtp(otpController.text);
    // if (isOtpVerified) {
    //   constWidgets.snackbar("Login successful", Colors.green, context);
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => Dashboard()),
    //     (route) => false,
    //   );
    // } else {
    //   setState(() => _isOtpIncorrect = true);
    //   constWidgets.snackbar("Invalid OTP", Colors.red, context);
    // }

    // Temporary simplified implementation - bypasses API verification
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => Dashboard()),
    //   (route) => false,
    // );
  }

  /// Handles the resend OTP functionality
  /// Only active when timer reaches zero
  /// Resets timer and clears error state when invoked
  void resendOtp() {
    if (_timerSeconds == 0) {
      // TODO: Implement actual resend OTP API call
      setState(() {
        _timerSeconds = 59; // Reset to 59 seconds
        _isOtpIncorrect = false; // Clear error state
      });
      startTimer(); // Restart countdown
    }
  }

  @override
  Widget build(BuildContext context) {
    // Always use dark theme for this screen as shown in the image
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarHeight: 45.h,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 28.sp,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(height: 10.h),
            // Welcome header
            Spacer(),
            Text(
              "Welcome to\nSapphire",
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 34.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            // Instruction text for OTP
            Text(
              "Enter OTP sent to registered Email and Mobile Number",
              style: TextStyle(
                fontSize: 17.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40.h),
            // OTP input field with 6 separate boxes
            Pinput(
              length: 6, // 6-digit OTP
              controller: otpController,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              defaultPinTheme: PinTheme(
                width: 48.w,
                height: 48.h,
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _isOtpIncorrect
                        ? Colors.red // Red border when OTP is incorrect
                        : Color(0xff2f2f2f), // Normal border
                    width: 1,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Update UI on OTP input change
              },
              onCompleted: (otp) async {
                // Auto-verify when all 6 digits entered
                await verifyOtp();
              },
            ),
            SizedBox(height: 20.h),
            // Resend OTP and timer row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Resend OTP button - only active when timer reaches zero
                TextButton(
                  onPressed: _timerSeconds == 0 ? resendOtp : null,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(80, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                ),
                // Countdown timer display
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(text: "Expires in "),
                      TextSpan(
                        text: "0:${_timerSeconds.toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.green),
                      ),
                      TextSpan(text: " seconds"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 70.h), // Push continue button to bottom

            constWidgets.greenButton(
              "Continue",
              onTap: () {
                naviRep(Disclosure(), context);
              },
              isDisabled: otpController.text.length != 6,
            ),
            SizedBox(height: 24.h),
            // Sign up option
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Dont have an account? ",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark
                        ? const Color(0xFFC9CACC)
                        : const Color(0xFF6B7280),
                  ),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        decorationColor: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the Sign Up screen
                          naviRep(const EmailScreen(), context);
                        },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            // Disclaimer text
            Text(
              "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            // Need Help button
            Center(
              child: TextButton(
                onPressed: () {
                  // TODO: Implement help functionality
                },
                child: Text(
                  "Need Help?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
