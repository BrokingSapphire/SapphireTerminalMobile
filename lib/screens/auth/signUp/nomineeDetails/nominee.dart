// File: nominee.dart
// Description: Nominee introduction screen in the Sapphire Trading application.
// This screen presents the concept of nominees to users and provides options
// to either add nominees or skip this step in the account creation process.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/auth/signUp/finalStep/eSign.dart'; // Screen for skipping nominees
import 'package:sapphire/screens/auth/signUp/nomineeDetails/nomineeDetails.dart'; // Screen for adding nominees

import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import '../signature/signatureCanvas.dart'; // Not used directly

/// nomineeScreen - Introductory screen explaining the purpose of adding nominees
/// Presents the concept and benefits of nominees before allowing users to add or skip
/// Note: Class name should be capitalized as per Dart conventions (NomineeScreen)
class nomineeScreen extends StatelessWidget {
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
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ),
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
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
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black)),
              SizedBox(height: 12.h),

              // Visual representation of nomination concept
              Center(
                child: Image.asset("assets/images/nomineescreen.png",
                    height: 250.h),
              ),
              SizedBox(height: 12.h),

              // Information card highlighting benefits of nomination
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB)),
                  color: isDark ? Color(0xFF1A1A1A) : Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card title
                    Text("Secure Your Investments: Add a Nominee Today!",
                        style: TextStyle(
                            color:
                                isDark ? Color(0xffEBEEF5) : Color(0xff1A1A1A),
                            fontSize: 12.sp)),
                    SizedBox(height: 8.h),

                    // Bullet points highlighting benefits
                    Text("✓  Easy asset transfer.",
                        style: TextStyle(
                            color:
                                isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                            fontSize: 12.sp)),
                    Text("✓  Avoids legal hassles.",
                        style: TextStyle(
                            color:
                                isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                            fontSize: 12.sp)),
                    Text("✓  Quick claim settlement.",
                        style: TextStyle(
                            color:
                                isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                            fontSize: 12.sp)),
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
                              color: isDark ? Colors.white : Colors.black,
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
