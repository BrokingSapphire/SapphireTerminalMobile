// File: otherDetails.dart
// Description: Other details collection screen in the Sapphire Trading application.
// This screen collects additional regulatory information including occupation, income range,
// and politically exposed person (PEP) status as required by SEBI and AML regulations.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/auth/signUp/bankDetails/linkBankAccount.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:sapphire/main.dart'; // App-wide navigation utilities

/// Otherdetails - Screen for collecting additional regulatory information
/// Gathers occupation, income level, and politically exposed person status data
/// Note: Class name should follow Dart conventions (OtherDetails)
class Otherdetails extends StatefulWidget {
  const Otherdetails({super.key});

  @override
  State<Otherdetails> createState() => _OtherdetailsScreenState();
}

/// State class for the Otherdetails widget
/// Manages user selections and API submission
class _OtherdetailsScreenState extends State<Otherdetails> {
  // Secure storage for authentication token
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Selection state variables
  String? selectedExperience;
  String? selectedIncome;
  String? selectedSettlement;
  String? selectedPEP;
  String? selectedOccupation;

  // Mapping of display income ranges to API values
  final Map<String, String> incomeMap = {
    "<1 Lakh": "le_1_Lakh",
    "1 Lakh - 5 Lakh": "1_5_Lakh",
    "5 Lakh - 10 Lakh": "5_10_Lakh",
    "10 Lakh - 25 Lakh": "10_25_Lakh",
    "25 Lakh - 1 Crore": "25_1_Cr",
    "> 1 Crore": "Ge_1_Cr",
  };

  /// Computed property to check if all required selections are made
  /// Used to enable/disable the continue button
  bool get isFormComplete =>
      selectedExperience != null &&
      selectedIncome != null &&
      selectedSettlement != null;

  /// Updates selection state for a given category
  /// @param category The field category being updated ('experience', 'income', 'settlement', or 'PEP')
  /// @param value The selected value for the category
  void _selectOption(String category, String value) {
    setState(() {
      if (category == "experience") {
        selectedExperience = value;
      } else if (category == "income") {
        selectedIncome = value;
      } else if (category == "settlement") {
        selectedSettlement = value;
      } else if (category == "PEP") {
        selectedPEP = value;
      }
    });
  }

  /// Submits the collected details to the backend API
  /// Sends occupation, income, and settlement preference to server
  Future<void> submitDetails() async {
    // Retrieve authentication token from secure storage
    final token = await secureStorage.read(key: 'auth_token');

    // API endpoint for submitting account details
    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request payload
    final body = {
      "step": "account_detail",
      "annual_income": incomeMap[selectedIncome] ??
          selectedIncome, // Map display value to API value
      "settlement": selectedSettlement,
    };

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

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        constWidgets.snackbar("Account details saved!", Colors.green, context);
        navi(linkBankScreen(), context); // Navigate to bank linking screen
      } else {
        // Error case - extract error message if available
        final msg = jsonDecode(response.body)['error']?['message'] ??
            'Failed to save details';
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Handle exceptions during API call
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  /// Updates the selected occupation
  /// @param value The selected occupation
  void _selectOccupation(String value) {
    setState(() => selectedOccupation = value);
  }

  @override
  Widget build(BuildContext context) {
    // Determine if app is in dark mode
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Widget _buildSelectableChip(String category, String value, double width) {
      bool isSelected =
          (category == "Settlement" && selectedSettlement == value) |
              (category == "PEP" && selectedPEP == value);

      return InkWell(
        onTap: () => _selectOption(category, value),
        child:
            constWidgets.choiceChip(value, isSelected, context, width, isDark),
      );
    }

    // Calculate width for choice chips based on screen size
    double chipWidth = MediaQuery.of(context).size.width / 3 - 20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            // Progress indicator showing current step (1 of 4)
            constWidgets.topProgressBar(1, 4, context),
            SizedBox(height: 24.h),

            // Screen title
            Text(
              "Other Details",
              style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black),
            ),
            SizedBox(height: 16.h),

            /// Occupation selection section
            Text("Occupation",
                style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black)),
            SizedBox(height: 16.h),

            // Wrap widget creates a flowing grid of occupation options
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                "Student",
                "Govt. Servant",
                "Retired",
                "Private Sector",
                "Agriculturist",
                "Self Employed",
                "Housewife",
                "Other"
              ]
                  .map((item) => InkWell(
                        onTap: () => _selectOccupation(item),
                        child: constWidgets.choiceChip(
                            item,
                            selectedOccupation == item,
                            context,
                            chipWidth,
                            isDark),
                      ))
                  .toList(),
            ),
            SizedBox(height: 24.h),

            /// Politically Exposed Person (PEP) section
            Text(
              "Are you a Politically Exposed Person (PEP)?",
              style: TextStyle(
                  fontSize: 17.sp, color: isDark ? Colors.white : Colors.black),
            ),
            SizedBox(height: 12.h),

            // Yes/No options for PEP status
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSelectableChip("PEP", "Yes", 106.w),
                SizedBox(width: 20.w),
                _buildSelectableChip("PEP", "No", 106.w),
              ],
            ),

            // Push buttons to bottom of screen
            const Spacer(),

            /// Continue Button
            // Original implementation with conditional onTap
            // constWidgets.greenButton(
            //   "Continue",
            //   onTap: isFormComplete ? submitDetails : null,
            // ),

            // Current implementation (note: missing onTap parameter)
            constWidgets.greenButton('Continue', onTap: () {
              navi(
                  linkBankScreen(), context); // Navigate to bank linking screen
            }),
            SizedBox(height: 10.h),

            /// Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }
}
