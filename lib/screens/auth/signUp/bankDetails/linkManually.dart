// File: linkManually.dart
// Description: Manual bank account linking screen in the Sapphire Trading application.
// This screen allows users to manually enter their bank account details (IFSC code,
// account number, and account type) as an alternative to UPI-based linking.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/auth/signUp/bankDetails/confirmBankDetails.dart'; // Next screen after successful linking
import 'package:sapphire/screens/auth/signUp/bankDetails/linkViaUPI.dart'; // Alternative UPI linking screen
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// ManualLinkingScreen - Screen for manually entering bank account details
/// Provides fields for IFSC code, account number, and account type selection
class ManualLinkingScreen extends StatefulWidget {
  const ManualLinkingScreen({super.key});

  @override
  _ManualLinkingScreenState createState() => _ManualLinkingScreenState();
}

/// State class for the ManualLinkingScreen widget
/// Manages form input, validation, and navigation
class _ManualLinkingScreenState extends State<ManualLinkingScreen> {
  // Text controllers for input fields
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  // Selection state for account type
  String? selectedAccountType;

  // Flag to track if form is complete for button enabling
  bool _isButtonDisabled = true;

  // Focus node for IFSC field to manage refocusing
  final FocusNode _ifscFocusNode = FocusNode();

  // Flag to track if numeric keyboard should be shown for IFSC
  bool _isNumericPhase = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to input controllers to check form completeness
    ifscController.addListener(_checkFields);
    accountNumberController.addListener(_checkFields);
  }

  /// Checks if all required fields are filled
  /// Updates button enabled state based on form completeness
  void _checkFields() {
    setState(() {
      _isButtonDisabled = ifscController.text.trim().isEmpty ||
          accountNumberController.text.trim().isEmpty ||
          selectedAccountType == null;
    });
  }

  /// Updates the selected account type
  /// @param value The selected account type ("Savings" or "Current")
  void _selectAccountType(String value) {
    setState(() {
      selectedAccountType = value;
      _checkFields(); // Re-check form completeness
    });
  }

  /// Handles IFSC input changes to switch keyboards
  void _handleIfscChange(String value) {
    if (value.length == 4 && !_isNumericPhase) {
      setState(() {
        _isNumericPhase = true;
      });
      // Close the text keyboard and refocus with numeric keyboard
      FocusScope.of(context).unfocus();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_ifscFocusNode);
      });
    } else if (value.length < 4 && _isNumericPhase) {
      setState(() {
        _isNumericPhase = false;
      });
      // Close the numeric keyboard and refocus with text keyboard
      FocusScope.of(context).unfocus();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_ifscFocusNode);
      });
    }
  }

  @override
  void dispose() {
    // Clean up resources when screen is removed
    ifscController.removeListener(_checkFields);
    accountNumberController.removeListener(_checkFields);
    ifscController.dispose();
    accountNumberController.dispose();
    _ifscFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      ),
      body: GestureDetector(
        // Dismiss keyboard when tapping outside input fields
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // Progress indicator showing current step (1 of 5)
              constWidgets.topProgressBar(1, 5, context),
              SizedBox(height: 24.h),

              // Screen title
              Text(
                "Link your bank account",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),

              // Instruction text
              Text(
                "Make sure that you are linking a bank account that is in your name.",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 16.h),

              // IFSC code input field with dynamic keyboard
              TextField(
                controller: ifscController,
                focusNode: _ifscFocusNode,
                keyboardType:
                    _isNumericPhase ? TextInputType.number : TextInputType.text,
                inputFormatters: [
                  IfscInputFormatter(), // Enforce 4 letters + 7 digits
                  UpperCaseTextFormatter(), // Force uppercase for letters
                  LengthLimitingTextInputFormatter(
                      11), // Limit to 11 characters
                ],
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
                onChanged: _handleIfscChange,
                decoration: InputDecoration(
                  labelText: "IFSC Code",
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 14.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: const BorderSide(
                      color: Color(0xFF1DB954), // Green focused border
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Account number input field with numeric input
              TextField(
                controller: accountNumberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Restrict to digits
                ],
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  labelText: "Account Number",
                  labelStyle: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 14.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide(
                      color: isDark ? Colors.grey[600]! : Colors.grey[400]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: const BorderSide(
                      color: Color(0xFF1DB954), // Green focused border
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.h),

              // Account type selection section
              Text(
                "Account Type",
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Savings account option
                  _buildSelectableChip("Savings", isDark),
                  SizedBox(width: 20.w),
                  // Current account option
                  _buildSelectableChip("Current", isDark),
                ],
              ),
              SizedBox(height: 24.h),

              // Divider with "OR" text for alternative linking method
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    "  OR  ",
                    style: TextStyle(
                      color: isDark ? Colors.white : Color(0xFFC9CACC),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 6.h),

              // Alternative UPI linking option
              Center(
                child: TextButton(
                  onPressed: () {
                    navi(linkWithUpiScreen(),
                        context); // Navigate to UPI linking screen
                  },
                  child: Text(
                    "Link bank account using UPI",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Push content to top
              const Spacer(),
            ],
          ),
        ),
      ),

      // Bottom navigation area with continue button and help option
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Continue button - enabled only when form is complete
            constWidgets.greenButton(
              "Continue",
              onTap: _isButtonDisabled
                  ? null
                  : () {
                      navi(confirmBankDetails(),
                          context); // Navigate to confirmation screen
                    },
              isDisabled: _isButtonDisabled,
            ),
            SizedBox(height: 10.h),

            // Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Builds a selectable account type choice chip
  /// @param value The account type option text ("Savings" or "Current")
  /// @param isDark Whether the app is in dark mode
  /// @return A tappable choice chip widget
  Widget _buildSelectableChip(String value, bool isDark) {
    bool isSelected = selectedAccountType == value;
    return InkWell(
      onTap: () => _selectAccountType(value),
      child: constWidgets.choiceChip(value, isSelected, context, 100.w, isDark),
    );
  }
}

/// Custom TextInputFormatter to force uppercase input
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Custom TextInputFormatter to enforce IFSC format (4 letters + 7 digits)
class IfscInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    if (newText.length > 11) {
      return oldValue; // Limit to 11 characters
    }

    // Check first 4 characters (letters only)
    if (newText.length <= 4) {
      if (!RegExp(r'^[A-Za-z]*$').hasMatch(newText)) {
        return oldValue; // Allow only letters
      }
    }
    // Check last 7 characters (digits only)
    else if (newText.length > 4) {
      final prefix = newText.substring(0, 4);
      final suffix = newText.substring(4);
      if (!RegExp(r'^[A-Za-z]{4}$').hasMatch(prefix) ||
          !RegExp(r'^\d*$').hasMatch(suffix)) {
        return oldValue; // Enforce 4 letters + digits
      }
    }

    return newValue;
  }
}
