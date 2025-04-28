// File: nomineeScreen.dart
// Description: Nominee introduction screen in the Sapphire Trading application.
// This screen presents the concept of nominees to users and provides options
// to either add nominees or skip this step in the account creation process.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/signUp/eSignScreen.dart'; // Screen for skipping nominees
import 'package:sapphire/screens/signUp/nomineeDetailsScreen.dart'; // Screen for adding nominees

import '../../main.dart'; // App-wide navigation utilities
import '../../utils/constWidgets.dart'; // Reusable UI components
import 'signCanvaScreen.dart'; // Not used directly

/// nomineeScreen - Introductory screen explaining the purpose of adding nominees
/// Presents the concept and benefits of nominees before allowing users to add or skip
/// Note: Class name should be capitalized as per Dart conventions (NomineeScreen)
class nomineeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ),
      ),
      body: GestureDetector(
        // Dismiss keyboard when tapping outside input fields
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              // Progress indicator showing current step (1 of 8)
              constWidgets.topProgressBar(1, 8, context),
              SizedBox(
                height: 24.h,
              ),
              // Screen title explaining the purpose
              Text("Add Nominees for your investment",
                  style:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),

              // Visual representation of nomination concept
              Image.asset("assets/images/nomineescreen.png", height: 250.h),
              SizedBox(height: 12.h),

              // Information card highlighting benefits of nomination
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xff2f2f2f)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card title
                    Text("Secure Your Investments: Add a Nominee Today!",
                        style: TextStyle(
                            color: Color(0xffEBEEF5), fontSize: 12.sp)),
                    SizedBox(height: 8.h),

                    // Bullet points highlighting benefits
                    Text("✓  Easy asset transfer.",
                        style: TextStyle(
                            color: Color(0xffC9CACC), fontSize: 12.sp)),
                    Text("✓  Avoids legal hassles.",
                        style: TextStyle(
                            color: Color(0xffC9CACC), fontSize: 12.sp)),
                    Text("✓  Quick claim settlement.",
                        style: TextStyle(
                            color: Color(0xffC9CACC), fontSize: 12.sp)),
                  ],
                ),
              ),

              // Push buttons to bottom of screen
              Spacer(),

              // Primary action button - proceed to add nominees
              constWidgets.greenButton("Add Nominee", onTap: () {
                navi(NomineeDetailsScreen(), context);
              }),
              SizedBox(height: 10.h),

              // Secondary action button - skip nominee addition
              Center(
                  child: TextButton(
                      onPressed: () {
                        navi(eSignScreen(), context);
                      },
                      child: Text("I don't want to add nominees",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600)))),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}