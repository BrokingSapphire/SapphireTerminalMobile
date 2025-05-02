// File: confirmBankDetails.dart
// Description: Bank account verification screen in the Sapphire Trading application.
// This screen displays the detected bank details for user confirmation as part of the KYC process.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:sapphire/screens/signUp/ipvScreen.dart'; // Next screen in registration flow (IPV - In-Person Verification)

import '../../main.dart'; // App-wide navigation utilities
import '../../utils/constWidgets.dart'; // Reusable UI components

/// ConfirmBankDetails - Screen for verifying and confirming bank account information
/// Displays pre-fetched bank details for user confirmation before proceeding to the next KYC step
/// Note: Class name should be capitalized as per Dart conventions (ConfirmBankDetails)
class confirmBankDetails extends StatefulWidget {
  const confirmBankDetails({super.key});

  @override
  State<confirmBankDetails> createState() => _confirmBankDetailsState();
}

/// State class for the ConfirmBankDetails widget
/// Manages the UI display for bank account confirmation
class _confirmBankDetailsState extends State<confirmBankDetails> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            // Progress indicator showing current step in registration flow (step 1 of 5)
            constWidgets.topProgressBar(1, 5, context),
            SizedBox(
              height: 24.h,
            ),

            // Page heading
            Text(
              "Link your bank account",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),

            // Instruction subtitle
            Text(
              "Please confirm your bank details",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 12.h),

            /// Bank Details Card
            /// Displays the fetched bank information for user confirmation
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Color(0xff121413)
                    : Color(0xffF5F7FA), // Dark background for the card
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bank name row with logo and edit option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Bank logo and name
                      Row(
                        children: [
                          // Bank logo
                          Image.asset(
                            "assets/images/kotakbanklogo.png",
                            height: 22.h,
                            width: 22.w,
                          ),
                          SizedBox(width: 5.w),
                          // Bank name
                          Text(
                            "Kotak Mahindra Bank Ltd",
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      // Edit button to modify bank details if needed
                      InkWell(
                        onTap: () {
                          Navigator.pop(
                              context); // Return to bank selection/entry screen
                          // TODO: Implement edit functionality - currently just navigates back
                        },
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.green, size: 16),
                            SizedBox(width: 4.w),
                            Text(
                              "Edit",
                              style: TextStyle(
                                  color: Colors.green, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Account details row - Contains account number and IFSC code
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Account number section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Label
                          Text("Account Number",
                              style: TextStyle(
                                  color: isDark
                                      ? Color(0xffC9CACC)
                                      : Color(0xff6B7280),
                                  fontSize: 12.sp)),
                          SizedBox(height: 2.h),
                          // Value - partially masked for security in production
                          Text("51236478954",
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp)),
                        ],
                      ),
                      // IFSC code section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Label
                          Text("IFSC Code",
                              style: TextStyle(
                                  color: isDark
                                      ? Color(0xffc9cacc)
                                      : Color(0xff6B7280),
                                  fontSize: 12.sp)),
                          SizedBox(height: 2.h),
                          // Value
                          Text("KKBK5478124",
                              style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Branch details section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label
                      Text("Branch",
                          style: TextStyle(
                              color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                              fontSize: 12.sp)),
                      SizedBox(height: 2.h),
                      // Full branch address
                      Text(
                        "GR FLOOR 1ST FLOOR GALAXY TOWERS PLOT 478 CHANDAN UNTHKANA RD MEDICAL SQU OPP HALDIRAM NAGPUR 440009",
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 13.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Push content to top and buttons to bottom
            Spacer(),

            // Confirmation button - navigates to IPV screen when pressed
            constWidgets.greenButton("Confirm", onTap: () {
              navi(ipvScreen(),
                  context); // Navigate to the In-Person Verification screen
            }),
            SizedBox(height: 10.h),
            // Help button for user assistance
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }
}
