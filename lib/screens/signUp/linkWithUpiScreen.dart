// File: linkWithUpiScreen.dart
// Description: UPI-based bank account linking screen in the Sapphire Trading application.
// This screen allows users to link their bank account by making a small payment via UPI,
// which automates the bank account detail verification process.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG rendering support
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/signUp/manualLinkingScreen.dart'; // Alternative manual linking screen

import '../../utils/constWidgets.dart'; // Reusable UI components

/// linkWithUpiScreen - Screen for bank account linking via UPI
/// Offers multiple UPI app options for making a nominal transaction to verify bank details
/// Note: Class name should be capitalized as per Dart conventions (LinkWithUpiScreen)
class linkWithUpiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // Progress indicator showing current step in registration flow (step 1 of 5)
            constWidgets.topProgressBar(1, 5, context),
            SizedBox(
              height: 30.h,
            ),

            // Screen title
            Text(
              "Link your bank account",
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),

            // Subtitle explaining the verification method
            Text(
              "By making a transaction of 1 INR",
              style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black,
                  fontSize: 15.sp),
            ),
            SizedBox(height: 20.h),

            // First benefit bullet point - explains auto-fetching of account details
            Text(
                "• We'll automatically fetch your account name and number, so you don't have to enter them manually saving you time and effort!",
                style: TextStyle(
                    color: isDark ? Colors.white70 : Color(0xff6B7280),
                    fontSize: 15.sp)),
            SizedBox(height: 10.h),

            // Second bullet point - explains which bank account to use
            Text(
                "• Kindly make the payment from the bank account you'd like to link to your Sapphire account.",
                style: TextStyle(
                    color: isDark ? Colors.white70 : Color(0xff6B7280),
                    fontSize: 15.sp)),
            SizedBox(height: 30.h),

            // UPI app selection row with popular options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUPIButton(
                    "assets/images/phonepay.svg", "PhonePe", isDark),
                _buildUPIButton("assets/images/gpay.svg", "GPay", isDark),
                _buildUPIButton("assets/images/paytm.svg", "PayTM", isDark),
              ],
            ),
            SizedBox(height: 30.h),

            // Divider with "OR" text
            Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  "  OR  ",
                  style: TextStyle(color: const Color(0xFFC9CACC)),
                ),
                Expanded(child: Divider())
              ],
            ),
            SizedBox(height: 20.h),

            // Alternative option for manual account linking
            Center(
              child: TextButton(
                onPressed: () {
                  navi(ManualLinkingScreen(),
                      context); // Navigate to manual linking screen
                },
                child: Text(
                  "Link bank account manually",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Push help button to bottom
            Spacer(),

            // Help button for user assistance
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a selectable UPI app button
  /// @param assetPath Path to the SVG icon of the UPI app
  /// @param label Name of the UPI app to display
  /// @return A styled column with UPI app icon and label
  Widget _buildUPIButton(String assetPath, String label, bool isDark) {
    return Column(
      children: [
        // UPI app icon container
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: isDark ? Colors.white10 : Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: SvgPicture.asset(
            assetPath,
          )), // UPI Logo
        ),
        SizedBox(height: 5.h),
        // UPI app name
        Text(label,
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black, fontSize: 13.sp)),
      ],
    );
  }
}
