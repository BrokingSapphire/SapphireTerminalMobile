// File: signConfirmationScreen.dart
// Description: Signature confirmation screen in the Sapphire Trading application.
// This screen displays the user's captured signature for review and confirmation
// before proceeding to the next step in the account opening process.

import 'dart:typed_data'; // For handling binary data (signature image)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG rendering support
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import '../../utils/constWidgets.dart'; // Reusable UI components
import 'NomineeScreen.dart'; // Next screen in registration flow

/// SignConfirmationScreen - Screen for reviewing and confirming the captured signature
/// Displays the signature image and provides options to redo or proceed
class SignConfirmationScreen extends StatelessWidget {
  // Raw image data of the captured signature
  final Uint8List signatureBytes;

  /// Constructor requiring the signature image data
  const SignConfirmationScreen({required this.signatureBytes});

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
              Navigator.pop(
                  context); // Navigate back to signature capture screen
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
            // Progress indicator showing current step (1 of 7)
            constWidgets.topProgressBar(1, 7, context),
            SizedBox(height: 24.h),

            // Screen title
            Text(
              "Signature",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),

            // Container to display the captured signature
            Container(
              width: double.infinity,
              height: 350.h,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white
                    : Color(
                        0xffE3E6EB), // White background for signature visibility
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white24),
              ),
              // Conditionally display signature or error message
              child: signatureBytes.isNotEmpty
                  ? Image.memory(signatureBytes,
                      fit: BoxFit.contain) // Display the signature
                  : Center(
                      child: Text(
                          "No Signature Found", // Fallback text if signature data is empty
                          style: TextStyle(color: Colors.black))),
            ),

            // Redo button for retaking signature
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(4), // Subtle rounded corners
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Return to signature capture screen
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Compact button size
                  children: [
                    Text(
                      "Redo",
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black),
                    ),
                    SizedBox(width: 8), // Space between text and icon
                    SvgPicture.asset(
                      'assets/images/Redo.svg',
                      color: isDark ? Colors.white : Colors.black,
                    ), // Redo icon
                  ],
                ),
              ),
            ),

            // Push content to top and buttons to bottom
            Spacer(),

            // Continue button - proceeds to nominee screen
            constWidgets.greenButton("Continue", onTap: () {
              navi(nomineeScreen(), context);
            }),
            SizedBox(
              height: 10.h,
            ),

            // Help button for user assistance
            Center(
              child: constWidgets.needHelpButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
