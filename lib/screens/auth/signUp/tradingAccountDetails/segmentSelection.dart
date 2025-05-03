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
class SegmentSelectionScreen extends StatefulWidget {
  const SegmentSelectionScreen({super.key});

  @override
  State<SegmentSelectionScreen> createState() => _SegmentSelectionScreenState();
}

/// State class for the SegmentSelectionScreen widget
/// Manages segment selection state and API submission
class _SegmentSelectionScreenState extends State<SegmentSelectionScreen> {
  Set<String> selectedSegments = {};
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

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
    selectedSegments.add("Cash/Mutual Funds");
  }

  void _toggleSegment(String segment) {
    setState(() {
      if (selectedSegments.contains(segment)) {
        selectedSegments.remove(segment);
      } else {
        selectedSegments.add(segment);
      }
    });
  }

  Future<void> submitSelectedSegments() async {
    // final token = await secureStorage.read(key: 'auth_token');
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhpbWFuc2h1c2Fyb2RlMDhAZ21haWwuY29tIiwicGhvbmUiOiI4NDMyMzA0MDIzIiwiaWF0IjoxNzQzNDk5ODIyLCJleHAiOjE3NDM1ODYyMjJ9.CJNPPnQCA80dDSmQY8cE7mnO9cUGnuV5Rxq6lyroYSA";
    print(token);

    final List<String> segmentsForApi =
        selectedSegments.map((label) => segmentApiMap[label] ?? label).toList();

    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    final body = {
      "step": "investment_segment",
      "segments": segmentsForApi,
    };

    print("📤 Payload: ${jsonEncode(body)}");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      final response = await http.post(
        url,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      Navigator.of(context).pop();
      print("📨 API Status: ${response.statusCode}");
      print("📨 API Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar(
            "Investment segment saved", Colors.green, context);
        navi(FamilyDetailsScreen(), context);
      } else {
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Failed to submit segments";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.pop(context);
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
            constWidgets.topProgressBar(1, 3, context),
            SizedBox(height: 24.h),
            Text(
              "Choose Your Investment Segment",
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Cash/Mutual Funds"),
                    _buildSelectableChip("F&O"),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSelectableChip("Debt"),
                    _buildSelectableChip("Currency"),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildSelectableChip("Commodity Derivatives"),
              ],
            ),
            Spacer(),
            constWidgets.greenButton("Continue",
                // onTap: selectedSegments.isEmpty
                //     ? null
                //     : () {
                //         submitSelectedSegments();
                //       },
                onTap: () {
              navi(FamilyDetailsScreen(), context);
            }),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

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
