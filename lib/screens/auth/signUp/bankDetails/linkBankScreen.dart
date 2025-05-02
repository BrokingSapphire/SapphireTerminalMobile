// File: linkBankScreen.dart
// Description: Bank account linking options screen in the Sapphire Trading application.
// This screen provides users with different methods to link their bank account,
// either via UPI or by entering bank details manually.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG rendering support
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/signUp/manualLinkingScreen.dart'; // Screen for manual bank linking
import 'package:sapphire/screens/signUp/linkWithUpiScreen.dart'; // Screen for UPI linking
import '../../../utils/constWidgets.dart'; // Reusable UI components

/// linkBankScreen - Screen that presents bank account linking options
/// Allows users to choose between linking their bank via UPI or manual entry
/// Note: Class name should be capitalized as per Dart conventions (LinkBankScreen)
class linkBankScreen extends StatelessWidget {
  // Secure storage for authentication tokens
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  /// Initiates the bank validation process based on selected method
  /// @param type The validation type ("upi" or "bank")
  /// @param context The current build context
  Future<void> initiateValidation(String type, BuildContext context) async {
    // API implementation is commented out in original code
    // final token = await secureStorage.read(key: 'auth_token');

    // final url = Uri.parse(
    //     "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // final body = {
    //   "step": "bank_validation_start",
    //   "validation_type": type, // "upi" or "bank"
    // };

    // Show loading indicator while processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      // Commented out actual API call implementation
      // final response = await http.post(
      //   url,
      //   headers: {
      //     "accept": "application/json",
      //     "Content-Type": "application/json",
      //     "Authorization": "Bearer $token",
      //   },
      //   body: jsonEncode(body),
      // );

      // Simulated delay (for development/testing)
      Future.delayed(Duration(seconds: 2));

      // Dismiss loading indicator
      Navigator.of(context).pop();

      // Commented out conditional response handling
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   constWidgets.snackbar("Validation started", Colors.green, context);
      //   if (type == "upi") {

      // Currently hardcoded to navigate to UPI screen regardless of selection
      navi(linkWithUpiScreen(), context);

      //   } else {
      //     navi(ManualLinkingScreen(), context);
      //   }
      // } else {
      //   final msg = jsonDecode(response.body)['error']?['message'] ??
      //       'Validation failed';
      //   constWidgets.snackbar(msg, Colors.red, context);
      // }
    } catch (e) {
      // Handle and display any errors
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

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
            SizedBox(height: 8.h),
            // Progress indicator showing current step in registration flow (step 1 of 5)
            constWidgets.topProgressBar(1, 5, context),
            SizedBox(height: 24.h),

            // Screen title
            Text("Link your bank account",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),

            // Explanatory text about bank account linking purpose
            Text(
              "To finish opening your account,  you'll need to link your bank account, which will be used for your investments. Once linked, we'll verify it to ensure it belongs to you.",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: isDark ? Color(0xffEBEEF5) : Color(0xff1A1A1A)),
            ),
            SizedBox(height: 16.h),

            // UPI linking option (recommended method)
            _buildBankOption(
              title2: "(recommended)",
              svgAssetPath: "assets/images/upi.svg",
              title: "Link via UPI ",
              onTap: () => initiateValidation("upi", context),
              isDark: isDark,
            ),
            SizedBox(height: 12.h),

            // Manual bank details entry option
            _buildBankOption(
              title2: "",
              svgAssetPath: "assets/images/bank.svg",
              title: "Enter Bank details manually",
              onTap: () => initiateValidation("bank", context),
              isDark: isDark,
            ),

            // Push help button to bottom
            Spacer(),

            // Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Creates a selectable bank linking option card
  /// @param svgAssetPath Path to the SVG icon for the option
  /// @param title Main title text for the option
  /// @param title2 Secondary title text (e.g., "recommended")
  /// @param subtitle Optional subtitle text (not used in current implementation)
  /// @param onTap Callback function when option is selected
  /// @return A styled, tappable container widget representing the linking option
  Widget _buildBankOption({
    required String svgAssetPath,
    required String title,
    required String title2,
    String? subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Color(0xFF121413) : Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            // Option icon (UPI or bank)
            SvgPicture.asset(
              svgAssetPath,
              width: 20.w,
              height: 20.h,
              color: svgAssetPath == 'assets/images/bank.svg'
                  ? isDark
                      ? Colors.white
                      : Colors.black
                  : null,
            ),
            SizedBox(width: 16.w),

            // Option text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with optional secondary text (different styling)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: title2,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Optional subtitle (currently not used)
                  if (subtitle != null)
                    Text(subtitle,
                        style: TextStyle(fontSize: 14.sp, color: Colors.green)),
                ],
              ),
            ),
            // Right arrow indicator
            Icon(Icons.arrow_forward_ios,
                color: isDark ? Colors.white : Colors.black87, size: 20),
          ],
        ),
      ),
    );
  }
}
