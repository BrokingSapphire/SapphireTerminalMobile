// File: mPINScreen.dart
// Description: MPIN (Mobile PIN) authentication screen in the Sapphire Trading application.
// This screen allows users to securely log in using a 4-digit PIN code or biometric authentication
// (fingerprint on Android, Face ID on iOS) when available.

import 'dart:io' show Platform; // For platform-specific code
import 'package:flutter/foundation.dart' show kIsWeb; // To detect web platform
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/flutter_svg.dart'; // For SVG rendering support
import 'package:pinput/pinput.dart'; // Specialized PIN input widget
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/auth/login/login.dart'; // Login screen
import 'package:sapphire/screens/auth/signUp/initialPage.dart'; // Initial sign-up screen
import 'package:sapphire/screens/home/riskDisclosure.dart'; // Disclosure screen
import 'package:local_auth/local_auth.dart'; // For biometric authentication
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:sapphire/utils/naviWithoutAnimation.dart'; // Biometric error codes

/// UseMpinScreen - Secure authentication screen for accessing the application
/// Provides numeric keypad for entering 4-digit PIN with option for biometric authentication
class UseMpinScreen extends StatefulWidget {
  const UseMpinScreen({super.key});

  @override
  State<UseMpinScreen> createState() => _UseMpinScreenState();
}

/// State class for the UseMpinScreen widget
/// Manages PIN input, biometric authentication, and UI rendering
class _UseMpinScreenState extends State<UseMpinScreen> {
  // Controller for the PIN input field
  final TextEditingController _pinController = TextEditingController();

  // Stores the user-entered PIN during input
  String enteredPin = "";

  // Default MPIN for validation
  static const String defaultMpin = "0000";

  // Instance of LocalAuthentication for biometric features
  final LocalAuthentication _auth = LocalAuthentication();

  /// Handles keypad button presses
  /// @param value Button value ("0"-"9", "back", or "submit")
  void _onKeyPressed(String value) {
    if (value == "back" && enteredPin.isNotEmpty) {
      // Handle backspace - remove last digit
      setState(() {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      });
    } else if (value == "submit") {
      // Submit handled in keypad to validate PIN
      return;
    } else if (enteredPin.length < 4) {
      // Add digit if PIN is not complete
      setState(() {
        enteredPin += value;
      });
    }
    // Update PIN input display
    _pinController.text = enteredPin;
  }

  /// Validates the entered PIN against the default MPIN
  /// Shows error messages for invalid or short PINs
  void _validateAndSubmit() {
    if (enteredPin.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a 4-digit MPIN",
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else if (enteredPin != defaultMpin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Incorrect MPIN",
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      // Navigate to disclosure screen and replace route
      naviWithoutAnimation(context, Disclosure());
    }
  }

  /// Checks if biometric authentication is available on the device
  /// @return Future<bool> True if biometric authentication is supported
  Future<bool> _canAuthenticate() async {
    if (kIsWeb) return false; // Biometrics not supported on web

    try {
      // Check if device supports biometrics AND has enrolled biometrics
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (e) {
      print("Error checking biometrics: $e");
      return false;
    }
  }

  /// Initiates biometric authentication process
  /// Shows appropriate messages based on platform and handles errors
  Future<void> _authenticate() async {
    try {
      // Attempt biometric authentication
      bool authenticated = await _auth.authenticate(
        localizedReason: Platform.isAndroid
            ? 'Scan your fingerprint to authenticate'
            : 'Scan your face to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true, // Only use biometrics, not device password
          stickyAuth:
              true, // Maintain authentication validity during app switches
        ),
      );

      if (authenticated) {
        // Authentication successful - navigate to disclosure screen
        naviRep(const Disclosure(), context);
      } else {
        // Authentication failed - show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Authentication failed',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle specific biometric errors with appropriate messages
      String errorMessage;

      if (e.toString().contains(auth_error.notEnrolled)) {
        errorMessage = 'Please set up biometrics in your device settings';
      } else if (e.toString().contains(auth_error.notAvailable)) {
        errorMessage = 'This device does not support biometric authentication';
      } else {
        errorMessage = 'An error occurred during authentication';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Shows a logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff121413) : const Color(0xffF4F4F9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Logout",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Do you really want to log out?",
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xff6B7280),
                  fontSize: 15.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed: () {
                  // Navigate to initial screen
                  naviRep(const InitialScreen(), context);
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  "Log out",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? const Color(0xff121413)
                      : const Color(0xffF4F4F9),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: isDark
                          ? const Color(0xff2F2F2F)
                          : const Color(0xffD1D5DB),
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 8.h), // Bottom padding for safe area
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          iconSize: 28.sp,
          onPressed: () {
            _showLogoutDialog(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {
                naviRep(const LoginScreen(), context);
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/switchAccountThree.svg",
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(
                      isDark ? Colors.white : Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Switch account",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          // User name display
          Text(
            "Nakul Pratap Thakur", // Should be dynamic in production
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 21.sp,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          // Client code display
          Text(
            "J098WE", // Should be dynamic in production
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
              color: const Color(0xFF1DB954),
            ),
          ),
          SizedBox(height: 30.h),
          // PIN input field using Pinput widget
          Pinput(
            length: 4, // 4-digit PIN
            controller: _pinController,
            obscureText: true, // Mask PIN for security
            enabled: false, // No direct input - uses custom keypad
            separatorBuilder: (index) => SizedBox(width: 12.w),
            defaultPinTheme: PinTheme(
              width: 50.w,
              height: 50.h,
              textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? Colors.grey : Colors.grey.shade400,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 50.w,
              height: 50.h,
              textStyle: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? Colors.white : Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          // Conditionally show biometric authentication option if available
          FutureBuilder<bool>(
            future: _canAuthenticate(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink(); // Show nothing while checking
              }
              bool canAuthenticate = snapshot.data ?? false;
              if (!canAuthenticate) {
                return const SizedBox
                    .shrink(); // Hide if biometrics not available
              }
              return GestureDetector(
                onTap: _authenticate, // Trigger biometric authentication
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Platform.isAndroid
                          ? "Use Fingerprint"
                          : Platform.isIOS
                              ? "Use Face ID"
                              : "Use Biometric",
                      style: TextStyle(
                        color: const Color(0xFF1DB954),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 7.w),
                    SvgPicture.asset(
                      Platform.isAndroid
                          ? "assets/svgs/fingerprint.svg"
                          : "assets/svgs/face.svg",
                      width: 20.w,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF1DB954),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(), // Push numeric keypad to bottom
          // Custom numeric keypad for PIN entry
          buildKeypad(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// Builds the custom numeric keypad with numbers and action buttons
  /// @return Widget The complete keypad grid
  Widget buildKeypad() {
    // Define the keypad buttons (numbers 0-9, back, and submit)
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "back",
      "0",
      "submit",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: keys.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 50, // Fixed height for buttons
          crossAxisCount: 3, // 3 buttons per row
          crossAxisSpacing: 20, // Horizontal spacing
          mainAxisSpacing: 15, // Vertical spacing
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onKeyPressed(keys[index]),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: keys[index] == "back"
                  ? Icon(
                      Icons.backspace,
                      color: const Color(0xFF1DB954),
                      size: 28,
                    ) // Backspace button
                  : keys[index] == "submit"
                      ? InkWell(
                          onTap: _validateAndSubmit,
                          child: Icon(
                            Icons.check,
                            color: const Color(0xFF1DB954),
                            size: 30,
                          ),
                        ) // Submit button
                      : Text(
                          keys[index], // Number button
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: const Color(0xFF1DB954),
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }
}
