// File: segmentSelection.dart
// Description: Investment segment selection screen in the Sapphire Trading application.
// This screen is part of the KYC flow and allows users to select which market segments they want to trade in.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/familyDetails.dart'; // Next screen in registration flow
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// SegmentSelectionScreen - Screen for selecting market segments for trading
/// Allows users to choose which financial markets they want to access (equities, F&O, etc.)
/// as part of the trading account setup process
class SegmentSelectionScreen extends StatefulWidget {
  const SegmentSelectionScreen({super.key});

  @override
  State<SegmentSelectionScreen> createState() => _SegmentSelectionScreenState();
}

/// State class for the SegmentSelectionScreen widget
/// Manages segment selection state and API submission
class _SegmentSelectionScreenState extends State<SegmentSelectionScreen> {
  // Set to track which segments the user has selected
  Set<String> selectedSegments = {};
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Mapping between UI display names and API parameter values
  final Map<String, String> segmentApiMap = {
    "Cash/Mutual Funds": "Cash",
    "F&O": "F&O",
    "Debt": "Debt",
    "Currency": "Currency",
    "Commodity Derivatives": "Commodity",
  };

  @override
  void initState() {
    super.initState();
    // Default selection - Cash/Mutual Funds is pre-selected for all users
    selectedSegments.add("Cash/Mutual Funds");
  }

  /// Toggles selection state of a segment
  /// Adds segment if not selected, removes if already selected
  void _toggleSegment(String segment) {
    setState(() {
      if (selectedSegments.contains(segment)) {
        selectedSegments.remove(segment);
      } else {
        selectedSegments.add(segment);
      }
    });
  }

  /// Submits the user's selected segments to the backend API
  /// Saves the selections and navigates to the next screen on success
  Future<void> submitSelectedSegments() async {
    // Get authentication token from secure storage
    // final token = await secureStorage.read(key: 'auth_token');

    // TODO: Remove hardcoded token before production
    // Temporary token for development/testing
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhpbWFuc2h1c2Fyb2RlMDhAZ21haWwuY29tIiwicGhvbmUiOiI4NDMyMzA0MDIzIiwiaWF0IjoxNzQzNDk5ODIyLCJleHAiOjE3NDM1ODYyMjJ9.CJNPPnQCA80dDSmQY8cE7mnO9cUGnuV5Rxq6lyroYSA";
    print(token);

    // Convert UI segment names to API-expected values using the mapping
    final List<String> segmentsForApi =
    selectedSegments.map((label) => segmentApiMap[label] ?? label).toList();

    // API endpoint for saving segment selection data
    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request body with step identifier and selected segments
    final body = {
      "step": "investment_segment",
      "segments": segmentsForApi,
    };

    print("📤 Payload: ${jsonEncode(body)}");

    // Show loading indicator while API request is in progress
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      // Send POST request to backend API
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      // Hide loading indicator
      Navigator.of(context).pop();
      print("📨 API Status: ${response.statusCode}");
      print("📨 API Response: ${response.body}");

      // Handle API response based on status code
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success: Show confirmation message and navigate to next screen
        constWidgets.snackbar(
            "Investment segment saved", Colors.green, context);
        navi(FamilyDetailsScreen(), context);
      } else {
        // Error: Extract error message from response if available
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Failed to submit segments";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Handle network or other exceptions
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if dark mode is enabled for theming
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
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
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.h),
            // Progress indicator showing user is on step 1 of 3 in this flow
            constWidgets.topProgressBar(1, 3, context),
            SizedBox(height: 24.h),
            // Main screen title
            Text(
              "Choose Your Investment Segment",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            // Grid layout for segment selection chips
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First row of segment options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Cash/Mutual Funds"),
                    _buildSelectableChip("F&O"),
                  ],
                ),
                SizedBox(height: 20.h),
                // Second row of segment options
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Debt"),
                    _buildSelectableChip("Currency"),
                  ],
                ),
                SizedBox(height: 20.h),
                // Third row with single segment option
                _buildSelectableChip("Commodity Derivatives"),
              ],
            ),
            Spacer(), // Pushes action buttons to bottom of screen
            // Primary action button to continue to next step
            constWidgets.greenButton("Continue",
                // Original validation logic (commented out)
                // onTap: selectedSegments.isEmpty
                //     ? null
                //     : () {
                //         submitSelectedSegments();
                //       },

                // Current implementation: direct navigation without API call
                onTap: () {
                  navi(FamilyDetailsScreen(), context);
                }),
            SizedBox(height: 10.h),
            // Help button for users who need assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Creates a selectable chip widget for a segment option
  /// Includes visual indication of selection state and handles tap interactions
  Widget _buildSelectableChip(String segment) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: () => _toggleSegment(segment),
      child: constWidgets.segmentChoiceChipiWithCheckbox(
        segment,
        selectedSegments.contains(segment),
        context,
        isDark, // Pass isDark to support theme-aware chip styling
      ),
    );
  }
}