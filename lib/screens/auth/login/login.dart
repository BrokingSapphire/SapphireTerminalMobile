// File: login.dart
// Description: Implements the login screen for the Sapphire Trading application.
// This screen handles user authentication by collecting client ID and password.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG rendering support
import 'package:sapphire/main.dart'; // Contains app-wide utilities
import 'package:sapphire/screens/home/riskDisclosure.dart';
import 'package:sapphire/screens/auth/signUp/contactDetails/email.dart';
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:sapphire/utils/naviWithoutAnimation.dart'; // Custom navigation utility

/// LoginScreen - Authentication screen that collects user credentials
/// Allows users to enter their client ID and password to access the application
class LoginScreen extends StatefulWidget {
  /// Standard constructor with optional key parameter
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// State class for the LoginScreen widget
/// Manages the form state and UI interactions
class _LoginScreenState extends State<LoginScreen> {
  // Form controllers for user input fields
  TextEditingController clientId = TextEditingController();
  TextEditingController password = TextEditingController();

  // State variables for UI toggles
  bool rememberMe = false; // Checkbox state for remembering credentials
  bool isPasswordVisible = false; // Toggle for password visibility

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode to adjust UI elements accordingly
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        // Allow UI to resize when keyboard appears
        resizeToAvoidBottomInset: true,
        body: Center(
          child: GestureDetector(
            // Dismiss keyboard when tapping outside input fields
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0.w),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Top spacing
                        SizedBox(height: 40.h),

                        // App logo
                        Image.asset("assets/images/whiteLogo.png", scale: 0.7),
                        SizedBox(height: 30.h),

                        // Welcome header section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Main welcome title
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontSize: 34.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 17.h),

                              // Subtitle
                              Text(
                                "Login to your account",
                                style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontSize: 21.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 42.h),

                        /// Client ID input field
                        /// Collects the user's unique client identifier
                        TextFormField(
                          controller: clientId,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            labelText: "Client ID",
                            labelStyle: TextStyle(
                                color: isDark
                                    ? const Color(0xFFC9CACC)
                                    : const Color(0xFF6B7280)),
                            hintStyle: TextStyle(
                                color: isDark
                                    ? const Color(0xFFC9CACC)
                                    : const Color(0xFF6B7280),
                                fontSize: 15.sp),
                            // Apply rounded corner style to text field
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                            ),
                            // Style for the field when not focused
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                              borderSide: BorderSide(
                                  color: isDark
                                      ? const Color(0xff2f2f2f)
                                      : const Color(0xffD1D5DB)),
                            ),
                            // Style for the field when focused
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.0),
                            ),
                            // User icon at start of input field
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 12.w),
                              child: SvgPicture.asset(
                                'assets/svgs/user.svg',
                                height: 20.h,
                                width: 20.w,
                                color: isDark
                                    ? const Color(0xFFC9CACC)
                                    : const Color(0xFF6B7280),
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 40.w),
                          ),
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 16.sp),
                          // Input validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Client ID';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),

                        /// Password input field with visibility toggle
                        /// Securely collects the user's password with option to show/hide
                        TextFormField(
                          controller: password,
                          // Toggle between visible and obscured text
                          obscureText: !isPasswordVisible,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: isDark
                                  ? const Color(0xFFC9CACC)
                                  : const Color(0xFF6B7280),
                            ),
                            hintStyle: TextStyle(
                                color: isDark
                                    ? const Color(0xFFC9CACC)
                                    : const Color(0xFF6B7280),
                                fontSize: 15.sp),
                            // Apply rounded corner style to text field
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                            ),
                            // Style for the field when not focused
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                              borderSide: BorderSide(
                                  color: isDark
                                      ? const Color(0xff2f2f2f)
                                      : const Color(0xffD1D5DB)),
                            ),
                            // Style for the field when focused
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.r)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.0),
                            ),
                            // Key icon at start of input field
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 12.w),
                              child: SvgPicture.asset(
                                'assets/svgs/key.svg',
                                height: 20.h,
                                width: 20.w,
                                color: isDark
                                    ? const Color(0xFFC9CACC)
                                    : const Color(0xFF6B7280),
                              ),
                            ),
                            prefixIconConstraints:
                                BoxConstraints(minWidth: 40.w),

                            /// Eye icon toggle button for password visibility
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Toggle password visibility state
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 16.w),
                                child: SvgPicture.asset(
                                  isPasswordVisible
                                      ? 'assets/svgs/eye-off.svg' // Eye closed when password is visible
                                      : 'assets/svgs/eye.svg',
                                  // Eye open when password is hidden
                                  height: 20.h,
                                  width: 20.w,
                                  color: isDark
                                      ? const Color(0xFFC9CACC)
                                      : const Color(0xFF6B7280),
                                ),
                              ),
                            ),
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 40.w),
                          ),
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                          // Input validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        /// Remember Me checkbox with label
                        /// Allows users to save their credentials for future logins
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Align(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Clickable row that toggles the checkbox
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      rememberMe = !rememberMe;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Checkbox component with rounded corners
                                      Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.r),
                                        ),
                                        value: rememberMe,
                                        onChanged: (val) {
                                          setState(() {
                                            rememberMe = !rememberMe;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 2.w),
                                      // "Remember me" text label
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.h),
                                        child: Text(
                                          "Remember me",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: isDark
                                                ? const Color(0xFFC9CACC)
                                                : const Color(0xFF6B7280),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: Implement account recovery flow
                                    },
                                    child: Text(
                                      "Trouble logging in?",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.green,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),

                        /// Login button
                        /// Processes the login attempt and navigates to next screen on success
                        constWidgets.greenButton("Continue", onTap: () {
                          // Navigate to the Disclosure screen without animation
                          naviWithoutAnimation(context, Disclosure());
                        }),
                        SizedBox(height: 24.h),
                        RichText(
                          text: TextSpan(
                            text: "Dont have an account? ",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark
                                  ? const Color(0xFFC9CACC)
                                  : const Color(0xFF6B7280),
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blue,
                                  decorationColor: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to the Sign Up screen
                                    naviRep(const EmailScreen(), context);
                                  },
                              ),
                            ],
                          ),
                        ),

                        Spacer(),

                        /// Footer with legal disclaimer
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Text(
                            "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11.sp, color: Color(0xFF9B9B9B)),
                          ),
                        ),
                        constWidgets.needHelpButton(context)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
