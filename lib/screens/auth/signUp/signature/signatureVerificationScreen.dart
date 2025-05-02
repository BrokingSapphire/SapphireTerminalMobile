// File: signatureVerificationScreen.dart
// Description: Signature verification introduction screen in the Sapphire Trading application.
// This screen explains the digital signature process to users before they proceed
// to the actual signature capture screen.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/signUp/signCanvaScreen.dart'; // Next screen for signature capture

import '../../../utils/constWidgets.dart'; // Reusable UI components

/// signVerificationScreen - Introduction screen for digital signature process
/// Explains the importance and benefits of digital signatures before proceeding to capture
/// Note: Class name should be capitalized as per Dart conventions (SignVerificationScreen)
class signVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            // Progress indicator showing current step (1 of 7)
            constWidgets.topProgressBar(1, 7, context),
            SizedBox(
              height: 24.h,
            ),
            // Screen title
            Text("Signature",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black)),
            SizedBox(height: 12.h),

            // Visual representation of signature process
            Center(
                child: Image.asset(
                    "assets/images/signatureverificationpage.png",
                    height: 250.h)),
            SizedBox(height: 12.h),

            // Information card highlighting benefits of digital signatures
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                    color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card title
                  Text("Seal the Deal with a Secure Digital Sign!",
                      style: TextStyle(
                          color: isDark ? Color(0xffEBEEF5) : Color(0xff1A1A1A),
                          fontSize: 12.sp)),
                  SizedBox(height: 8.h),

                  // Bullet points highlighting benefits
                  Text("✓  Legally Compliant & Secure.",
                      style: TextStyle(
                          color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                          fontSize: 12.sp)),
                  Text("✓  Fast & Convenient.",
                      style: TextStyle(
                          color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                          fontSize: 12.sp)),
                  Text("✓  Binding & Recognized.",
                      style: TextStyle(
                          color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                          fontSize: 12.sp)),
                ],
              ),
            ),

            // Push content to top and buttons to bottom
            Spacer(),

            // Continue button - navigates to signature canvas screen
            constWidgets.greenButton("Continue", onTap: () {
              navi(SignCanvasScreen(), context);
            }),
            SizedBox(height: 10.h),

            // Help button for user assistance
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }
}
