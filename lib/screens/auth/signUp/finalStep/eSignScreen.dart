// File: eSignScreen.dart
// Description: Aadhaar E-sign authorization screen in the Sapphire Trading application.
// This is the final step in the account setup process, where users authorize documents
// electronically using their Aadhaar (India's national ID) as a digital signature.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

import '../../../main.dart'; // App-wide navigation utilities
import '../../../utils/constWidgets.dart'; // Reusable UI components
import '../congratulationsScreen.dart'; // Next screen after successful E-sign

/// eSignScreen - The final regulatory step in account creation
/// Handles Aadhaar-based electronic signature authorization for account documents
/// Note: Class name should be capitalized as per Dart conventions (ESignScreen)
class eSignScreen extends StatefulWidget {
  @override
  _eSignScreenState createState() => _eSignScreenState();
}

/// State class for the eSignScreen widget
/// Manages the consent checkbox state and UI rendering
class _eSignScreenState extends State<eSignScreen> {
  // State variable for the consent checkbox
  bool isChecked = true; // Default to checked for electronic communications

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            // Progress indicator showing final step in registration flow (step 1 of 9)
            constWidgets.topProgressBar(1, 9, context),
            SizedBox(
              height: 24.h,
            ),
            // Screen title explaining the purpose of this step
            Text(
              "Finish account set-up using Aadhar E-sign",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 12.h),

            // Visual representation of the Aadhaar E-sign process
            Image.asset("assets/images/esignscreen.png", height: 200.h),

            // Push content to top and consent/buttons to bottom
            Spacer(),

            /// Electronic communication consent checkbox
            /// Allows user to opt-in for electronic contract notes and communications
            Row(
              children: [
                // Checkbox component
                Checkbox(
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        isChecked = !isChecked; // Toggle checkbox state
                      });
                    }),
                // Clickable text label for the checkbox (also toggles the checkbox)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked; // Toggle checkbox state
                      });
                    },
                    child: Text(
                      "I would like to receive ECN and other communications via email.",
                      style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 11.sp),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 12.h,
            ),

            /// Proceed button to initiate Aadhaar E-sign process
            /// In production, this would connect to the UIDAI E-sign service
            constWidgets.greenButton("Proceed to Aadhar E-sign", onTap: () {
              // Navigate to congratulations screen after successful E-sign
              // Note: In production, this would happen after actual E-sign completion
              navi(CongratulationsScreen(), context);
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