import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  // ✅ Checkbox Theme
  static CheckboxThemeData checkboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.r), // Rounded border
    ),
    side: MaterialStateBorderSide.resolveWith(
      (states) => BorderSide(
        color: states.contains(MaterialState.selected)
            ? Colors.green // Green when checked
            : Colors.grey, // Grey when unchecked
        width: 2.0,
      ),
    ),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.green; // Green fill when checked
      }
      return Colors.transparent; // Transparent when unchecked
    }),
    checkColor: MaterialStateProperty.all(Colors.white), // White checkmark
    visualDensity: VisualDensity.compact, // Reduce size
  );

  // ✅ Common TextField Theme (Dynamically Switches Cursor Color)
  static InputDecorationTheme getTextFieldTheme(Color cursorColor) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: cursorColor, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
    );
  }

  // ✅ Light Theme
  static final ThemeData lightTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.black)),
    ),
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "SFPro",
    checkboxTheme: checkboxTheme,
    dividerColor: Color(0xff121413),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black, // Black cursor for light theme
    ),
    inputDecorationTheme:
        getTextFieldTheme(Colors.black), // Apply TextField Theme
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

  // ✅ Dark Theme
  static final ThemeData darkTheme = ThemeData(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff121413), // Set bottom sheet color
      modalBackgroundColor: Color(0xff121413), // For modal bottom sheets
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
    ),
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Color(0xff020202),
    fontFamily: "SFPro",
    checkboxTheme: checkboxTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white, // White cursor for dark theme
    ),
    inputDecorationTheme:
        getTextFieldTheme(Colors.white), // Apply TextField Theme
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
