// File: personalDetails.dart
// Description: Personal details collection screen in the Sapphire Trading application.
// This screen collects key user information such as marital status, annual income,
// trading experience, and settlement preferences required for KYC compliance.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/otherDetails.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// PersonalDetails - Screen for collecting user's personal information
/// Gathers information like marital status, income range, trading experience, and settlement preferences
class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

/// State class for the PersonalDetails widget
/// Manages user selections and navigation
class _PersonalDetailsState extends State<PersonalDetails> {
  // UI layout variables
  double width = 0; // Width for choice chips, calculated at build time

  // Selection state variables for each section
  String? selectedMaritalStatus = "Single"; // Default selection
  String? selectedAnnualIncome;
  String? selectedTradingExperience;
  String? selectedSettlementPreference;

  /// Computed property to check if all required fields are filled
  bool get isFormComplete =>
      selectedMaritalStatus != null &&
      selectedAnnualIncome != null &&
      selectedTradingExperience != null &&
      selectedSettlementPreference != null;

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
              Text(
                "Personal Details",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24.h),

              /// Marital status selection section
              Text(
                "Marital Status",
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSelectableChip("Single", isDark, section: "marital"),
                  _buildSelectableChip("Married", isDark, section: "marital"),
                  _buildSelectableChip("Divorced", isDark, section: "marital"),
                ],
              ),
              SizedBox(height: 24.h),

              /// Annual income selection section
              Text(
                "Annual Income",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSelectableChip("<1 Lakh", isDark, section: "income"),
                  _buildSelectableChip("1 Lakh - 5 Lakh", isDark, section: "income"),
                  _buildSelectableChip("5 Lakh - 10 Lakh", isDark, section: "income"),
                  _buildSelectableChip("10 Lakh - 25 Lakh", isDark, section: "income"),
                  _buildSelectableChip("25 Lakh - 1 Crore", isDark, section: "income"),
                  _buildSelectableChip("> 1 Crore", isDark, section: "income"),
                ],
              ),
              SizedBox(height: 24.h),

              /// Trading experience selection section
              Text(
                "Trading Experience",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _buildSelectableChip("No experience", isDark, section: "experience"),
                  _buildSelectableChip("< 1 year", isDark, section: "experience"),
                  _buildSelectableChip("1-5 years", isDark, section: "experience"),
                  _buildSelectableChip("5-10 years", isDark, section: "experience"),
                  _buildSelectableChip("10+ years", isDark, section: "experience"),
                ],
              ),
              SizedBox(height: 24.h),

              /// Account settlement preference section
              Text(
                "Preference for running account settlement",
                style: TextStyle(
                  fontSize: 17.sp,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSelectableChip("Quarterly", isDark, section: "settlement"),
                  SizedBox(width: 12.w),
                  _buildSelectableChip("Monthly", isDark, section: "settlement"),
                ],
              ),
              SizedBox(height: 24.h), // Add spacing at the bottom
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
            // Continue button - enabled only when all sections have a selection
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isFormComplete
                    ? () {
                        navi(OtherDetails(), context); // Navigate to other details screen
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormComplete ? Color(0xFF1DB954) : Color(0xff2f2f2f),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
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

  /// Builds a selectable choice chip for options
  /// Handles different sections (marital, income, experience, settlement)
  /// @param value The display value for the chip
  /// @param isDark Whether the app is in dark mode
  /// @param section The section this chip belongs to
  /// @return A tappable choice chip widget
  Widget _buildSelectableChip(String value, bool isDark, {required String section}) {
    bool isSelected;
    switch (section) {
      case "marital":
        isSelected = selectedMaritalStatus == value;
        break;
      case "income":
        isSelected = selectedAnnualIncome == value;
        break;
      case "experience":
        isSelected = selectedTradingExperience == value;
        break;
      case "settlement":
        isSelected = selectedSettlementPreference == value;
        break;
      default:
        isSelected = false;
    }

    return InkWell(
      onTap: () {
        setState(() {
          switch (section) {
            case "marital":
              selectedMaritalStatus = value;
              break;
            case "income":
              selectedAnnualIncome = value;
              break;
            case "experience":
              selectedTradingExperience = value;
              break;
            case "settlement":
              selectedSettlementPreference = value;
              break;
          }
        });
      },
      child: constWidgets.choiceChip(value, isSelected, context, width, isDark),
    );
  }
}