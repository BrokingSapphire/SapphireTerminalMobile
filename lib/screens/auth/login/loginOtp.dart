// File: loginOtp.dart
// Description: OTP verification screen for login flow in Sapphire Trading application.
// This screen handles verification of OTP sent to user's registered email and mobile.

import 'dart:async'; // For timer functionality
import 'package:flutter/gestures.dart'; // For advanced gesture handling
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:pinput/pinput.dart'; // Specialized OTP input widget
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/auth/login/useMpinScreen.dart'; // MPIN screen destination
import 'package:sapphire/screens/auth/signUp/contactDetails/email.dart'; // Sign-up screen
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// loginOtp - Screen for OTP verification during login
/// This screen handles verification of OTP sent to user's registered email and mobile
class loginOtp extends StatefulWidget {
  const loginOtp({super.key});

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

  /// Handles OTP verification process for login
  /// Validates OTP length and navigates to MPIN screen
  Future<void> verifyOtp() async {
    if (otpController.text.length != 6) {
      setState(() => _isOtpIncorrect = true);
      constWidgets.snackbar('Please enter a 6-digit OTP', Colors.red, context);
      return;
    }
    // Temporary navigation to MPIN screen (no backend verification)
    naviRep(const UseMpinScreen(), context);
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
  void dispose() {
    _timer.cancel(); // Cancel timer to prevent memory leaks
    otpController.dispose(); // Clean up text controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        toolbarHeight: 45.h,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            iconSize: 28.sp,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Welcome header
            Text(
              "Welcome to\nSapphire",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            // Instruction text for OTP
            Text(
              "Enter OTP sent to registered Email and Mobile Number",
              style: TextStyle(
                fontSize: 17.sp,
                color: isDark ? Colors.white70 : Colors.black54,
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
                  color: isDark ? Colors.white : Colors.black,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color:
                        _isOtpIncorrect ? Colors.red : const Color(0xff2f2f2f),
                    width: 1,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _isOtpIncorrect = false; // Clear error on input change
                });
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
                // Resend OTP button - faded and disabled until timer reaches zero
                TextButton(
                  onPressed: _timerSeconds == 0 ? resendOtp : null,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(80, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Resend OTP",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: _timerSeconds == 0 ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
                // Countdown timer display
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    children: [
                      const TextSpan(text: "Expires in "),
                      TextSpan(
                        text: "0:${_timerSeconds.toString().padLeft(2, '0')}",
                        style: const TextStyle(color: Colors.green),
                      ),
                      const TextSpan(text: " seconds"),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 70.h),
            // Continue button
            constWidgets.greenButton(
              "Continue",
              onTap: () {
                verifyOtp();
              },
              isDisabled: otpController.text.length != 6,
            ),
            SizedBox(height: 24.h),
            // Sign up option
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
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
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          naviRep(const EmailScreen(), context);
                        },
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
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
                    color: isDark ? Colors.white : Colors.black,
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
