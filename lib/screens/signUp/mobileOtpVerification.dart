// File: mobileOtpVerification.dart
// Description: OTP verification screen that handles both email and mobile verification.
// This screen is part of the user registration flow, validating a user's contact information.

import 'dart:async'; // For timer functionality
import 'package:flutter/gestures.dart'; // For advanced gesture handling
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:http/http.dart'; // For network requests
import 'package:pinput/pinput.dart'; // Specialized OTP input widget
import 'package:sapphire/functions/authFunctions.dart'; // Authentication utilities
import 'package:sapphire/screens/signUp/panDetails.dart'; // Next screen in mobile verification flow
import 'package:sapphire/screens/signUp/signUpPaymentScreen.dart'; // Payment screen (not used in this flow)
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:url_launcher/url_launcher.dart'; // For opening web URLs

import '../../main.dart'; // App-wide utilities and navigator key
import 'mobileOtp.dart'; // Next screen in email verification flow

/// MobileOtpVerification - Screen for OTP verification of either email or mobile number
/// This screen is a dual-purpose verification screen that handles both email and mobile OTPs
/// using a shared UI with context-specific text and functionality.
class MobileOtpVerification extends StatefulWidget {
  // Parameters to determine which verification mode to use
  final bool isEmail; // Flag to determine verification type (email vs mobile)
  final String email; // Email address is always required in both flows
  final String mobileOrEmail; // Contains either email or mobile number based on isEmail flag

  /// Constructor requiring verification type and contact information
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
/// Manages OTP input, timer functionality, and verification process
class _MobileOtpVerificationState extends State<MobileOtpVerification> {
  // Controller for the OTP input field
  TextEditingController otpController = TextEditingController();

  // Timer state variables
  int _timerSeconds = 59; // Initial countdown timer value (59 seconds)
  late Timer _timer; // Timer instance for countdown

  // Flag to track incorrect OTP attempts
  bool _isOtpIncorrect = false;

  @override
  void initState() {
    super.initState();
    startTimer(); // Begin the resend countdown timer when screen initializes
  }

  /// Starts the countdown timer for OTP resend functionality
  /// Decrements _timerSeconds every second until it reaches zero
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
    // Clean up resources when screen is removed
    _timer.cancel(); // Cancel timer to prevent memory leaks
    otpController.dispose(); // Clean up text controller
    super.dispose();
  }

  /// Verifies the user-entered OTP against the server
  /// Handles both email and mobile verification paths based on widget.isEmail
  /// Routes to appropriate next screen upon successful verification
  Future<void> verifyOtp() async {
    // Validate OTP length
    if (otpController.text.length != 6) {
      constWidgets.snackbar('Enter a valid 6-digit OTP', Colors.red, context);
      return;
    }

    // Call the appropriate verification method based on verification type
    bool isOtpVerified = widget.isEmail
        ? await AuthFunctions().emailOtpVerification(
        widget.mobileOrEmail, otpController.text) // Email verification
        : await AuthFunctions().mobileOtpVerification(
        widget.mobileOrEmail,
        otpController.text,
        widget.email); // Mobile verification (includes email)

    // Handle verification result
    if (isOtpVerified) {
      // Navigate to next screen based on verification type
      widget.isEmail
          ? navi(MobileOtp(email: widget.email), context) // Email flow -> Mobile OTP screen
          : navi(PanDetails(), context); // Mobile flow -> PAN details screen

      // Show success message
      constWidgets.snackbar("OTP verified successfully", Colors.green,
          navigatorKey.currentContext!);
    } else {
      // Mark OTP as incorrect for UI feedback
      setState(() => _isOtpIncorrect = true);

      // Show error message
      constWidgets.snackbar(
          "Failed to verify OTP", Colors.red, navigatorKey.currentContext!);
    }
  }

  /// Handles the resend OTP functionality
  /// Only active when the timer reaches zero
  /// Resets the timer and clears error states
  void resendOtp() {
    if (_timerSeconds == 0) {
      // TODO: Implement actual resend OTP API call

      // Reset timer and error state
      setState(() {
        _timerSeconds = 59; // Reset to 59 seconds
        _isOtpIncorrect = false; // Clear error state
      });
      startTimer(); // Restart countdown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Simple app bar with back button
      backgroundColor: Colors.black,
      body: GestureDetector(
        // Dismiss keyboard when tapping outside input field
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen title - changes based on verification type
              Text(
                widget.isEmail ? "Email Verification" : "Mobile Verification",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.h),

              // Instruction text with masked contact information for privacy
              Text(
                widget.isEmail
                    ? "Enter OTP sent to ${widget.mobileOrEmail.substring(0, 3)}*****@${widget.mobileOrEmail.split('@').last}"
                    : "Enter OTP sent to ******${widget.mobileOrEmail.substring(widget.mobileOrEmail.length - 4)}",
                style: TextStyle(fontSize: 16.sp, color: Colors.white70),
              ),
              SizedBox(height: 16.h),

              /// OTP input field using Pinput widget
              /// Specialized input for code entry with individual boxes
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6, // 6-digit OTP
                controller: otpController,
                // Style for individual PIN cells
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(fontSize: 20.sp, color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    // Border color changes to red if incorrect OTP is entered
                    border: Border.all(
                        color: _isOtpIncorrect ? Colors.red : Colors.white54),
                  ),
                ),
                onChanged: (value) {
                  // Trigger rebuild to update button state based on input length
                  setState(() {});
                },
                // Auto-verify when all digits are entered
                onCompleted: (otp) async {
                  await verifyOtp();
                },
              ),
              SizedBox(height: 16.h),

              /// Resend OTP button
              /// Only active when timer reaches zero
              InkWell(
                onTap: _timerSeconds == 0
                    ? resendOtp
                    : null, // Only enable when timer is zero
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      // Color changes to green when active
                      color: _timerSeconds == 0
                          ? Colors.green
                          : Color(0xffc9cacc)),
                ),
              ),
              SizedBox(height: 24.h),

              /// Countdown timer display
              /// Shows remaining time until resend option is available
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    children: [
                      const TextSpan(text: "Resend in "),
                      TextSpan(
                        // Format timer as MM:SS
                        text:
                        "${(_timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(_timerSeconds % 60).toString().padLeft(2, '0')} ",
                        style: TextStyle(color: Colors.green),
                      ),
                      const TextSpan(text: "seconds"),
                    ],
                  ),
                ),
              ),
              // Push content to top by expanding empty space
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),

      /// Bottom section with terms and verification button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Terms & Conditions disclaimer with clickable links
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                  children: [
                    TextSpan(
                        text: "By continuing to Verify, I agree to Sapphire "),
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
            SizedBox(height: 30.h),

            /// Verify Button - conditionally enabled based on OTP length
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // Verify OTP only if 6 digits are entered
                onPressed: () {
                  otpController.text.length == 6 ? verifyOtp() : null;
                },
                child: Text(
                  "Verify",
                  style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                // Button style changes based on OTP completion
                style: ElevatedButton.styleFrom(
                  backgroundColor: otpController.text.length == 6
                      ? Color(0xFF1DB954) // Green when OTP complete
                      : Color(0xff2f2f2f), // Dark gray when incomplete
                  foregroundColor: Colors.white,
                ),
                // Alternative button implementation (commented out)
                // child: Text("Verify",
                //     style: TextStyle(
                //         fontSize: 17.sp, fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 10.h),

            /// Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  /// Restarts the timer with a longer duration
  /// Used for manual reset or after certain actions
  /// NOTE: This function is defined but not currently used in the UI
  void restartTimer() {
    setState(() {
      _timerSeconds = 600; // Reset to 10 minutes (600 seconds)
      _isOtpIncorrect = false; // Clear error state
    });
    startTimer(); // Start the countdown
  }
}