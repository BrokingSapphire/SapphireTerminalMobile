// File: mPinScreen.dart
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
import 'package:sapphire/screens/home/homeWarpper.dart'; // Home screen destination
import 'package:local_auth/local_auth.dart'; // For biometric authentication
import 'package:local_auth/error_codes.dart'
    as auth_error; // Biometric error codes

/// MpinScreen - Secure authentication screen for accessing the application
/// Provides numeric keypad for entering 4-digit PIN with option for biometric authentication
class MpinScreen extends StatefulWidget {
  const MpinScreen({super.key});

  @override
  State<MpinScreen> createState() => _MpinScreenState();
}

/// State class for the MpinScreen widget
/// Manages PIN input, biometric authentication, and UI rendering
class _MpinScreenState extends State<MpinScreen> {
  // Controller for the PIN input field
  final TextEditingController _pinController = TextEditingController();

  // Stores the user-entered PIN during input
  String enteredPin = "";

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
      // Handle submit - navigate to home screen
      // Note: In production, this would validate the PIN first
      navi(HomeWrapper(), context);
    } else if (enteredPin.length < 4) {
      // Add digit if PIN is not complete
      setState(() {
        enteredPin += value;
      });
    }
    // Update PIN input display
    _pinController.text = enteredPin;
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
        // Different prompt text based on platform
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
        // Authentication successful - navigate to home screen
        navi(HomeWrapper(), context);
      } else {
        // Authentication failed - show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Authentication failed',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle specific biometric errors with appropriate messages
      String errorMessage;

      if (e.toString().contains(auth_error.notEnrolled)) {
        // No biometrics enrolled on device
        errorMessage = 'Please set up biometrics in your device settings';
      } else if (e.toString().contains(auth_error.notAvailable)) {
        // Device doesn't support biometrics
        errorMessage = 'This device does not support biometric authentication';
      } else {
        // Generic error message
        errorMessage = 'An error occurred during authentication';
      }

      // Display error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 35.h),
          // App logo
          Image.asset(
            "assets/images/whiteLogo.png",
            scale: 0.7,
          ),
          SizedBox(height: 20.h),

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
              color: Color(0xFF1DB954),
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
            // Default style for PIN dots
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
                    width: 1),
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            // Style for focused PIN dot
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
                    color: isDark ? Colors.white : Colors.black, width: 2),
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
                return SizedBox.shrink(); // Show nothing while checking
              }
              bool canAuthenticate = snapshot.data ?? false;
              if (!canAuthenticate) {
                return SizedBox.shrink(); // Hide if biometrics not available
              }

              // Show appropriate biometric option based on platform
              return GestureDetector(
                onTap: _authenticate, // Trigger biometric authentication
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Adaptive text based on platform
                    Text(
                      Platform.isAndroid
                          ? "Use Fingerprint"
                          : Platform.isIOS
                              ? "Use Face ID"
                              : "Use Biometric",
                      style: TextStyle(
                        color: Color(0xFF1DB954),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 7.w),
                    // Adaptive icon based on platform
                    SvgPicture.asset(
                      Platform.isAndroid
                          ? "assets/svgs/fingerprint.svg"
                          : "assets/svgs/face.svg",
                      width: 20.w,
                      colorFilter: ColorFilter.mode(
                        Color(0xFF1DB954),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Spacer(), // Push numeric keypad to bottom

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
      "submit"
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: keys.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 50, // Fixed height for buttons
          crossAxisCount: 3, // 3 buttons per row
          crossAxisSpacing: 20.w, // Horizontal spacing
          mainAxisSpacing: 15.h, // Vertical spacing
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
                  ? Icon(Icons.backspace,
                      color: Color(0xFF1DB954), size: 28) // Backspace button
                  : keys[index] == "submit"
                      ? InkWell(
                          onTap: () {
                            // Navigate to home screen and replace route (no back navigation)
                            naviRep(HomeWrapper(), context);
                          },
                          child: Icon(Icons.check,
                              color: Color(0xFF1DB954),
                              size: 30)) // Submit button
                      : Text(
                          keys[index], // Number button
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: Color(0xFF1DB954),
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }
}
