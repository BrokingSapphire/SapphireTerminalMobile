// File: familyDetails.dart
// Description: Family information collection screen for the Sapphire Trading application.
// This screen gathers parental information and marital status as part of the KYC process
// required for SEBI compliance when opening a trading account.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/personalDetails.dart'; // Next screen in registration flow
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// FamilyDetailsScreen - Screen for collecting family information
/// Gathers parent names and marital status for KYC compliance
class FamilyDetailsScreen extends StatefulWidget {
  const FamilyDetailsScreen({super.key});

  @override
  State<FamilyDetailsScreen> createState() => _FamilyDetailsScreenState();
}

/// State class for the FamilyDetailsScreen widget
/// Manages form inputs, validation, API submission, and UI rendering
class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  TextEditingController fathersName = TextEditingController(); // Controls father's name input
  TextEditingController mothersName = TextEditingController(); // Controls mother's name input
  bool _isGray = true; // Controls button enabled/disabled state based on form completion
  double width = 0; // Width for choice chips, calculated dynamically during build
  String? selectedMaritalStatus = "Single"; // Default marital status selection
  final FlutterSecureStorage secureStorage = FlutterSecureStorage(); // For storing auth token securely

  /// Computed property to check if all required fields are filled
  /// Used to determine if form is ready for submission
  bool get isFormComplete =>
      fathersName.text.trim().isNotEmpty &&
          mothersName.text.trim().isNotEmpty &&
          selectedMaritalStatus != null;

  @override
  void initState() {
    super.initState();
    // Add listeners to input controllers to check form completeness when text changes
    fathersName.addListener(_checkFields);
    mothersName.addListener(_checkFields);
  }

  /// Updates button state based on form field values
  /// Called when text input changes in either name field
  void _checkFields() {
    setState(() {
      _isGray =
          fathersName.text.trim().isEmpty || mothersName.text.trim().isEmpty; // Gray out button if either field is empty
    });
  }

  /// Submits family details to the backend API
  /// Shows loading dialog during submission and handles response
  Future<void> submitFamilyDetails() async {
    // Retrieve authentication token from secure storage
    final token = await secureStorage.read(key: 'auth_token');
    final uri = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request body with family details
    final body = {
      "step": "user_detail", // Identifies which signup step this data belongs to
      "marital_status": selectedMaritalStatus,
      "father_name": fathersName.text.trim(),
      "mother_name": mothersName.text.trim(),
    };

    // Show loading indicator during API call
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal while loading
      builder: (_) =>
          Center(child: CircularProgressIndicator(color: Color(0xFF1DB954))),
    );

    try {
      // Send POST request to API with family details
      final response = await http.post(
        uri,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(body),
      );

      // Dismiss loading dialog
      Navigator.of(context).pop();

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case: show confirmation and navigate to next screen
        constWidgets.snackbar("Family details saved", Colors.green, context);
        navi(PersonalDetails(), context);
      } else {
        // Error case: extract error message from response if available
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Something went wrong!";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Exception handling for network or other errors
      Navigator.of(context).pop();
      constWidgets.snackbar("Error submitting data: $e", Colors.red, context);
    }
  }

  @override
  void dispose() {
    // Clean up resources when widget is removed
    fathersName.removeListener(_checkFields);
    mothersName.removeListener(_checkFields);
    fathersName.dispose();
    mothersName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if dark mode is enabled for theming
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    // Calculate width for marital status choice chips
    width = MediaQuery.of(context).size.width / 3 - 20;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      // Main body with gesture detection to dismiss keyboard on tap outside
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // Progress bar showing step 1 of 4 in the process
              constWidgets.topProgressBar(1, 4, context),
              SizedBox(height: 24.h),
              // Screen title
              Text(
                "Enter your parent's name",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              // Father's name input field
              constWidgets.textField("Father's Name", fathersName,
                  isDark: isDark),
              SizedBox(height: 16.h),
              // Mother's name input field
              constWidgets.textField("Mother's Name", mothersName,
                  isDark: isDark),
              SizedBox(height: 20.h),
              // Marital status selection section (currently commented out)
              // TODO: Uncomment and implement marital status selection UI when required
              // Text(
              //   "Marital Status",
              //   style: TextStyle(
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.w500,
              //     color: isDark ? Colors.white : Colors.black,
              //   ),
              // ),
              // SizedBox(height: 12.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildSelectableChip("Single", isDark),
              //     _buildSelectableChip("Married", isDark),
              //     _buildSelectableChip("Divorced", isDark),
              //   ],
              // ),
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
            // Continue button - conditionally styled based on form completion
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // Original API submission implementation (currently commented out)
                // onPressed: _isGray ? null : () => submitFamilyDetails(),

                // Temporary simplified implementation for testing/demo
                // TODO: Restore original implementation with API submission when ready
                onPressed: () => navi(PersonalDetails(), context),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  (_isGray) ? Colors.grey[400] : Color(0xFF1DB954), // Gray when form incomplete, green when complete
                  foregroundColor: Colors.white,
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

// Note: The _buildSelectableChip method implementation is missing from the provided code
// This would typically be implemented to create the selectable marital status chips
/*
  /// Creates a selectable chip widget for marital status selection
  /// Handles selection state and appearance changes
  Widget _buildSelectableChip(String label, bool isDark) {
    final isSelected = selectedMaritalStatus == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMaritalStatus = label;
        });
      },
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected 
              ? Color(0xFF1DB954) 
              : isDark ? Color(0xff212221) : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected 
                  ? Colors.white 
                  : isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
  */
}