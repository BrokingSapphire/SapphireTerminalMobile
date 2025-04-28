// File: verifyAadharScreen.dart
// Description: Aadhar card verification screen in the Sapphire Trading application.
// This screen is part of the KYC process, prompting users to proceed with Aadhar verification,
// which is a mandatory identity document in India for financial services.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG rendering support
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/signUp/segmentSelectionScreen.dart'; // Next screen in registration flow

import '../../utils/constWidgets.dart'; // Reusable UI components

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            // Progress indicator showing current step in registration flow (step 1 of 2)
            constWidgets.topProgressBar(1, 2, context),
            SizedBox(
              height: 24.h,
            ),
            // Screen title
            Text(
              "Verify your Aadhar",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.h,
            ),
            // Visual representation of Aadhar card for user recognition
            Image.asset('assets/images/aadharcard.png'),
            // Push content to top and security notice to bottom
            Spacer(),
            // Security assurance container
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
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
                    SizedBox(
                      width: 12.w,
                    ),
                    // Security assurance message
                    Text("Your details are 100% safe with us")
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Action button to proceed to the next step in KYC process
            constWidgets.greenButton("Proceed for KYC", onTap: () {
              // Navigate to segment selection screen
              navi(SegmentSelectionScreen(), context);
            }),
            SizedBox(height: 10.h),
            // Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }
}