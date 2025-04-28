// File: initialScreen.dart
// Description: This file implements the initial welcome screen of the Sapphire Trading application.
// It serves as the entry point for user authentication, providing options to either log in or sign up.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_svg/svg.dart'; // For SVG rendering support
import 'package:sapphire/main.dart'; // Contains app-wide navigation utilities
import 'package:sapphire/screens/signUp/emailScreen.dart'; // Sign-up flow starting screen
import 'package:sapphire/screens/signUp/loginScreen.dart'; // Authentication screen
import 'package:sapphire/utils/constWidgets.dart'; // Contains reusable UI components

/// InitialScreen - Welcome screen widget that serves as the entry point to the application
/// Provides options for users to either log in with existing credentials or sign up
class InitialScreen extends StatelessWidget {
  /// Standard constructor with optional key parameter for widget identification
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode to adjust UI elements accordingly
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Set background color based on the current theme mode
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        // Apply horizontal padding for better visual appearance
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add flexible space at the top for better vertical distribution
            const Spacer(),

            // Logo and brand name row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App logo with adaptive coloring based on theme
                Image.asset(
                  'assets/images/whiteLogo.png',
                  color: isDark ? Colors.white : Colors.black,
                  scale: 1,
                ),
                // Alternative SVG logo implementation (commented out)
                // SvgPicture.asset("assets/svgs/Logo.svg",
                //     color: isDark ? Colors.white : Colors.black),

                // Spacing between logo and brand name
                SizedBox(width: 10.w),

                // Brand name with styling
                Text(
                  "Sapphire",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),

            // Vertical spacing
            SizedBox(height: 15.h),

            // Welcome message
            Text(
              "Welcome to Sapphire Terminal",
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            // Large vertical space before action buttons
            SizedBox(height: 300.h),

            // Login button - navigates to the login screen when pressed
            constWidgets.greenButton("LOG IN", onTap: () {
              navi(const LoginScreen(), context);
            }),

            // Vertical spacing between buttons
            SizedBox(height: 20.h),

            // Divider with "OR" text in the middle
            Row(
              children: [
                // Left divider
                Expanded(
                  child: Divider(
                    color: isDark
                        ? const Color(0xFF2F2F2F)
                        : const Color(0xFFD1D5DB),
                  ),
                ),

                // "OR" text with padding
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color:
                      isDark ? Colors.grey[400] : const Color(0xFFC9CACC),
                    ),
                  ),
                ),

                // Right divider
                Expanded(
                  child: Divider(
                    color: isDark
                        ? const Color(0xFF2F2F2F)
                        : const Color(0xFFD1D5DB),
                  ),
                ),
              ],
            ),

            // Vertical spacing after divider
            SizedBox(height: 20.h),

            // Sign up button - navigates to the email input screen when pressed
            constWidgets.greenButton("SIGN UP", onTap: () {
              navi(const EmailScreen(), context);
            }),

            // Push footer to bottom of screen
            const Spacer(),

            // Footer with legal information
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isDark ? Colors.grey[500] : const Color(0xFF9B9B9B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}