// File: mobileOTPVerification.dart
// Description: Dual-purpose OTP verification screen for Sapphire Trading application.
// This screen handles verification of both email and mobile numbers using the same UI but different logic paths.

import 'dart:async'; // For timer functionality
import 'package:flutter/gestures.dart'; // For advanced gesture handling
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:pinput/pinput.dart'; // Specialized OTP input widget
import 'package:sapphire/functions/auth/index.dart';
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

/// State class for the MobileOtpVerification widget
/// Manages OTP input, verification, countdown timer, and UI states
class _MobileOtpVerificationState extends State<MobileOtpVerification> {
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

  /// Handles OTP verification process for both email and mobile paths
  /// Validates OTP and navigates to appropriate next screen on success
  /// Note: API verification is currently commented out in favor of direct navigation
  Future<void> verifyOtp() async {
    // Original API verification implementation (currently disabled)
    if (otpController.text.length != 6) {
      constWidgets.snackbar('Enter a valid 6-digit OTP', Colors.red, context);
      return;
    }

    bool isOtpVerified = widget.isEmail
        ? await AuthFunctions().emailOtpVerification(
            widget.mobileOrEmail, otpController.text) // Email verification
        : await AuthFunctions().mobileOtpVerification(
            widget.mobileOrEmail,
            otpController.text,
            widget.email); // Mobile verification (includes email)

    if (isOtpVerified) {
      // Temporary simplified implementation - bypasses API verification
      // TODO: Restore original implementation with proper API verification when ready
      widget.isEmail
          ? navi(MobileOtp(email: widget.email),
              context) // Email flow -> Mobile OTP screen
          : navi(PanDetails(), context); // Mobile flow -> PAN details screen
    } else {
      setState(() => _isOtpIncorrect = true);
      // constWidgets.snackbar(
      //     "Failed to verify OTP", Colors.red, navigatorKey.currentContext!);
    }
  }

  /// Handles the resend OTP functionality
  /// Only active when timer reaches zero
  /// Resets timer and clears error state when invoked
  void resendOtp() {
    if (_timerSeconds == 0) {
      // TODO: Implement actual resend OTP API call
      AuthFunctions()
          .mobileVerification(widget.mobileOrEmail, widget.email, context);
      setState(() {
        _timerSeconds = 59; // Reset to 59 seconds
        _isOtpIncorrect = false; // Clear error state
      });
      startTimer(); // Restart countdown
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if dark mode is enabled for theming
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      // Main body with gesture detection to dismiss keyboard on tap outside
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
                widget.isEmail ? "Email Verification" : "Mobile Verification",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 24.h),
              // Dynamic instruction text with partially masked contact info
              Text(
                widget.isEmail
                    ? "Enter OTP sent to ${widget.mobileOrEmail.substring(0, 3)}*****@${widget.mobileOrEmail.split('@').last}" // Masked email
                    : "Enter OTP sent to ******${widget.mobileOrEmail.substring(widget.mobileOrEmail.length - 4)}", // Masked phone number
                style: TextStyle(
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 16.h),
              // OTP input field with 6 separate boxes
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6, // 6-digit OTP
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
                            ? Colors.red // Red border when OTP is incorrect
                            : isDark
                                ? Colors.white54 // Normal border in dark mode
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
              SizedBox(height: 16.h),
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
              SizedBox(height: 24.h),
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
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? Colors.white70 : Colors.black54),
                    children: [
                      TextSpan(
                          text:
                              "By continuing to Verify, I agree to Sapphire "),
                      // Clickable Terms & Conditions link
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
                      // Clickable Privacy Policy link
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
              const Expanded(child: SizedBox()), // Pushes content to top
              constWidgets.greenButton(
                "Verify",
                onTap: () {
                  if (otpController.text.length == 6) {
                    verifyOtp();
                  }
                },
                isDisabled: otpController.text.length != 6,
              ),
            ],
          ),
        ),
      ),
      // Bottom area with terms acceptance text and verify button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Terms and conditions acceptance text with clickable links

            // Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Resets timer to 10 minutes
  /// Used for extended verification time if needed
  /// Currently not used in main flow but available for future implementation
  void restartTimer() {
    setState(() {
      _timerSeconds = 600; // Reset to 10 minutes (600 seconds)
      _isOtpIncorrect = false; // Clear error state
    });
    startTimer();
  }
}
