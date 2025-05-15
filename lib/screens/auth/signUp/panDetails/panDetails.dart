// File: panDetails.dart
// Description: PAN card details collection screen for Sapphire Trading application.
// This screen collects and validates the user's PAN (Permanent Account Number) card information,
// which is required by SEBI regulations for opening a trading account in India.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/main.dart'; // App-wide utilities
import 'package:sapphire/screens/auth/signUp/aadharDetails/aadharDetails.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components
import 'package:url_launcher/url_launcher.dart'; // For opening external URLs

/// PanDetails - Screen for PAN card information collection and verification
/// Collects user's PAN number, validates format, and verifies with backend services
/// Required by SEBI regulations for financial account creation
class PanDetails extends StatefulWidget {
  const PanDetails({super.key});

  @override
  State<PanDetails> createState() => _PanDetailsState();
}

/// State class for the PanDetails widget
/// Manages PAN input, validation, API calls, and confirmation process
class _PanDetailsState extends State<PanDetails> {
  TextEditingController panNumber = TextEditingController(); // Controls PAN input field
  final FlutterSecureStorage secureStorage = FlutterSecureStorage(); // Secure storage for auth token
  bool isLoading = false; // Tracks loading state for API operations

  @override
  void dispose() {
    panNumber.dispose(); // Clean up controller when widget is removed
    super.dispose();
  }

  /// Validates PAN number format using regex pattern
  /// Valid PAN format: 5 uppercase letters + 4 digits + 1 uppercase letter
  // bool _isValidPAN(String pan) {
  //   RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
  //   return panRegex.hasMatch(pan);
  // }

  /// Shows loading indicator dialog during API operations
  /// Prevents user interaction until operation completes
  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must wait for operation to complete
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1DB954), // Green spinner matches brand color
        ),
      ),
    );
  }

  /// Hides the loading dialog when API operation completes
  /// Checks if dialog can be dismissed before attempting to prevent errors
  void hideLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// Main verification function - orchestrates the multi-step PAN verification process
  /// 1. Updates loading state and shows dialog
  /// 2. Calls API to verify PAN number
  /// 3. If verified, fetches additional PAN information
  Future<void> verifyPanNumber(String pan) async {
    String? token = await secureStorage.read(key: 'auth_token'); // Get auth token
    final cleanedPan = pan.trim().toUpperCase(); // Normalize PAN format
    setState(() => isLoading = true);
    showLoadingDialog();
    final isVerified = await verifyPanStep(cleanedPan, token);
    if (isVerified) {
      await fetchPanInfo(token); // Only fetch details if verification succeeded
    } else {
      hideLoadingDialog();
    }
    setState(() => isLoading = false);
  }

  /// First API call to verify the PAN number format and existence
  /// Returns boolean indicating verification success/failure
  Future<bool> verifyPanStep(String pan, String? token) async {
    final verifyUrl = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    try {
      // Send PAN verification request to backend
      final response = await http.post(
        verifyUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "step": "pan", // Identifies the verification step
          "pan_number": pan,
        }),
      );

      print("📨 Verify PAN Status: ${response.statusCode}");
      print("📨 Verify PAN Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final success = data['success'] == true;
        final message = data['message'] ?? "PAN verified";
        if (success) {
          constWidgets.snackbar(message, Colors.green, context);
        }
        return success;
      } else {
        constWidgets.snackbar("PAN verification failed", Colors.red, context);
      }
    } catch (e) {
      print(e);
      constWidgets.snackbar("Error verifying PAN: $e", Colors.red, context);
    }

    return false;
  }

  /// Second API call to fetch detailed information associated with the PAN
  /// Shows confirmation bottom sheet with user's name and DOB if successful
  Future<void> fetchPanInfo(String? token) async {
    final infoUrl = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint/pan");

    try {
      // Request additional PAN details from backend
      final response = await http.get(
        infoUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      hideLoadingDialog();
      print("📨 PAN Info Status: ${response.statusCode}");
      print("📨 PAN Info Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final name = data['name'];
        final dob = data['dob'];
        if (name != null && dob != null) {
          // Show confirmation sheet with retrieved information
          showNameConfirmationBottomSheet(context, name, dob);
        } else {
          constWidgets.snackbar("PAN info is incomplete", Colors.red, context);
        }
      } else {
        constWidgets.snackbar("Failed to fetch PAN info", Colors.red, context);
      }
    } catch (e) {
      hideLoadingDialog();
      constWidgets.snackbar("Error fetching PAN info: $e", Colors.red, context);
    }
  }

  /// Shows bottom sheet to confirm user's name and DOB retrieved from PAN database
  /// Allows user to confirm or modify details before continuing
  void showNameConfirmationBottomSheet(
      BuildContext context, String name, String dob) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      enableDrag: false, // Prevent dismissal by dragging
      isScrollControlled: true, // Allow bottom sheet to adjust size
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? Color(0xff121413) : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bottom sheet title
              Text(
                "Is this your Name?",
                style: TextStyle(
                  color: isDark ? Color(0xffEBEEF5) : Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              // User details from PAN verification
              Center(
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // User's name (highlighted in green)
                            Text(
                              name,
                              style: TextStyle(
                                  color: Color(0xFF1DB954),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            // User's date of birth
                            Text(
                              dob,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Confirmation prompt
                    Text(
                      "Looks good? Let's move ahead!",
                      style: TextStyle(
                          color: isDark ? Color(0xffC9CACC) : Colors.grey[600],
                          fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Important notice about PAN details
              Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff212221) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Note: Once confirmed, you cannot change your PAN details.",
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Action buttons (Modify or Continue)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Modify button - dismisses sheet to allow user to edit PAN
                  SizedBox(
                    width: 96.w,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor:
                        isDark ? Color(0xff212221) : Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Modify",
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  // Continue button - proceeds to next screen (Aadhar verification)
                  SizedBox(
                    width: 96.w,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        navi(VerifyAadharScreen(), context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF1DB954),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leadingWidth: 46,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      // Main body with gesture detection to dismiss keyboard on tap outside
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // Progress indicator (completion step 1 of 1)
              constWidgets.topProgressBar(1, 1, context),
              SizedBox(height: 24.h),
              // Screen title
              Text(
                "PAN Details",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 16.h),
              // Explanatory text about regulatory requirement
              Text(
                "We need your PAN as per SEBI regulations",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 16.h),
              // PAN input field (auto-capitalized)
              constWidgets.textField("PAN Number", panNumber,
                  isCapital: true, isDark: isDark),
              SizedBox(height: 18.h),
              // Help link to find PAN number
              InkWell(
                onTap: () => showFindPanBottomSheet(context),
                child: Text(
                  "How to find your PAN number?",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(child: SizedBox()), // Pushes content to top
            ],
          ),
        ),
      ),
      // Bottom area with verify button and help option
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Verify button - conditionally styled based on PAN input length
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // Original API verification implementation (currently commented out)
                // onPressed: panNumber.text.length == 10
                //     ? () {
                //         if (panNumber.text.isEmpty ||
                //             !_isValidPAN(panNumber.text)) {
                //           constWidgets.snackbar(
                //               "Enter a valid PAN number (e.g., ABCDE1234F)",
                //               Colors.red,
                //               context);
                //           Future.delayed(
                //               Duration(seconds: 1), () => panNumber.clear());
                //         } else {
                //           verifyPanNumber(panNumber.text.toUpperCase());
                //         }
                //       }
                //     : null,.

                // Temporary simplified implementation for testing/demo
                // TODO: Restore original implementation with proper API verification when ready
                onPressed: () {
                  showNameConfirmationBottomSheet(
                      context, "John Doe", "1990-01-01");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: panNumber.text.length == 10
                      ? Color(0xFF1DB954) // Green when PAN has correct length
                      : isDark
                      ? Color(0xff2f2f2f) // Dark gray in dark mode when invalid
                      : Colors.grey[300], // Light gray in light mode when invalid
                  foregroundColor: isDark ? Colors.white : Colors.black,
                ),
                child: Text(
                  "Verify",
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
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

  /// Shows bottom sheet with visual guide on finding PAN number
  /// Also provides option to get an ePAN for users without physical PAN card
  void showFindPanBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow sheet to adjust for keyboard
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20, // Adjust for keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bottom sheet title
              Text(
                "How to find your PAN number?",
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              // Explanatory text
              Text(
                "Your PAN number will be on your PAN Card as shown below",
                style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              // PAN card sample image with indicator
              Image.asset(
                "assets/images/pan.png",
                width: 380.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 190.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Your PAN Number",
                    style: TextStyle(
                        color: isDark ? Colors.black : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              // Option to get ePAN for users without existing PAN
              Row(
                children: [
                  Text(
                    "Don't have a PAN?",
                    style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: 12.sp),
                  ),
                  SizedBox(width: 5.w),
                  // Link to official ePAN application website
                  GestureDetector(
                    onTap: () async {
                      const url =
                          'https://eportal.incometax.gov.in/iec/foservices/#/pre-login/instant-e-pan';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      "Get ePAN in few minutes",
                      style:
                      TextStyle(color: Color(0xFF1DB954), fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Button to dismiss the help sheet
              Center(
                child: SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1DB954),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Got It",
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}