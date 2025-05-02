// File: nomineeDetails.dart
// Description: Nominee information collection screen in the Sapphire Trading application.
// This screen allows users to add, edit and allocate percentage shares to nominees for their
// trading account as per SEBI regulations for securities inheritance.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import '../finalStep/eSign.dart'; // Next screen in registration flow

/// NomineeDetailsScreen - Screen for adding account nominees and their share percentages
/// Allows users to add multiple nominees and specify inheritance distribution percentages
class NomineeDetailsScreen extends StatefulWidget {
  @override
  _NomineeDetailsScreenState createState() => _NomineeDetailsScreenState();
}

/// State class for the NomineeDetailsScreen widget
/// Manages nominee details, share allocation, and submission to backend
class _NomineeDetailsScreenState extends State<NomineeDetailsScreen> {
  // List to store nominees with their details
  List<Map<String, dynamic>> nominees = [
    {
      "nameController": TextEditingController(), // For nominee name
      "panController": TextEditingController(), // For nominee PAN
      "relation": null, // Relationship to account holder
      "share": 100.0, // Percentage share (default 100% for single nominee)
    }
  ];

  // List of available relationship options for nominees
  final List<String> relations = [
    "Father",
    "Mother",
    "Son",
    "Daughter",
    "Sister",
    "Brother",
    "Spouse",
    "Other"
  ];

  /// Adds a new nominee and recalculates percentage shares
  /// Divides shares equally among all nominees
  void _addNominee() {
    setState(() {
      int totalNominees = nominees.length + 1;
      double newShare = 100 / totalNominees; // Equal distribution

      // Update existing nominees' shares
      for (var nominee in nominees) {
        nominee["share"] = newShare;
      }

      // Add new nominee with equal share
      nominees.add({
        "nameController": TextEditingController(),
        "panController": TextEditingController(),
        "relation": null,
        "share": newShare,
      });
    });
  }

  /// Removes a nominee and redistributes their share to remaining nominees
  /// @param index Index of the nominee to remove
  void _deleteNominee(int index) {
    if (nominees.length > 1) {
      setState(() {
        // Get the share of the nominee being removed
        double removedShare = nominees[index]["share"];
        nominees.removeAt(index);

        // Redistribute the removed share among remaining nominees
        if (nominees.isNotEmpty) {
          double additionalShare = removedShare / nominees.length;
          for (var nominee in nominees) {
            nominee["share"] += additionalShare;
          }
        }
      });
    }
  }

  /// Adjusts share percentage for a specific nominee and recalculates others proportionally
  /// @param index Index of the nominee whose share is being adjusted
  /// @param newValue New share percentage value
  void _adjustShare(int index, double newValue) {
    setState(() {
      double totalShare = 100.0; // Total must always be 100%
      double remainingShare = totalShare - newValue;
      nominees[index]["share"] = newValue; // Set new value for selected nominee

      // Calculate sum of other nominees' current shares
      double sumOtherShares = 0;
      for (int i = 0; i < nominees.length; i++) {
        if (i != index) sumOtherShares += nominees[i]["share"];
      }

      // Redistribute remaining share proportionally among other nominees
      for (int i = 0; i < nominees.length; i++) {
        if (i != index) {
          double proportionalShare =
              (nominees[i]["share"] / sumOtherShares) * remainingShare;
          nominees[i]["share"] = proportionalShare;
        }
      }
    });
  }

  /// Shows a bottom sheet to select relationship for a nominee
  /// @param index Index of the nominee to set relationship for
  /// @param isDark Whether the app is in dark mode
  void _selectRelation(int index, bool isDark) {
    showModalBottomSheet(
      backgroundColor: isDark ? Colors.black : Colors.white,
      context: context,
      isScrollControlled: true,
      // Allow flexible sizing of bottom sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          height: 450.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bottom sheet title
              Text("Nominee is my",
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: isDark ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),

              // List of relationship options
              Expanded(
                child: ListView.separated(
                  itemCount: relations.length,
                  separatorBuilder: (context, i) => Divider(
                    height: 1.h,
                    color: isDark ? Color(0xff2f2f2f) : Color(0xffD1D5DB),
                  ),
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Set selected relation and close bottom sheet
                          nominees[index]["relation"] = relations[i];
                        });
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 15.h),
                        child: Text(relations[i],
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: isDark ? Colors.white : Colors.black)),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Submits nominee details to the backend API
  /// Collects all nominee information and sends to server
  Future<void> _submitNominees() async {
    // Retrieve authentication token from secure storage
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: 'auth_token');

    // Prepare nominee data for API submission
    final List<Map<String, dynamic>> nomineePayload = nominees.map((nominee) {
      return {
        "name": nominee["nameController"].text.trim(),
        "gov_id": nominee["panController"].text.trim(), // PAN as government ID
        "relation": nominee["relation"] ?? "",
        "share": nominee["share"].toInt() // Convert to integer percentage
      };
    }).toList();

    // Create complete request payload
    final body = {"step": "add_nominees", "nominees": nomineePayload};

    // API endpoint for nominee submission
    final url = Uri.parse(
      "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint",
    );

    // Debug log of request payload
    print("[DEBUG] Payload: ${jsonEncode(body)}");

    // Show loading indicator during API call
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
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

      // Debug logs for response
      print("[DEBUG] Status: ${response.statusCode}");
      print("[DEBUG] Body: ${response.body}");

      // Handle API response
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        constWidgets.snackbar(
            "Nominees added successfully!", Colors.green, context);
        navi(eSignScreen(), context); // Navigate to E-Sign screen
      } else {
        // Error case - extract error message from response if available
        final msg = jsonDecode(response.body)['error']?['message'] ??
            'Something went wrong.';
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      // Handle exceptions during API call
      Navigator.of(context).pop(); // Dismiss loading indicator
      print("[EXCEPTION] $e");
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Column(
        children: [
          // Header section with title and progress bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                // Progress indicator showing current step (1 of 8)
                constWidgets.topProgressBar(1, 8, context),
                SizedBox(height: 24.h),

                // Title row with skip option
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Nominee",
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold)),
                    // Skip button - allows bypassing nominee addition
                    GestureDetector(
                      onTap: () => navi(eSignScreen(), context),
                      child: Text("Skip",
                          style:
                              TextStyle(color: Colors.green, fontSize: 16.sp)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable list of nominee cards
          Expanded(
            child: ListView.builder(
              itemCount: nominees.length,
              itemBuilder: (context, index) {
                return _buildNomineeCard(index, isDark);
              },
            ),
          ),

          // Add nominee button at bottom of list
          _buildAddNomineeButton(isDark),
          SizedBox(height: 20.h),
        ],
      ),

      // Bottom navigation area with continue button and help option
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Continue button - submits nominee details
            constWidgets.greenButton("Continue",
                //  onTap: _submitNominees,
                onTap: () {
              navi(eSignScreen(), context);
            }),
            SizedBox(height: 10.h),
            // Help button
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Builds a nominee card with input fields and share slider
  /// @param index Index of the nominee in the list
  /// @param isDark Whether the app is in dark mode
  /// @return A container widget with all nominee details inputs
  Widget _buildNomineeCard(int index, bool isDark) {
    return Container(
      // margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          // Header with nominee number and delete button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Nominee ${index + 1}",
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 17.sp)),
              // Show delete button only if there's more than one nominee
              if (nominees.length > 1)
                IconButton(
                  icon:
                      Icon(Icons.close, color: Color(0xFF1DB954), size: 22.sp),
                  onPressed: () => _deleteNominee(index),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Nominee name input field
          constWidgets.textField("Name", nominees[index]["nameController"],
              isDark: isDark),
          SizedBox(height: 12.h),

          // Nominee PAN input field
          constWidgets.textField(
              "Nominee PAN", nominees[index]["panController"],
              isDark: isDark),
          SizedBox(height: 12.h),

          // Relationship selector dropdown
          GestureDetector(
            onTap: () => _selectRelation(index, isDark),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                    color: isDark ? Colors.grey.shade700 : Color(0xff6B7280)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nominees[index]["relation"] ??
                        "Relation", // Show selected relation or placeholder
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 16.sp),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: isDark ? Colors.white : Colors.black),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Share percentage display and adjustment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("% Share",
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
              // Display current share percentage in badge
              Container(
                width: 40.w,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text("${nominees[index]["share"].toInt()}%",
                      // Integer percentage
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 14.sp)),
                ),
              ),
            ],
          ),
          // Slider for adjusting nominee's share percentage
          _buildShareSlider(index, isDark),
          SizedBox(height: 24.h),
          Divider(
              color: isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade300), // Separator between nominees
        ],
      ),
    );
  }

  /// Builds a slider for adjusting nominee's share percentage
  /// @param index Index of the nominee to adjust share for
  /// @param isDark Whether the app is in dark mode
  /// @return A slider widget with appropriate styling and behavior
  Widget _buildShareSlider(int index, bool isDark) {
    return Slider(
      value: nominees[index]["share"],
      min: 0,
      max: 100,
      activeColor: Colors.green,
      inactiveColor: isDark ? Colors.white : Colors.grey.shade300,
      onChanged: (value) => _adjustShare(index, value),
    );
  }

  /// Builds the add nominee button
  /// @param isDark Whether the app is in dark mode
  /// @return A gesture detector with icon and text for adding nominees
  Widget _buildAddNomineeButton(bool isDark) {
    return GestureDetector(
      onTap: _addNominee,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add,
              color: isDark ? Colors.white : Colors.black, size: 20.sp),
          SizedBox(width: 5.w),
          Text("Add Nominee",
              style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16.sp)),
        ],
      ),
    );
  }
}
