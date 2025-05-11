import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:sapphire/utils/constWidgets.dart';

class ConfirmDeleteScreen extends StatefulWidget {
  const ConfirmDeleteScreen({super.key});

  @override
  State<ConfirmDeleteScreen> createState() => _ConfirmDeleteScreenState();
}

class _ConfirmDeleteScreenState extends State<ConfirmDeleteScreen> {
  List<String> selectedReasons = [];
  final TextEditingController _otherReasonController = TextEditingController();
  final TextEditingController _phoneOtpController = TextEditingController();

  final List<String> reasons = [
    'I find investing too complicated.',
    'The app is not helpful for my trading or investment needs.',
    'I accidentally created this accounts.',
    'I don\'t understand how to use the app.',
    'I have concerns about the safety or privacy of my information.',
    'I receive too many messages or notifications.',
    'I\'m spending too much time checking the markets.',
    'Other',
  ];

  bool _canResendOtp = false;
  int _remainingSeconds = 2;

  @override
  void initState() {
    super.initState();
    // Add listener to rebuild UI when text changes
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

  @override
  void dispose() {
    _otherReasonController.dispose();
    _phoneOtpController.dispose();
    super.dispose();
  }

  void _showForgetMPINBottomSheet(BuildContext context, bool isDark) {
    // Reset timer state and OTP field
    _canResendOtp = false;
    _remainingSeconds = 2;

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
                        controller: _phoneOtpController,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        length: 6,
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
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.black,
                                    builder: (context) {
                                      return Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xff121413)
                                              : Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 35.h),
                                            SvgPicture.asset(
                                              "assets/svgs/doneMark.svg",
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              "Account deleted successfully",
                                              style: TextStyle(
                                                fontSize: 21.sp,
                                                color: Color(0xFFEBEEF5),
                                              ),
                                            ),
                                            SizedBox(height: 24.h),
                                            Text(
                                              "Invest in stocks and track your portfolio here.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            // Bottom sheet title
                                          ],
                                        ),
                                      );
                                    },
                                  );
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Delete Account",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: Colors.white),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color(0xff2F2F2F),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let us know why you are leaving, so we can improve our app for all investors",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    // Checkbox options
                    ...reasons.map((reason) => Column(
                          children: [
                            _buildReasonOption(reason),
                            SizedBox(height: 16.h),
                          ],
                        )),
                    // Other reason text field
                    if (selectedReasons.contains('Other'))
                      Padding(
                        padding: EdgeInsets.only(left: 32.w, top: 8.h),
                        child: TextField(
                          controller: _otherReasonController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Please specify...',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: constWidgets.greenButton(
              "Continue",
              onTap: selectedReasons.isNotEmpty
                  ? () {
                      // Show OTP verification bottom sheet
                      final isDark =
                          Theme.of(context).brightness == Brightness.dark;
                      _showForgetMPINBottomSheet(context, isDark);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReasonOption(String reason) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 20.h,
          width: 20.w,
          child: Checkbox(
            value: selectedReasons.contains(reason),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedReasons.add(reason);
                } else {
                  selectedReasons.remove(reason);
                }
              });
            },
            activeColor: Colors.green,
            checkColor: Colors.white,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            reason,
            style: TextStyle(
              color: const Color(0xffEBEEF5),
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}
