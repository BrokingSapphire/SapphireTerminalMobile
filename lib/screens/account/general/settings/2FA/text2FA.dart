import 'dart:async'; // Import Timer package
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class otp2faScreen extends StatefulWidget {
  const otp2faScreen({super.key});

  @override
  State<otp2faScreen> createState() => _otp2faScreenState();
}

class _otp2faScreenState extends State<otp2faScreen> {
  TextEditingController otpController = TextEditingController();
  int _timerSeconds = 60;
  late Timer _timer;
  bool isOtpValid = false;
  bool _isGray = true;

  @override
  void initState() {
    super.initState();
    startTimer();

    // Add listener to OTP controller to check validity
    otpController.addListener(() {
      setState(() {
        // Check if OTP has the correct format (e.g., "1234-5678")
        isOtpValid =
            otpController.text.length >= 8 && otpController.text.contains('-');
        _isGray = !isOtpValid; // Enable the button only when OTP is valid
      });
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void restartTimer() {
    setState(() {
      _timerSeconds = 60;
    });
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:
            true, // Ensures that the UI adjusts with the keyboard
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          leadingWidth: 32.w,
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Two Factor Authentication",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.sp,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.black,
                )),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.translucent,
          child: SingleChildScrollView(
            // Wrap the body with SingleChildScrollView
            child: Column(children: [
              Divider(
                color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 28.h),
                    Text("Enter OTP sent to ******4512",
                        style: TextStyle(
                            color: isDark ? Color(0xFFEBEEF5) : Colors.black,
                            fontSize: 16.sp)),
                    SizedBox(height: 18.h),
                    TextField(
                      controller: otpController,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          String text = newValue.text.replaceAll('-', '');
                          if (text.length > 4) {
                            text =
                                text.substring(0, 4) + '-' + text.substring(4);
                          }
                          return TextEditingValue(
                            text: text,
                            selection:
                                TextSelection.collapsed(offset: text.length),
                          );
                        }),
                      ],
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 18.h),
                        hintText: "3456-7896",
                        hintStyle: TextStyle(
                            color:
                                isDark ? Color(0xffc9cacc) : Color(0xff6B7280)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(35.r), // Rounded border
                          borderSide: BorderSide(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Color(0xff6B7280),
                              width: 1.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.r),
                          borderSide: BorderSide(
                              color: isDark ? Colors.white : Color(0xffD1D5DB),
                              width: 2.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: _timerSeconds == 0 ? restartTimer : null,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                          color:
                              _timerSeconds == 0 ? Colors.green : Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: isDark
                                  ? Colors.white
                                  : Colors.black), // Default white color
                          children: [
                            TextSpan(text: "Expires in  "),
                            TextSpan(
                              text:
                                  "0:${_timerSeconds.toString().padLeft(2, '0')} ",
                              // Green seconds
                              style: TextStyle(color: Colors.green),
                            ),
                            TextSpan(text: " seconds"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 440.h),
                    SizedBox(
                      height: 52.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isGray
                            ? null
                            : () {
                                // Handle OTP verification or continue action
                                print('OTP Verified');
                              },
                        child: Text("Continue",
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                color: _isGray
                                    ? Color(0xffc9cacc)
                                    : Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isGray ? Color(0xff2f2f2f) : Color(0xFF1DB954),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Color(0xff2f2f2f),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
        // bottomSheet: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 15.w),
        //   child: SizedBox(
        //     height: 52.h,
        //     width: double.infinity,
        //     child: ElevatedButton(
        //       onPressed: _isGray
        //           ? null
        //           : () {
        //               // Handle OTP verification or continue action
        //               print('OTP Verified');
        //             },
        //       child: Text("Continue",
        //           style: TextStyle(
        //               fontSize: 17.sp,
        //               fontWeight: FontWeight.w600,
        //               color: isDark ? Colors.black : Colors.white)),
        //       style: ElevatedButton.styleFrom(
        //         backgroundColor:
        //             _isGray ? Color(0xff2f2f2f) : Color(0xFF1DB954),
        //         foregroundColor: Colors.white,
        //         disabledBackgroundColor: Color(0xff2f2f2f),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
