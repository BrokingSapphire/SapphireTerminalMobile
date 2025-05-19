// File: email.dart
// Description: Email input screen for user registration in the Sapphire Trading application.
// This screen collects the user's email address for account creation and verification.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatting
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/main.dart'; // App-wide utilities
import 'package:sapphire/screens/auth/signUp/contactDetails/mobileOTPVerification.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:sapphire/functions/authFunctions.dart'; // Auth functions for verification

/// EmailScreen - First step in the user registration process
/// Collects multiplexingvalidates the user's email address before proceeding to verification
class EmailScreen extends StatefulWidget {
  /// Standard constructor with optional key parameter
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

/// State class for the EmailScreen widget
/// Manages form input, validation, and navigation
class _EmailScreenState extends State<EmailScreen> {
  // Controller for the email input field
  TextEditingController _email = TextEditingController();

  // Flag to track invalid email state for UI feedback
  bool _isEmailInvalid = false;

  /// Email validation function
  /// Uses regex pattern to verify if the provided string is a valid email format
  /// @param email The email string to validate
  /// @return True if the email format is valid, false otherwise
  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// Validates the email input and proceeds to the next screen if valid
  /// Shows error feedback if validation fails
  void _validateAndProceed() {
    if (_email.text.isEmpty ||
        !isValidEmail(_email.text) ||
        !_email.text.endsWith(".com")) {
      setState(() {
        _isEmailInvalid = true; // Change border color to red
      });

      // Show error snackbar
      constWidgets.snackbar("Enter a valid email address", Colors.red, context);

      // Clear email field after a short delay
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _isEmailInvalid = false; // Reset border color
        });
        _email.clear();
      });
    } else {
      navi(
          MobileOtpVerification(
              isEmail: true,
              email: _email.text.toString(),
              mobileOrEmail: _email.text.toString()),
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode to adjust UI elements accordingly
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Check if keyboard is visible
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      // Simple app bar with back button
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: GestureDetector(
          // Dismiss keyboard when tapping outside input field
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 100.h),

                // Welcome header section with app name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome to\nSapphire",
                    style: TextStyle(
                      fontSize: 34.sp,
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // Subheader describing the signup process
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Get started in just a few easy steps!",
                  ),
                ),
                SizedBox(height: 40.h),

                /// Email input field with validation
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._]')),
                  ],
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    labelText: "Email",
                    labelStyle: TextStyle(
                      color: isDark ? Color(0xFFC9CACC) : Color(0xff6B7280),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: _isEmailInvalid
                              ? Colors.red
                              : isDark
                                  ? Color(0xff2f2f2f)
                                  : Color(0xff6B7280)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(
                          color: _isEmailInvalid ? Colors.red : Colors.green,
                          width: 2.0),
                    ),
                  ),
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16.sp),
                ),
                SizedBox(height: 32.h),

                /// Divider with "OR" text for alternative login options
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR'),
                    ),
                    Expanded(
                        child: Divider(
                            color: isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade300)),
                  ],
                ),
                SizedBox(height: 32.h),

                /// Social login options (Google and Apple)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google login option
                    SizedBox(
                        height: 54.h,
                        width: 54.w,
                        child: isDark
                            ? Image.asset('assets/icons/google.png')
                            : SvgPicture.asset('assets/svgs/google.svg')),
                    SizedBox(width: 50.w),
                    // Apple login option
                    SizedBox(
                        height: 54.h,
                        width: 54.w,
                        child: isDark
                            ? Image.asset('assets/icons/apple.png')
                            : SvgPicture.asset('assets/svgs/apple.svg')),
                  ],
                ),
                // Extra space to avoid content clipping
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Continue button (always visible)
              Container(
                height: 52.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_email.text.isNotEmpty && !_isEmailInvalid)
                      ? _validateAndProceed
                      : null,
                  child: Text(
                    "Continue",
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (_email.text.isNotEmpty && !_isEmailInvalid)
                            ? Color(0xFF1DB954)
                            : Color(0xff2f2f2f),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              // Conditionally show disclaimer and help button
              if (!isKeyboardVisible) ...[
                SizedBox(height: 15.h),
                // Footer section with legal information
                Text(
                  "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: isDark ? Color(0xFF9B9B9B) : Color(0xFF6B7280)),
                ),
                SizedBox(height: 8.h),
                // Help button
                constWidgets.needHelpButton(context),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
