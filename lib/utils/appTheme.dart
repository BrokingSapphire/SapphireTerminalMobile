// File: appTheme.dart
// Description: Theme configuration for the Sapphire Trading application.
// This file defines light and dark theme settings to maintain consistent UI/UX across the app.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling

/// AppThemes - Static class containing theme definitions used throughout the app
/// Provides standardized styling for light and dark modes with customized component themes
class AppThemes {
  /// Shared checkbox styling for both light and dark themes
  /// Creates customized checkboxes with rounded corners and proper state handling
  static CheckboxThemeData checkboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.r), // Rounded border
    ),
    // Dynamically determine border color based on checkbox state
    side: MaterialStateBorderSide.resolveWith(
          (states) => BorderSide(
        color: states.contains(MaterialState.selected)
            ? Colors.green // Green when checked
            : Colors.grey, // Grey when unchecked
        width: 2.0,
      ),
    ),
    // Dynamically determine fill color based on checkbox state
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.green; // Green fill when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
    checkColor: MaterialStateProperty.all(Colors.white), // White checkmark
    visualDensity: VisualDensity.compact, // Reduce size for better UI density
  );

  /// Factory method for creating text field decoration theme
  /// Allows dynamic cursor color adaptation based on the theme brightness
  /// Returns consistent input field styling with proper focus states
  static InputDecorationTheme getTextFieldTheme(Color cursorColor) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: cursorColor, width: 2.0), // Highlighted border when focused
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey.shade700), // Subtle border when not focused
      ),
      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp), // Placeholder text styling
    );
  }

  /// Light theme configuration
  /// Used when device is in light mode or user selects light mode
  static final ThemeData lightTheme = ThemeData(
    // Text button styling for light theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.black)),
    ),
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white, // White background for screens
    fontFamily: "SFPro", // Default font family
    checkboxTheme: checkboxTheme, // Apply shared checkbox theme
    dividerColor: Color(0xff121413),
    // Text selection settings
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black, // Black cursor for light theme
    ),
    // Text field styling
    inputDecorationTheme:
    getTextFieldTheme(Colors.black), // Apply TextField Theme with black cursor
    // App bar configuration
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: "SFPro",
        color: Colors.white,
      ),
    ),
    // Text styles for different text categories
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "SFPro",
          color: Colors.black),
      bodyLarge:
      TextStyle(fontSize: 16, fontFamily: "SFPro", color: Colors.black),
      bodyMedium:
      TextStyle(fontSize: 14, fontFamily: "SFPro", color: Colors.grey),
    ),
  );

  /// Dark theme configuration
  /// Used when device is in dark mode or user selects dark mode
  static final ThemeData darkTheme = ThemeData(
    // Bottom sheet styling
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff121413), // Dark color for bottom sheets
      modalBackgroundColor: Color(0xff121413), // For modal bottom sheets
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)), // Rounded top corners
      ),
    ),
    // Text button styling for dark theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Color(0xff020202), // Near-black background for screens
    fontFamily: "SFPro", // Default font family
    checkboxTheme: checkboxTheme, // Apply shared checkbox theme
    // Text selection settings
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white, // White cursor for dark theme
    ),
    // Text field styling
    inputDecorationTheme:
    getTextFieldTheme(Colors.white), // Apply TextField Theme with white cursor
    // App bar configuration
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: "SFPro",
        color: Colors.white,
      ),
    ),
    // Text styles for different text categories
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: "SFPro",
          color: Colors.white),
      bodyLarge:
      TextStyle(fontSize: 16, fontFamily: "SFPro", color: Colors.white),
      bodyMedium:
      TextStyle(fontSize: 14, fontFamily: "SFPro", color: Colors.white),
    ),
  );
}