import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/account/general/changeNewPin.dart';
import 'package:sapphire/utils/constWidgets.dart';

class changePinScreen extends StatefulWidget {
  @override
  _changePinScreenState createState() => _changePinScreenState();
}

class _changePinScreenState extends State<changePinScreen> {
  bool _obscureText = true;
  TextEditingController oldmpin = TextEditingController();

  // Controllers for OTP fields
  final TextEditingController _phoneOtpController = TextEditingController();

  // Timer for OTP resend
  bool _canResendOtp = false;
  int _remainingSeconds = 2;

  @override
  void initState() {
    super.initState();
    // Add listener to rebuild UI when text changes
    oldmpin.addListener(() {
      setState(() {});
    });
  }

  // Start timer for OTP resend
  void _startResendTimer(StateSetter setModalState) {
    _canResendOtp = false;
    _remainingSeconds = 2;

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setModalState(() {
          _remainingSeconds--;
        });
      } else {
        setModalState(() {
          _canResendOtp = true;
        });
        timer.cancel();
      }
    });
  }

  // Method to show the forget MPIN bottom sheet with OTP fields
  void _showForgetMPINBottomSheet(BuildContext context, bool isDark) {
    // Reset timer state and OTP field
    _canResendOtp = false;
    _remainingSeconds = 2;
    _phoneOtpController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xff121413),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          // Start the timer when the modal is first shown
          if (_remainingSeconds == 2) {
            _startResendTimer(setModalState);
          }

          // Add listener to OTP controller to update UI when typing
          _phoneOtpController.addListener(() {
            setModalState(() {});
          });

          return Padding(
            // Add padding to account for keyboard
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // Use constraints instead of fixed height to allow content to adjust with keyboard
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                minHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                color: Color(0xff121413),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Verify OTP',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),

                      // Info text
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xFF1E1E1E) : Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18.sp,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'OTP has been sent to your registered phone number',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color:
                                      isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Phone OTP section
                      Text(
                        'Enter 6-digit OTP',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        length: 6,
                        controller: _phoneOtpController,
                        defaultPinTheme: PinTheme(
                          width: 48.w,
                          height: 48.h,
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isDark
                                  ? Color(0xff2F2F2F)
                                  : Color(0xffD1D5DB),
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 40.w,
                          height: 40.h,
                          textStyle: TextStyle(
                            fontSize: 15.sp,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF1DB954),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Resend OTP with timer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t receive OTP? ',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          _canResendOtp
                              ? InkWell(
                                  onTap: () {
                                    // Resend OTP logic
                                    constWidgets.snackbar(
                                        "OTP resent successfully",
                                        Colors.green,
                                        context);
                                    // Restart timer
                                    _startResendTimer(setModalState);
                                  },
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      color: Color(0xFF1DB954),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Resend in ${_remainingSeconds}s',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.sp,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      // Verify button
                      Container(
                        height: 48.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _phoneOtpController.text.length == 6
                              ? () {
                                  // Close bottom sheet and navigate to change new PIN screen
                                  Navigator.pop(context);
                                  navi(changeNewPinScreen(), context);
                                }
                              : null,
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _phoneOtpController.text.length == 6
                                    ? Color(0xFF1DB954)
                                    : Color(0xff2f2f2f),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0,
        // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(left: 0, top: 15.w),
          child: Text(
            "Change PIN",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leadingWidth: 32.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 0, top: 15.w),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
            Expanded(
              // ✅ Fix: Make column scrollable/flexible
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Enter Old MPIN',
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: oldmpin,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        obscureText: _obscureText,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isDark
                                  ? Color(0xffC9CACC)
                                  : Color(0xffD1D5DB),
                              size: 22.sp,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white54
                                    : Color(0xffD1D5DB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                                color:
                                    isDark ? Colors.white : Color(0xffD1D5DB),
                                width: 2.w),
                          ),
                          hintText: 'Enter MPIN',
                          hintStyle: TextStyle(
                              color: isDark
                                  ? Color(0xFFC9CACC)
                                  : Color(0xff6B7280),
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _showForgetMPINBottomSheet(context, isDark);
                        },
                        child: Text('Forget MPIN?',
                            style: TextStyle(
                                color:
                                    isDark ? Color(0xFFEBEEF5) : Colors.black,
                                fontSize: 15.sp,
                                decoration: TextDecoration.underline)),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 52.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        // Button is enabled only when MPIN field has exactly 4 digits
                        onPressed: oldmpin.text.length == 4
                            ? () {
                                navi(changeNewPinScreen(), context);
                              }
                            : null,
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w600),
                        ),
                        // Button color changes based on enabled state
                        style: ElevatedButton.styleFrom(
                          backgroundColor: oldmpin.text.length == 4
                              ? Color(0xFF1DB954)
                              : Color(0xff2f2f2f),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
