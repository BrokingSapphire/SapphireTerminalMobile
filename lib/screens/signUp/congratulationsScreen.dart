// File: congratulationScreen.dart
// Description: Celebration screen shown after successful account creation in the Sapphire Trading application.
// This screen displays confetti animation, account details, and provides the option to proceed to login.

import 'dart:math'; // For mathematical operations (used by confetti package)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:confetti/confetti.dart'; // For celebration animation effects
import 'package:sapphire/screens/home/homeWarpper.dart'; // Home screen (not used directly)
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

import '../../main.dart'; // App-wide navigation utilities
import 'mPinScreen.dart'; // Next screen for MPIN setup/login

/// CongratulationsScreen - Celebratory screen shown after successful account setup
/// Features animated confetti, displays the user's client code, and guides them to login
class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({super.key});

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

/// State class for the CongratulationsScreen widget
/// Manages confetti animation controller and UI rendering
class _CongratulationsScreenState extends State<CongratulationsScreen> {
  // Controller for the confetti animation
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    // Initialize confetti controller with 2-second duration
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    // Automatically play confetti animation when screen loads
    _confettiController.play();
  }

  @override
  void dispose() {
    // Clean up resources when screen is removed
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      // App bar with back button (rarely used on this screen but provides safety net)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      // Stack to overlay confetti animation on top of content
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Main content container
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  // Congratulations heading with user's name
                  // Note: {user.Name} appears to be a placeholder that should be replaced with actual user name
                  Text(
                    "Congratulations {user.Name} 🎉 !",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Success message explaining account setup completion
                  Text(
                    "Your Sapphire account is now set up and ready to go. Time to start your investment journey!",
                    style: TextStyle(
                        color: isDark ? Color(0xFFC9CACC) : Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  // Decorative line separator
                  SizedBox(
                      width: 130.w,
                      height: 15.h,
                      child: Image.asset("assets/images/line.png")),
                  SizedBox(height: 32.h),

                  // Account information card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        // Container for client code display
                        Container(
                          decoration: BoxDecoration(
                              color: isDark
                                  ? Color(0xff121413)
                                  : Color(0xffF5F7FA),
                              borderRadius: BorderRadius.circular(12.r)),
                          height: 271.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // User profile icon/avatar
                              SizedBox(
                                height: 65.h,
                                width: 65.w,
                                child: Image.asset("assets/images/profile.png"),
                              ),
                              SizedBox(height: 30.h),
                              // Client code display with emphasized styling
                              RichText(
                                text: TextSpan(
                                    children: [
                                      TextSpan(text: "Your Client Code is"),
                                      TextSpan(
                                          text:
                                              " J08596", // Client ID - should be dynamic in production
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.w400)),
                              ),
                              // Motivational message for new users
                              Text(
                                "Get started and make your money\nwork for you!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: isDark ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Push content above and action button to bottom
                  Spacer(),
                  // Login button - navigates to MPIN screen for authentication
                  constWidgets.greenButton("Login to Terminal", onTap: () {
                    navi(MpinScreen(), context);
                  }),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ),

          // Confetti animation overlay positioned at the top of the screen
          Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality
                    .explosive, // Ensures uniform spread in all directions
                emissionFrequency:
                    0.0001, // Very low frequency to fire all confetti at once
                numberOfParticles: 100, // Fixed number of confetti pieces
                gravity: 0.2, // Light gravity for slower falling confetti
                maxBlastForce: 11, // Upper limit for explosion strength
                minBlastForce:
                    10, // Lower limit for explosion strength (close to max for consistency)
                // Colorful confetti pieces
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.yellow,
                  Colors.red,
                  Colors.orange,
                  Colors.purple,
                  Colors.teal
                ],
              )),
        ],
      ),
    );
  }
}
