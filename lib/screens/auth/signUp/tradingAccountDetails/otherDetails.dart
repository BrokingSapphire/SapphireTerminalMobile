// File: otherDetails.dart
// Description: Other details collection screen in the Sapphire Trading application.
// This screen collects additional regulatory information including occupation
// and politically exposed person (PEP) status as required by SEBI and AML regulations.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/auth/signUp/bankDetails/linkBankAccount.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:sapphire/main.dart'; // App-wide navigation utilities

/// OtherDetails - Screen for collecting additional regulatory information
/// Gathers occupation and politically exposed person status data
class OtherDetails extends StatefulWidget {
  const OtherDetails({super.key});

  @override
  State<OtherDetails> createState() => _OtherDetailsState();
}

/// State class for the OtherDetails widget
/// Manages user selections and navigation
class _OtherDetailsState extends State<OtherDetails> {
  // Selection state variables
  String? selectedOccupation;
  String? selectedPEP;

  /// Computed property to check if all required selections are made
  /// Used to enable/disable the continue button
  bool get isFormComplete => selectedOccupation != null && selectedPEP != null;

  /// Updates the selected occupation
  /// @param value The selected occupation
  void _selectOccupation(String value) {
    setState(() => selectedOccupation = value);
  }

  @override
  Widget build(BuildContext context) {
    // Determine if app is in dark mode
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),

            /// Occupation selection section
            Text(
              "Occupation",
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16.h),

            // Wrap widget creates a flowing grid of occupation options
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                "Student",
                "Govt. Servant",
                "Retired",
                "Private Sector",
                "Agriculturist",
                "Self Employed",
                "Housewife",
                "Other",
              ]
                  .map(
                    (item) => InkWell(
                      onTap: () => _selectOccupation(item),
                      child: constWidgets.choiceChip(
                        item,
                        selectedOccupation == item,
                        context,
                        chipWidth,
                        isDark,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 24.h),

            /// Politically Exposed Person (PEP) section
            Text(
              "Are you a Politically Exposed Person (PEP)?",
              style: TextStyle(
                fontSize: 17.sp,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            // Yes/No options for PEP status
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildSelectableChip("Yes", isDark, chipWidth),
                SizedBox(width: 20.w),
                _buildSelectableChip("No", isDark, chipWidth),
              ],
            ),

            // Push buttons to bottom of screen
            const Spacer(),

            /// Continue Button
            constWidgets.greenButton(
              "Continue",
              onTap: isFormComplete
                  ? () {
                      navi(linkBankScreen(),
                          context); // Navigate to bank linking screen
                    }
                  : null,
              isDisabled: !isFormComplete,
            ),
            SizedBox(height: 10.h),

            /// Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Builds a selectable choice chip for PEP options
  /// @param value The display value for the chip (Yes/No)
  /// @param isDark Whether the app is in dark mode
  /// @param width The width of the chip
  /// @return A tappable choice chip widget
  Widget _buildSelectableChip(String value, bool isDark, double width) {
    bool isSelected = selectedPEP == value;
    return InkWell(
      onTap: () => setState(() => selectedPEP = value),
      child: constWidgets.choiceChip(value, isSelected, context, width, isDark),
    );
  }
}
