import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/auth/login/troubleLoggingIn/changePassword.dart';
import 'package:sapphire/utils/constWidgets.dart';

class otpVerification extends StatefulWidget {
  const otpVerification({super.key});

  @override
  State<otpVerification> createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
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

  Future<void> verifyOtp() async {
    navi(changePassword(), context);
    ;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                size: 28.sp, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Dismiss keyboard when tapping outside
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamic screen title based on verification type
              Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              // Dynamic instruction text with partially masked contact info
              Text(
                "Enter OTP sent on Registered Email and Mobile Number", // Masked phone number
                style: TextStyle(
                    fontSize: 15.sp,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 24.h),
              // OTP input field with 6 separate boxes
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6, // 6-digit OTP
                controller: otpController,
                defaultPinTheme: PinTheme(
                  width: 48.w,
                  height: 48.h,
                  textStyle: TextStyle(
                      fontSize: 20.sp,
                      color: isDark ? Colors.white : Colors.black),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: _isOtpIncorrect
                            ? Colors.red // Red border when OTP is incorrect
                            : isDark
                                ? Color(
                                    0xff2f2f2f) // Normal border in dark mode
                                : Colors
                                    .black38), // Normal border in light mode
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Update UI on OTP input change
                },
                onCompleted: (otp) async {
                  await verifyOtp(); // Auto-verify when all 6 digits entered
                },
              ),
              SizedBox(height: 24.h),
              // Resend OTP button - only active when timer reaches zero
              InkWell(
                onTap: _timerSeconds == 0 ? resendOtp : null,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _timerSeconds == 0
                          ? Colors.green // Active color when timer is zero
                          : isDark
                              ? Color(0xffc9cacc) // Inactive color in dark mode
                              : Colors.grey), // Inactive color in light mode
                ),
              ),
              SizedBox(height: 42.h),
              // Countdown timer display
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: isDark ? Colors.white : Colors.black),
                    children: [
                      const TextSpan(text: "Resend in "),
                      TextSpan(
                        text:
                            "${(_timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(_timerSeconds % 60).toString().padLeft(2, '0')} ", // MM:SS format
                        style: TextStyle(color: Colors.green),
                      ),
                      const TextSpan(text: "seconds"),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()), // Pushes content to top
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Terms and conditions acceptance text with clickable links

            // Verify button - conditionally styled based on OTP completion
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  otpController.text.length == 6
                      ? verifyOtp()
                      : null; // Only verify if OTP is complete
                },
                child: Text(
                  "Verify",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: otpController.text.length == 6
                      ? Color(0xFF1DB954) // Green when OTP is complete
                      : isDark
                          ? Color(
                              0xff2f2f2f) // Dark gray in dark mode when incomplete
                          : Colors.grey[
                              300], // Light gray in light mode when incomplete
                  foregroundColor: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            // Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
