// File: inPersonVerification.dart
// Description: In-Person Verification (IPV) screen in the Sapphire Trading application.
// This screen introduces users to the IPV process where they need to take a selfie
// for identity verification as required by SEBI regulations.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG rendering support
import 'package:sapphire/screens/auth/signUp/inPersonVerification/selfieCamera.dart'; // Next screen for taking selfie
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/segmentSelection.dart'; // Not used directly

import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// ipvScreen - Introduction screen for In-Person Verification process
/// Explains the IPV requirement and prepares users for selfie verification
/// Note: Class name should be capitalized as per Dart conventions (IpvScreen)
class ipvScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
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
            // Progress indicator showing current step in registration flow (step 1 of 6)
            constWidgets.topProgressBar(1, 6, context),
            SizedBox(
              height: 24.h,
            ),
            // Screen title - explains the purpose of this verification step
            Text("In-Person Verification (IPV)",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black)),
            SizedBox(height: 12.h),

            // Visual representation of IPV process (illustration)
            Center(
                child:
                    Image.asset("assets/images/ipvscreen.png", height: 200.h)),

            // Push content to top and instructions/button to bottom
            Spacer(),

            // Instruction container with important selfie guidelines
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Color(0xffEDEEEF),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Information icon
                    SvgPicture.asset(
                      "assets/images/Info.svg",
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    // Instruction text
                    Flexible(
                      child: Text(
                        "Please take a photo where your face is clearly visible",
                        textAlign: TextAlign.left,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Continue button - navigates to selfie capture screen
            constWidgets.greenButton("Continue", onTap: () {
              navi(SelfieVerificationScreen(), context);
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
