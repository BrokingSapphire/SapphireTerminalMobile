// File: familyDetailsScreen.dart
// Description: Family details collection screen in the Sapphire Trading application.
// This screen collects parent information and marital status as part of the KYC process.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/signUp/personalDetails.dart'; // Next screen in registration flow
import '../../main.dart'; // App-wide navigation utilities
import '../../utils/constWidgets.dart'; // Reusable UI components

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
  // Form input controllers
  TextEditingController fathersName = TextEditingController();
  TextEditingController mothersName = TextEditingController();

  // UI state variables
  bool _isGray = true; // Controls button enabled/disabled state
  double width = 0; // Width for choice chips, set during build

  // Form data
  String? selectedMaritalStatus = "Single"; // Default selection

  // Secure storage for authentication tokens
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  /// Computed property to check if all required fields are filled
  /// Used to determine if the form is ready for submission
  bool get isFormComplete =>
      fathersName.text.trim().isNotEmpty &&
          mothersName.text.trim().isNotEmpty &&
          selectedMaritalStatus != null;

  @override
  void initState() {
    super.initState();
    // Add listeners to input controllers to check form completeness on changes
    fathersName.addListener(_checkFields);
    mothersName.addListener(_checkFields);
  }

  /// Checks if required fields are filled and updates button state
  void _checkFields() {
    setState(() {
      // Button is gray (disabled) if either name field is empty
      _isGray =
          fathersName.text.trim().isEmpty || mothersName.text.trim().isEmpty;
    });
  }

  /// Submits family details to the backend API
  /// Sends parent names and marital status to the server
  Future<void> submitFamilyDetails() async {
    // Retrieve auth token from secure storage
    final token = await secureStorage.read(key: 'auth_token');

    // API endpoint for submitting family details
    final uri = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request payload
    final body = {
      "step": "user_detail",
      "marital_status": selectedMaritalStatus,
      "father_name": fathersName.text.trim(),
      "mother_name": mothersName.text.trim(),
    };

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          Center(child: CircularProgressIndicator(color: Color(0xFF1DB954))),
    );

    try {
      // Send API request
      final response = await http.post(
        uri,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(body),
      );

      // Dismiss loading indicator
      Navigator.of(context).pop();

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        constWidgets.snackbar("Family details saved", Colors.green, context);
        navi(PersonalDetails(), context); // Navigate to next screen
      } else {
        // Error case - extract error message from response if available
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Something went wrong!";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Handle exceptions during API call
      Navigator.of(context).pop(); // Dismiss loading indicator
      constWidgets.snackbar("Error submitting data: $e", Colors.red, context);
    }
  }

  @override
  void dispose() {
    // Clean up resources when screen is removed
    fathersName.removeListener(_checkFields);
    mothersName.removeListener(_checkFields);
    fathersName.dispose();
    mothersName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Detect if the app is running in dark mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Calculate chip width based on screen size (for marital status selection)
    width = MediaQuery.of(context).size.width / 3 - 20;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: GestureDetector(
        // Dismiss keyboard when tapping outside input fields
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // Progress indicator showing current step (1 of 4)
              constWidgets.topProgressBar(1, 4, context),
              SizedBox(height: 24.h),

              // Screen title
              Text("Enter your parent's name",
                  style:
                  TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 16.h),

              // Father's name input field
              constWidgets.textField("Father's Name", fathersName,
                  isDark: isDark),
              SizedBox(height: 16.h),

              // Mother's name input field
              constWidgets.textField("Mother's Name", mothersName,
                  isDark: isDark),
              SizedBox(height: 20.h),

              // Marital status selection section (commented out in original code)
              // Text("Marital Status",
              //     style:
              //         TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500)),
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

      // Bottom action area with continue button and help option
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
                // Button is enabled only when required fields are filled
                onPressed: _isGray ? null : () => submitFamilyDetails(),
                child: Text("Continue",
                    style: TextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w600)),
                // Button style changes based on enabled/disabled state
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _isGray ? Color(0xff2f2f2f) : Color(0xFF1DB954), // Green when enabled, gray when disabled
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Color(0xff2f2f2f),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Help button
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Creates a selectable chip for marital status options
  /// @param value The text value for the chip
  /// @param isDark Whether the app is in dark mode
  /// @return A tappable chip widget with appropriate styling
  Widget _buildSelectableChip(String value, bool isDark) {
    final isSelected = selectedMaritalStatus == value;
    return InkWell(
      onTap: () => setState(() => selectedMaritalStatus = value),
      child: constWidgets.choiceChip(value, isSelected, context, width, isDark),
    );
  }
}