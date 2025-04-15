import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/functions/authFunctions.dart';
import 'package:sapphire/screens/signUp/signUpPaymentScreen.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import 'mobileOtp.dart';

class MobileOtpVerification extends StatefulWidget {
  final bool isEmail;
  final String email; // Always required (even for mobile)
  final String
      mobileOrEmail; // Holds email (if isEmail=true) or mobile (if isEmail=false)

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
  int _timerSeconds = 600; // Set timer to 10 minutes (600 seconds)
  late Timer _timer;
  bool _isOtpIncorrect = false;
  bool isResendButtonDisabled = false; // Track resend button state

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    otpController.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    if (otpController.text.length != 6) {
      constWidgets.snackbar('Enter a valid 6-digit OTP', Colors.red, context);
      return;
    }

    bool isOtpVerified = widget.isEmail
        ? await AuthFunctions().emailOtpVerification(
            widget.mobileOrEmail, otpController.text) // Email OTP
        : await AuthFunctions().mobileOtpVerification(
            widget.mobileOrEmail,
            otpController.text,
            widget.email); // Mobile OTP now passes correct email

    if (isOtpVerified) {
      widget.isEmail
          ? navi(MobileOtp(email: widget.email), context)
          : navi(SignupPaymentScreen(), context);
      constWidgets.snackbar("OTP verified successfully", Colors.green,
          navigatorKey.currentContext!);
    } else {
      setState(() => _isOtpIncorrect = true);
      constWidgets.snackbar(
          "Failed to verify OTP", Colors.red, navigatorKey.currentContext!);
    }
  }

  // Handle Resend OTP button click
  void resendOtp() {
    if (!isResendButtonDisabled) {
      setState(() {
        isResendButtonDisabled = true;
      });
      // You can implement the API call to resend OTP here.
      // For now, we will simulate the 30-second cooldown.
      Future.delayed(const Duration(seconds: 30), () {
        setState(() {
          isResendButtonDisabled = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
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
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                widget.isEmail
                    ? "Enter OTP sent to ${widget.mobileOrEmail.substring(0, 3)}*****@${widget.mobileOrEmail.split('@').last}"
                    : "Enter OTP sent to ******${widget.mobileOrEmail.substring(widget.mobileOrEmail.length - 4)}",
                style: TextStyle(fontSize: 16.sp, color: Colors.white70),
              ),
              SizedBox(height: 16.h),

              /// OTP Input Field
              Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                length: 6,
                controller: otpController,
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.h,
                  textStyle: TextStyle(fontSize: 20.sp, color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: _isOtpIncorrect ? Colors.red : Colors.white54),
                  ),
                ),
                onCompleted: (otp) async {
                  await verifyOtp();
                },
              ),
              SizedBox(height: 16.h),

              InkWell(
                onTap: resendOtp, // Call resendOtp function
                child: Text(
                  "Resend OTP",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color:
                          isResendButtonDisabled ? Colors.grey : Colors.green),
                ),
              ),
              SizedBox(height: 24.h),

              /// Timer Display
              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    children: [
                      const TextSpan(text: "Expires in "),
                      TextSpan(
                        text:
                            "${(_timerSeconds ~/ 60).toString().padLeft(2, '0')}:${(_timerSeconds % 60).toString().padLeft(2, '0')} ",
                        style: const TextStyle(color: Colors.green),
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
            /// Terms & Conditions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(fontSize: 13.sp, color: Colors.white70),
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

            /// Verify Button
            constWidgets.greenButton("Verify", onTap: verifyOtp),
            SizedBox(height: 10.h),

            /// Need Help Button
            Center(child: constWidgets.needHelpButton(context)),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  /// Restart Timer Function
  void restartTimer() {
    setState(() {
      _timerSeconds = 600; // Restart to 10 minutes
      _isOtpIncorrect = false;
    });
    startTimer();
  }
}
