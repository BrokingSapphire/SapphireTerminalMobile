// File: mobile.dart
// Description: Mobile number collection and verification screen in the Sapphire Trading application.
// This screen follows email verification and captures the user's mobile number for OTP verification.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter/services.dart'; // For input formatting
import 'package:sapphire/functions/authFunctions.dart'; // Authentication utilities
import 'package:sapphire/screens/auth/signUp/contactDetails/mobileOTPVerification.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

import 'package:sapphire/main.dart'; // App-wide utilities

/// MobileOtp - Screen for collecting user's mobile number
/// Follows email verification in the registration flow
/// Sends the mobile number for verification and proceeds to OTP verification
class MobileOtp extends StatefulWidget {
  final String email; // Email passed from previous screen (already verified)

  const MobileOtp({super.key, required this.email});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

/// State class for the MobileOtp widget
/// Manages mobile number input and validation
class _MobileOtpState extends State<MobileOtp> {
  final TextEditingController _phoneNumber = TextEditingController(); // For phone number input
  final _formKey = GlobalKey<FormState>(); // For form validation

  @override
  void initState() {
    super.initState();
    _phoneNumber.addListener(() {
      setState(
              () {}); // Rebuild UI when phone number changes (for button state updates)
    });
  }

  @override
  void dispose() {
    _phoneNumber.dispose(); // Clean up controller when widget is removed
    super.dispose();
  }

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
      // Main body content with gesture detection to dismiss keyboard on tap
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
        },
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Screen title
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile Verification",
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      // Phone number input field
                      Form(
                        key: _formKey,
                        child: constWidgets.textField(
                          "Phone Number",
                          _phoneNumber,
                          isPhoneNumber: true, // Enable phone number formatting
                          isDark: isDark,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      // Bottom navigation area with disclaimer and continue button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Legal disclaimer text
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isDark ? Color(0xFF9B9B9B) : Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            // Continue button - conditionally styled based on validation state
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // NOTE: Original implementation commented out
                // This section contains the original implementation with API calls
                // onPressed: (_phoneNumber.text.isNotEmpty &&
                //         _formKey.currentState != null &&
                //         _formKey.currentState!.validate())
                //     ? () {
                //         AuthFunctions()
                //             .mobileVerification(
                //                 _phoneNumber.text.toString(), widget.email)
                //             .then((value) => navi(
                //                 MobileOtpVerification(
                //                     isEmail: false,
                //                     email: widget.email,
                //                     mobileOrEmail:
                //                         _phoneNumber.text.toString()),
                //                 context));
                //       }
                //     : () {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content: Text(
                //               "Enter a valid phone number!",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //             backgroundColor: Colors.red,
                //           ),
                //         );
                //       },

                // Temporary simplified implementation - bypasses API call
                // TODO: Restore original implementation with API validation when ready
                onPressed: () {
                  navi(
                      MobileOtpVerification(
                          isEmail: false,
                          email: widget.email,
                          mobileOrEmail: _phoneNumber.text.toString()),
                      context);
                },
                // Button styling - changes color based on validation state
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_phoneNumber.text.isNotEmpty &&
                      _formKey.currentState != null &&
                      _formKey.currentState!.validate())
                      ? Color(0xFF1DB954) // Green when valid
                      : isDark
                      ? Color(0xff2f2f2f) // Dark gray in dark mode when invalid
                      : Colors.grey[300], // Light gray in light mode when invalid
                  foregroundColor: isDark ? Colors.white : Colors.black,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: (_phoneNumber.text.isNotEmpty &&
                        _formKey.currentState != null &&
                        _formKey.currentState!.validate())
                        ? Colors.white // White text when valid
                        : isDark
                        ? Color(0xffc9cacc) // Light gray in dark mode when invalid
                        : Colors.grey[600], // Dark gray in light mode when invalid
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            // Help button for user assistance
            constWidgets.needHelpButton(context),
          ],
        ),
      ),
    );
  }
}