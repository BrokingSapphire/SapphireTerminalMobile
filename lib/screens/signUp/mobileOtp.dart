// File: mobileOtp.dart
// Description: Mobile number input screen in the Sapphire Trading application's registration flow.
// This screen collects the user's mobile number after email verification for two-factor authentication.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter/services.dart'; // For input formatting
import 'package:sapphire/functions/authFunctions.dart'; // Authentication utilities
import 'package:sapphire/screens/signUp/mobileOtpVerification.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

import '../../main.dart'; // App-wide utilities

/// MobileOtp - Screen for collecting user's mobile number 
/// Follows email verification in the registration flow
/// Sends the mobile number for verification and proceeds to OTP verification
class MobileOtp extends StatefulWidget {
  final String email; // Email passed from previous screen (already verified)

  /// Constructor requiring the user's verified email
  const MobileOtp({super.key, required this.email});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

/// State class for the MobileOtp widget
/// Manages mobile number input and validation
class _MobileOtpState extends State<MobileOtp> {
  // Controller for the phone number input field
  final TextEditingController _phoneNumber = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Add listener to phone number controller to trigger UI updates
    _phoneNumber.addListener(() {
      setState(() {}); // Rebuild UI when phone number changes (for button state)
    });
  }

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode to adjust UI elements accordingly
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
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
          // Dismiss keyboard when tapping outside input field
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          // Layout builder ensures content fills available space
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  // Ensure content takes at least full screen height
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Screen title
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Mobile Verification",
                              style: TextStyle(
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(height: 24.h),

                        /// Phone number input field with validation
                        Form(
                          key: _formKey,
                          child: constWidgets.textField(
                            "Phone Number",
                            _phoneNumber,
                            isPhoneNumber: true, // Enable phone number formatting
                            isDark: isDark, // Pass theme context
                          ),
                        ),
                        SizedBox(height: 20.h), // Extra spacing
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        /// Bottom navigation bar with footer and action buttons
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Footer with legal disclaimer
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                      textAlign: TextAlign.left,
                      style:
                      TextStyle(fontSize: 11.sp, color: Color(0xFF9B9B9B)),
                    ),
                  ),
                ],
              ),

              /// Continue button - conditionally enabled based on input validity
              Container(
                height: 52.h,
                width: double.infinity,
                child: ElevatedButton(
                  // Complex condition to determine if button should be active
                  onPressed: (_phoneNumber.text.isNotEmpty &&
                      _formKey.currentState != null &&
                      _formKey.currentState!.validate())
                      ? () {
                    // Submit mobile number for verification and navigate to OTP screen
                    AuthFunctions()
                        .mobileVerification(
                        _phoneNumber.text.toString(), widget.email)
                        .then((value) => navi(
                        MobileOtpVerification(
                            isEmail: false, // Mobile verification mode
                            email: widget.email, // Pass email for record
                            mobileOrEmail:
                            _phoneNumber.text.toString()), // Mobile number for OTP
                        context));
                  }
                      : () {
                    // Show error snackbar if validation fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Enter a valid phone number!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  // Button style changes based on validation state
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (_phoneNumber.text.isNotEmpty &&
                        _formKey.currentState != null &&
                        _formKey.currentState!.validate())
                        ? Color(0xFF1DB954) // Green when valid
                        : Color(0xff2f2f2f), // Dark gray when invalid
                    foregroundColor: Colors.white,
                  ),
                  // Button text with conditional styling
                  child: Text("Continue",
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: (_phoneNumber.text.isNotEmpty &&
                              _formKey.currentState != null &&
                              _formKey.currentState!.validate())
                              ? Colors.white // White text when valid
                              : Color(0xffc9cacc))), // Gray text when invalid
                ),
              ),

              SizedBox(height: 10.h),

              /// Help button for user assistance
              constWidgets.needHelpButton(context),
            ],
          ),
        ),
      ),
    );
  }
}