// File: aadharDetails.dart
// Description: Aadhar verification introduction screen in the Sapphire Trading application.
// This screen is part of the KYC flow and informs users about the Aadhar verification requirement.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG rendering support
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/segmentSelection.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// VerifyAadharScreen - Screen that introduces Aadhar verification step
/// Informs users about the Aadhar verification requirement and allows them to proceed
/// to the next step in the KYC (Know Your Customer) process
class VerifyAadharScreen extends StatefulWidget {
  const VerifyAadharScreen({super.key});

  @override
  State<VerifyAadharScreen> createState() => _VerifyAadharScreenState();
}

/// State class for the VerifyAadharScreen widget
/// Handles UI rendering and navigation to the next step
class _VerifyAadharScreenState extends State<VerifyAadharScreen> {
  @override
  Widget build(BuildContext context) {
    // Determine if dark mode is enabled for theming
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
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
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            // Progress indicator showing user is on step 1 of 2 in the KYC flow
            constWidgets.topProgressBar(1, 2, context),
            SizedBox(height: 24.h),
            // Main screen title
            Text(
              "Verify your Aadhar",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            // Aadhar card illustration image
            Image.asset('assets/images/aadharcard.png'),
            Spacer(), // Pushes remaining content to bottom of screen
            // Security assurance information container
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Color(0xffEDEEEF),
                borderRadius: BorderRadius.circular(6.r),
              ),
              height: 45.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Information icon
                    SvgPicture.asset(
                      "assets/images/Info.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 12.w),
                    // Security assurance text
                    Text(
                      "Your details are 100% safe with us",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Primary action button to proceed with KYC verification
            constWidgets.greenButton("Proceed for KYC", onTap: () {
              // Navigate to segment selection screen (next step in KYC flow)
              navi(SegmentSelectionScreen(), context);
            }),
            SizedBox(height: 10.h),
            // Help button for users who need assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }
}