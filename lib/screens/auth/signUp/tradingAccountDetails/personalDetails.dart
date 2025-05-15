// File: personalDetails.dart
// Description: Personal details collection screen in the Sapphire Trading application.
// This screen collects key user information such as marital status, annual income,
// trading experience, and settlement preferences required for KYC compliance.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/otherDetails.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// PersonalDetails - Screen for collecting user's personal information
/// Gathers information like marital status, income range, and trading experience
class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

/// State class for the PersonalDetails widget
/// Manages user selections and API submission
class _PersonalDetailsState extends State<PersonalDetails> {
  // UI layout variables
  double width = 0; // Width for choice chips, calculated at build time

  // Selection state variables
  String? selectedOccupation;
  bool isPoliticallyExposed = false;
  String? selectedMaritalStatus = "Single"; // Default selection

  // Secure storage for authentication token
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  /// Computed property to check if required fields are filled
  /// Currently only checks occupation, but could be expanded
  bool get isFormComplete => selectedOccupation != null;

  /// Updates the selected occupation
  /// @param value The selected occupation
  // void _selectOccupation(String value) {
  //   setState(() => selectedOccupation = value);
  // }

  /// Submits occupation and politically exposed status to the backend API
  /// Note: Despite screen collecting more data, only these fields are sent
  Future<void> submitOccupationDetails() async {
    // Retrieve authentication token from secure storage
    final token = await secureStorage.read(key: 'auth_token');
    if (token == null) {
      constWidgets.snackbar("Token not found", Colors.red, context);
      return;
    }

    // API endpoint for submitting occupation details
    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request payload
    final body = {
      "step": "occupation",
      "occupation": selectedOccupation,
      "politically_exposed": isPoliticallyExposed
    };

    // Show loading indicator during API call
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
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

      // Debug logging
      print("🔁 Response Status: ${response.statusCode}");
      print("📨 Response Body: ${response.body}");

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        constWidgets.snackbar(
            "Occupation details saved", Colors.green, context);
        navi(Otherdetails(), context); // Navigate to other details screen
      } else {
        // Error case - extract error message if available
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Something went wrong";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Handle exceptions during API call
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detect if app is in dark mode
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Calculate width for choice chips based on screen size
    width = MediaQuery.of(context).size.width / 3 - 20;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(), // Smooth scrolling behavior
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // Progress indicator showing current step (1 of 4)
              constWidgets.topProgressBar(1, 4, context),
              SizedBox(height: 24.h),

              // Screen title
              Text("Personal Details",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 24.h,
              ),

              /// Marital status selection section
              Text("Marital Status",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSelectableChip("Single", isDark),
                  _buildSelectableChip("Married", isDark),
                  _buildSelectableChip("Divorced", isDark),
                ],
              ),
              SizedBox(height: 24.h),

              // Occupation section (commented out in original code)
              // Text("Occupation",
              //     style:
              //         TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
              // SizedBox(height: 16.h),
              // Wrap(
              //   spacing: 12,
              //   runSpacing: 12,
              //   children: [
              //     "Student",
              //     "Govt. Servant",
              //     "Retired",
              //     "Private Sector",
              //     "Agriculturist",
              //     "Self Employed",
              //     "Housewife",
              //     "Other"
              //   ]
              //       .map((item) => InkWell(
              //             onTap: () => _selectOccupation(item),
              //             child: constWidgets.choiceChip(
              //                 item,
              //                 selectedOccupation == item,
              //                 context,
              //                 width,
              //                 isDark),
              //           ))
              //       .toList(),
              // ),

              /// Annual income selection section
              Text(
                "Annual Income",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSelectableChip("<1 Lakh", isDark),
                  _buildSelectableChip("1 Lakh - 5 Lakh", isDark),
                  _buildSelectableChip("5 Lakh - 10 Lakh", isDark),
                  _buildSelectableChip("10 Lakh - 25 Lakh", isDark),
                  _buildSelectableChip("25 Lakh - 1 Crore", isDark),
                  _buildSelectableChip("> 1 Crore", isDark),
                ],
              ),
              SizedBox(height: 24.h),

              /// Trading experience selection section
              Text(
                "Trading Experience",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSelectableChip("No experience", isDark),
                  _buildSelectableChip("< 1 year", isDark),
                  _buildSelectableChip("1-5 years", isDark),
                  _buildSelectableChip("5-10 years", isDark),
                  _buildSelectableChip("10+ years", isDark),
                ],
              ),
              SizedBox(height: 24.h),

              /// Account settlement preference section
              Text(
                "Preference for running account settlement",
                style: TextStyle(
                    fontSize: 17.sp,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSelectableChip("Quarterly", isDark),
                  SizedBox(width: 12.w),
                  _buildSelectableChip("Monthly", isDark),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation area with continue button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Continue button - conditionally enabled based on form completion
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: isFormComplete ? submitOccupationDetails : null,
                onPressed: () {
                  navi(Otherdetails(),
                      context); // Navigate to other details screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isFormComplete ? Color(0xFF1DB954) : Color(0xff2f2f2f),
                  // Green if form complete, gray if not
                  foregroundColor: Colors.white,
                ),
                child: Text("Continue",
                    style: TextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.w600)),
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

  /// Builds a selectable choice chip for options
  /// Note: This method currently only handles maritalStatus but is used for all selections
  /// @param value The display value for the chip
  /// @param isDark Whether the app is in dark mode
  /// @return A tappable choice chip widget
  Widget _buildSelectableChip(String value, bool isDark) {
    final isSelected = selectedMaritalStatus == value;
    return InkWell(
      onTap: () => setState(() => selectedMaritalStatus = value),
      child: constWidgets.choiceChip(value, isSelected, context, width, isDark),
    );
  }
}
