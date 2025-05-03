import 'dart:async'; // For timer functionality
import 'package:flutter/gestures.dart'; // For advanced gesture handling
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:http/http.dart'; // For network requests
import 'package:pinput/pinput.dart'; // Specialized OTP input widget
import 'package:sapphire/functions/authFunctions.dart'; // Authentication utilities
import 'package:sapphire/screens/auth/signUp/panDetails/panDetails.dart'; // Next screen in mobile verification flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:url_launcher/url_launcher.dart'; // For opening web URLs

import 'package:sapphire/main.dart'; // App-wide utilities and navigator key
import 'mobile.dart'; // Next screen in email verification flow

/// MobileOtpVerification - Screen for OTP verification of either email or mobile number
/// This screen is a dual-purpose verification screen that handles both email and mobile OTPs
/// using a shared UI with context-specific text and functionality.
class MobileOtpVerification extends StatefulWidget {
  final bool isEmail; // Flag to determine verification type (email vs mobile)
  final String email; // Email address is always required in both flows
  final String
      mobileOrEmail; // Contains either email or mobile number based on isEmail flag

  MobileOtpVerification({
    super.key,
    required this.isEmail,
    required this.email,
    required this.mobileOrEmail,
  });

  @override
  State<MobileOtpVerification> createState() => _MobileOtpVerificationState();
}

class _MobileOtpVerificationState extends State<MobileOtpVerification> {
  TextEditingController otpController = TextEditingController();
  int _timerSeconds = 59; // Initial countdown timer value (59 seconds)
  late Timer _timer; // Timer instance for countdown
  bool _isOtpIncorrect = false;

  @override
  void initState() {
    super.initState();
    startTimer(); // Begin the resend countdown timer when screen initializes
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
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

  Future<void> verifyOtp() async {
    // if (otpController.text.length != 6) {
    //   constWidgets.snackbar('Enter a valid 6-digit OTP', Colors.red, context);
    //   return;
    // }

    // bool isOtpVerified = widget.isEmail
    //     ? await AuthFunctions().emailOtpVerification(
    //         widget.mobileOrEmail, otpController.text) // Email verification
    //     : await AuthFunctions().mobileOtpVerification(
    //         widget.mobileOrEmail,
    //         otpController.text,
    //         widget.email); // Mobile verification (includes email)

    // if (isOtpVerified) {
    widget.isEmail
        ? navi(MobileOtp(email: widget.email),
            context) // Email flow -> Mobile OTP screen
        : navi(PanDetails(), context); // Mobile flow -> PAN details screen
    //   constWidgets.snackbar("OTP verified successfully", Colors.green,
    //       navigatorKey.currentContext!);
    // } else {
    //   setState(() => _isOtpIncorrect = true);
    //   constWidgets.snackbar(
    //       "Failed to verify OTP", Colors.red, navigatorKey.currentContext!);
    // }
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.isEmail ? "Email Verification" : "Mobile Verification",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                widget.isEmail
                    ? "Enter OTP sent to ${widget.mobileOrEmail.substring(0, 3)}*****@${widget.mobileOrEmail.split('@').last}"
                    : "Enter OTP sent to ******${widget.mobileOrEmail.substring(widget.mobileOrEmail.length - 4)}",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 16.h),
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6,
                controller: otpController,
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(
                      fontSize: 20.sp,
                      color: isDark ? Colors.white : Colors.black),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: _isOtpIncorrect
                            ? Colors.red
                            : isDark
                                ? Colors.white54
                                : Colors.black38),
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onCompleted: (otp) async {
                  await verifyOtp();
                },
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: _timerSeconds == 0 ? resendOtp : null,
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _timerSeconds == 0
                          ? Colors.green
                          : isDark
                              ? Color(0xffc9cacc)
                              : Colors.grey),
                ),
              ),
              SizedBox(height: 24.h),
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
                            "${(_timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(_timerSeconds % 60).toString().padLeft(2, '0')} ",
                        style: TextStyle(color: Colors.green),
                      ),
                      const TextSpan(text: "seconds"),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark ? Colors.white70 : Colors.black54),
                  children: [
                    TextSpan(
                        text: "By continuing to Verify, I agree to Sapphire "),
                    TextSpan(
                      text: "Terms & Conditions ",
                      style: TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunchUrl(Uri.parse(
                              'https://www.sapphirebroking.com/terms-and-conditions'))) {
                            await launchUrl(Uri.parse(
                                'https://www.sapphirebroking.com/terms-and-conditions'));
                          }
                        },
                    ),
                    TextSpan(text: "and "),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: TextStyle(color: Colors.green),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunchUrl(Uri.parse(
                              'https://www.sapphirebroking.com/privacy-policy'))) {
                            await launchUrl(Uri.parse(
                                'https://www.sapphirebroking.com/privacy-policy'));
                          }
                        },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  otpController.text.length == 6 ? verifyOtp() : null;
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
                      ? Color(0xFF1DB954)
                      : isDark
                          ? Color(0xff2f2f2f)
                          : Colors.grey[300],
                  foregroundColor: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  void restartTimer() {
    setState(() {
      _timerSeconds = 600; // Reset to 10 minutes (600 seconds)
      _isOtpIncorrect = false; // Clear error state
    });
    startTimer();
  }
}
