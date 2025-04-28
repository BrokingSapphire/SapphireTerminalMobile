// File: segmentSelectionScreen.dart
// Description: Investment segment selection screen in the Sapphire Trading application.
// This screen allows users to select which market segments they want to trade in,
// such as equities, futures & options, commodities, etc.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/signUp/familyDetailsScreen.dart'; // Next screen in registration flow
import '../../main.dart'; // App-wide navigation utilities
import '../../utils/constWidgets.dart'; // Reusable UI components

/// SegmentSelectionScreen - Screen for selecting market segments for trading
/// Allows users to choose which financial markets they want to access (equities, F&O, etc.)
class SegmentSelectionScreen extends StatefulWidget {
  const SegmentSelectionScreen({super.key});

  @override
  State<SegmentSelectionScreen> createState() => _SegmentSelectionScreenState();
}

/// State class for the SegmentSelectionScreen widget
/// Manages segment selection state and API submission
class _SegmentSelectionScreenState extends State<SegmentSelectionScreen> {
  // Set to store selected segment IDs
  Set<String> selectedSegments = {};

  // Secure storage for authentication token
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  /// Mapping from display names to API values for segments
  /// Translates user-friendly segment names to backend-expected values
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
    // Default selection - Cash/Mutual Funds is pre-selected
    selectedSegments.add("Cash/Mutual Funds");
  }

  /// Toggles selection state for a segment
  /// @param segment The segment to toggle selection for
  void _toggleSegment(String segment) {
    setState(() {
      if (selectedSegments.contains(segment)) {
        // If already selected, remove it
        selectedSegments.remove(segment);
      } else {
        // If not selected, add it
        selectedSegments.add(segment);
      }
    });
  }

  /// Submits selected segments to the backend API
  /// Translates display names to API values and sends the data
  Future<void> submitSelectedSegments() async {
    // Get authentication token from secure storage
    // Note: Currently using hardcoded token for testing
    // final token = await secureStorage.read(key: 'auth_token');
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhpbWFuc2h1c2Fyb2RlMDhAZ21haWwuY29tIiwicGhvbmUiOiI4NDMyMzA0MDIzIiwiaWF0IjoxNzQzNDk5ODIyLCJleHAiOjE3NDM1ODYyMjJ9.CJNPPnQCA80dDSmQY8cE7mnO9cUGnuV5Rxq6lyroYSA";
    print(token);

    // Convert selected segment display names to API values
    final List<String> segmentsForApi =
    selectedSegments.map((label) => segmentApiMap[label] ?? label).toList();

    // API endpoint for submitting segments
    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // Prepare request payload
    final body = {
      "step": "investment_segment",
      "segments": segmentsForApi,
    };

    // Debug log the request payload
    print("📤 Payload: ${jsonEncode(body)}");

    // Show loading indicator
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

      // Debug log the API response
      print("📨 API Status: ${response.statusCode}");
      print("📨 API Response: ${response.body}");

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        constWidgets.snackbar(
            "Investment segment saved", Colors.green, context);
        navi(FamilyDetailsScreen(), context); // Navigate to family details screen
      } else {
        // Error case - extract error message if available
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Failed to submit segments";
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.h),
            // Progress indicator showing current step (1 of 3)
            constWidgets.topProgressBar(1, 3, context),
            SizedBox(height: 24.h),

            // Screen title
            Text(
              "Choose Your Investment Segment",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),

            // Segment selection layout - organized in rows
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First row - Cash/Mutual Funds and F&O
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Cash/Mutual Funds"),
                    _buildSelectableChip("F&O"),
                  ],
                ),
                SizedBox(height: 20.h),

                // Second row - Debt and Currency
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Debt"),
                    _buildSelectableChip("Currency"),
                  ],
                ),
                SizedBox(height: 20.h),

                // Third row - Commodity Derivatives (single chip)
                _buildSelectableChip("Commodity Derivatives"),
              ],
            ),

            // Push buttons to bottom of screen
            Spacer(),

            // Continue button - conditionally enabled based on selections
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // Disabled if no segments selected
                onPressed: selectedSegments.isEmpty
                    ? null
                    : () {
                  submitSelectedSegments();
                },
                // Button style changes based on enabled/disabled state
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedSegments.isEmpty
                      ? Color(0xff2f2f2f) // Gray when disabled
                      : Color(0xFF1DB954), // Green when enabled
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Color(0xff2f2f2f),
                ),
                child: Text(
                  "Continue",
                  style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
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

  /// Builds a selectable segment choice chip with checkbox
  /// @param segment The segment name to display
  /// @return A tappable widget that shows selection state with a checkbox
  Widget _buildSelectableChip(String segment) {
    return InkWell(
      borderRadius: BorderRadius.circular(25.r),
      onTap: () => _toggleSegment(segment),
      child: constWidgets.segmentChoiceChipiWithCheckbox(
        segment,
        selectedSegments.contains(segment), // Pass current selection state
        context,
      ),
    );
  }
}