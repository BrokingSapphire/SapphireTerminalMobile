// File: manualLinkingScreen.dart
// Description: Manual bank account linking screen in the Sapphire Trading application.
// This screen allows users to manually enter their bank account details (IFSC code,
// account number, and account type) as an alternative to UPI-based linking.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/signUp/confirmBankDetails.dart'; // Next screen after successful linking
import 'package:sapphire/screens/signUp/linkWithUpiScreen.dart'; // Alternative UPI linking screen
import '../../main.dart'; // App-wide navigation utilities
import '../../utils/constWidgets.dart'; // Reusable UI components

/// ManualLinkingScreen - Screen for manually entering bank account details
/// Provides fields for IFSC code, account number, and account type selection
class ManualLinkingScreen extends StatefulWidget {
  @override
  _ManualLinkingScreenState createState() => _ManualLinkingScreenState();
}

/// State class for the ManualLinkingScreen widget
/// Manages form input, validation, and API submission
class _ManualLinkingScreenState extends State<ManualLinkingScreen> {
  // Text controllers for input fields
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  // Selection state for account type
  String? selectedAccountType;

  // Flag to track if form is complete for button enabling
  bool _isButtonDisabled = true;

  // Secure storage for authentication token
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

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

  /// Submits bank account details to the backend API
  /// Sends IFSC, account number, and account type for verification
  Future<void> submitBankDetails() async {
    // Debug logging
    print("[INFO] Submit button pressed");

    // Retrieve authentication token from secure storage
    final token = await secureStorage.read(key: 'auth_token');
    print("[INFO] Retrieved token: $token");

    // API endpoint for bank details submission
    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request payload
    final body = {
      "step": "bank_validation",
      "validation_type": "bank",
      "bank": {
        "account_number": accountNumberController.text.trim(),
        "ifsc_code": ifscController.text.trim(),
      },
    };

    // Debug log the request body
    print("[INFO] Request body: ${jsonEncode(body)}");

    // Show loading indicator during API call
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      // Send API request
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      // Dismiss loading indicator
      Navigator.of(context).pop();

      // Debug log API response
      print("[INFO] Response status: ${response.statusCode}");
      print("[INFO] Response body: ${response.body}");

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        constWidgets.snackbar(
            "Bank linked successfully!", Colors.green, context);
        navi(confirmBankDetails(), context); // Navigate to confirmation screen
      } else {
        // Error case - extract error message if available
        final msg = jsonDecode(response.body)['error']?['message'] ??
            'Something went wrong.';
        print("[ERROR] API Error Message: $msg");
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Handle exceptions during API call
      Navigator.of(context).pop();
      print("[EXCEPTION] $e");
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  void dispose() {
    // Clean up resources when screen is removed
    ifscController.removeListener(_checkFields);
    accountNumberController.removeListener(_checkFields);
    ifscController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),

              // Instruction text
              Text(
                "Make sure that you are linking a bank account that is in your name.",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),

              // IFSC code input field
              constWidgets.textField("IFSC Code", ifscController,
                  isDark: isDark),
              SizedBox(height: 12.h),

              // Account number input field
              constWidgets.textField('Account Number', accountNumberController,
                  isDark: isDark),
              SizedBox(height: 18.h),

              // Account type selection section
              Text(
                "Account Type",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
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
                    style: TextStyle(color: Color(0xFFC9CACC)),
                  ),
                  Expanded(child: Divider())
                ],
              ),
              SizedBox(height: 6.h),

              // Alternative UPI linking option
              Center(
                child: TextButton(
                  onPressed: () {
                    navi(linkWithUpiScreen(), context); // Navigate to UPI linking screen
                  },
                  child: Text(
                    "Link bank account using UPI",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Push content to top
              Spacer(),
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
            // Continue button - conditionally enabled based on form completeness
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isButtonDisabled ? null : submitBankDetails,
                child: Text(
                  "Continue",
                  style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _isButtonDisabled ? Color(0xff2f2f2f) : Color(0xFF1DB954), // Gray when disabled, green when enabled
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Color(0xff2f2f2f),
                ),
              ),
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