// File: panDetails.dart
// Description: PAN (Permanent Account Number) collection and verification screen.
// This screen collects and verifies the user's PAN card details as required by SEBI regulations
// for account creation in the Sapphire Trading application.

import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/main.dart'; // App-wide utilities
import 'package:sapphire/screens/signUp/verifyAadharScreen.dart'; // Next screen in registration flow
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
  // Controller for the PAN input field
  TextEditingController panNumber = TextEditingController();

  // Secure storage for authentication tokens
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Flag to track loading state during API calls
  bool isLoading = false;

  /// Validates PAN number format using regex
  /// PAN format: 5 uppercase letters + 4 digits + 1 uppercase letter
  /// @param pan The PAN string to validate
  /// @return True if PAN format is valid, false otherwise
  bool _isValidPAN(String pan) {
    RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegex.hasMatch(pan);
  }

  /// Shows a loading indicator dialog during API operations
  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1DB954), // Green loading indicator
        ),
      ),
    );
  }

  /// Hides the loading indicator dialog
  void hideLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// Main verification flow that orchestrates the PAN verification process
  /// @param pan The PAN number to verify
  Future<void> verifyPanNumber(String pan) async {
    // Retrieve the authentication token from secure storage
    String? token = await secureStorage.read(key: 'auth_token');

    // Normalize the PAN number (trim whitespace and convert to uppercase)
    final cleanedPan = pan.trim().toUpperCase();

    // Update UI to loading state and show loading indicator
    setState(() => isLoading = true);
    showLoadingDialog();

    // First step: Verify PAN number with backend
    final isVerified = await verifyPanStep(cleanedPan, token);

    // If verification successful, fetch additional PAN information
    if (isVerified) {
      await fetchPanInfo(token);
    } else {
      hideLoadingDialog(); // Hide loading indicator if verification fails
    }

    // Reset loading state when operation completes
    setState(() => isLoading = false);
  }

  /// First API call to verify the PAN number's validity
  /// @param pan Cleaned PAN number to verify
  /// @param token Authentication token for API
  /// @return True if verification successful, false otherwise
  Future<bool> verifyPanStep(String pan, String? token) async {
    // API endpoint for PAN verification
    final verifyUrl = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    try {
      // Send verification request to backend
      final response = await http.post(
        verifyUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "step": "pan",
          "pan_number": pan,
        }),
      );

      // Debug logging for API response
      print("📨 Verify PAN Status: ${response.statusCode}");
      print("📨 Verify PAN Response: ${response.body}");

      // Process response based on status code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final success = data['success'] == true;
        final message = data['message'] ?? "PAN verified";

        // Show success message if verification successful
        if (success) {
          constWidgets.snackbar(message, Colors.green, context);
        }
        return success;
      } else {
        // Show error message for non-200 responses
        constWidgets.snackbar("PAN verification failed", Colors.red, context);
      }
    } catch (e) {
      // Handle and log any exceptions during API call
      print(e);
      constWidgets.snackbar("Error verifying PAN: $e", Colors.red, context);
    }

    return false; // Return false for any errors or failures
  }

  /// Second API call to fetch PAN holder information after verification
  /// Retrieves name and DOB associated with the PAN
  /// @param token Authentication token for API
  Future<void> fetchPanInfo(String? token) async {
    // API endpoint for fetching PAN details
    final infoUrl = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint/pan");

    try {
      // Fetch PAN information from backend
      final response = await http.get(
        infoUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // Hide loading indicator as API call completes
      hideLoadingDialog();

      // Debug logging for API response
      print("📨 PAN Info Status: ${response.statusCode}");
      print("📨 PAN Info Response: ${response.body}");

      // Process response based on status code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final name = data['name'];
        final dob = data['dob'];

        // Show confirmation bottom sheet if required data is available
        if (name != null && dob != null) {
          showNameConfirmationBottomSheet(context, name, dob);
        } else {
          // Show error if data is incomplete
          constWidgets.snackbar("PAN info is incomplete", Colors.red, context);
        }
      } else {
        // Show error for non-200 responses
        constWidgets.snackbar("Failed to fetch PAN info", Colors.red, context);
      }
    } catch (e) {
      // Handle and log any exceptions during API call
      hideLoadingDialog();
      constWidgets.snackbar("Error fetching PAN info: $e", Colors.red, context);
    }
  }

  /// Shows a bottom sheet for user to confirm their PAN details
  /// Displays the name and DOB retrieved from the PAN and asks for confirmation
  /// @param context Current build context
  /// @param name PAN holder's name from API
  /// @param dob PAN holder's date of birth from API
  void showNameConfirmationBottomSheet(
      BuildContext context, String name, String dob) {
    showModalBottomSheet(
      context: context,
      enableDrag: false, // Prevent dragging to dismiss
      isScrollControlled: true, // Allow custom sizing
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xff121413),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title for confirmation dialog
              Text(
                "Is this your Name?",
                style: TextStyle(
                  color: Color(0xffEBEEF5),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),

              // Display retrieved PAN details
              Center(
                child: Column(
                  children: [
                    Container(
                      // Commented out border decoration
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Color(0xff2F2F2F)),
                      //   borderRadius: BorderRadius.circular(8.r),
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            // Display name in green
                            Text(
                              name,
                              style: TextStyle(
                                  color: Color(0xFF1DB954),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            // Display DOB in white
                            Text(
                              dob,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 13.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Prompt text
                    Text(
                      "Looks good? Let's move ahead!",
                      style:
                      TextStyle(color: Color(0xffC9CACC), fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Important note about PAN details being final
              Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xff212221),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "Note : Once confirmed, you cannot change your PAN details.",
                    style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Action buttons: Modify or Continue
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Modify button - returns to PAN input
                  SizedBox(
                    width: 96.w,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff212221),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Modify",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  // Continue button - proceeds to Aadhar verification
                  SizedBox(
                    width: 96.w,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close bottom sheet
                        navi(VerifyAadharScreen(), context); // Navigate to next screen
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
    // Detect if the app is running in dark mode to adjust UI elements accordingly
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leadingWidth: 46,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        // Dismiss keyboard when tapping outside input field
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // Progress indicator showing current step in registration flow
              constWidgets.topProgressBar(1, 1, context),
              SizedBox(height: 24.h),

              // Screen title
              Text(
                "PAN Details",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),

              // Regulatory information message
              Text(
                "We need your PAN as per SEBI regulations",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16.h),

              // PAN input field with automatic capitalization
              constWidgets.textField("PAN Number", panNumber,
                  isCapital: true, isDark: isDark),
              SizedBox(height: 18.h),

              // Help link for finding PAN number
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
              // Push content to top by expanding empty space at bottom
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),

      /// Bottom navigation area with verification button and help option
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Standard green button implementation (commented out)
            // constWidgets.greenButton("Verify", onTap: () {
            // if (panNumber.text.isEmpty || !_isValidPAN(panNumber.text)) {
            //   constWidgets.snackbar(
            //       "Enter a valid PAN number (e.g., ABCDE1234F)",
            //       Colors.red,
            //       context);
            //   Future.delayed(Duration(seconds: 1), () => panNumber.clear());
            // } else {
            //   verifyPanNumber(panNumber.text.toUpperCase());
            // }
            // }),

            /// Verify button - conditionally enabled based on PAN length
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // Button only enabled when PAN is exactly 10 characters
                onPressed: panNumber.text.length == 10
                    ? () {
                  // Validate PAN format when button is pressed
                  if (panNumber.text.isEmpty ||
                      !_isValidPAN(panNumber.text)) {
                    // Show error for invalid format
                    constWidgets.snackbar(
                        "Enter a valid PAN number (e.g., ABCDE1234F)",
                        Colors.red,
                        context);
                    // Clear field after error
                    Future.delayed(
                        Duration(seconds: 1), () => panNumber.clear());
                  } else {
                    // Initiate verification if format is valid
                    verifyPanNumber(panNumber.text.toUpperCase());
                  }
                }
                    : null, // Disabled if not 10 chars
                // Button style changes based on enabled state
                style: ElevatedButton.styleFrom(
                  backgroundColor: panNumber.text.length == 10
                      ? Color(0xFF1DB954) // Green when valid length
                      : Color(0xff2f2f2f), // Dark gray when invalid length
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Verify",
                  style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(height: 10.h),

            /// Help button for user assistance
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  /// Shows a visual guide for locating PAN number on the card
  /// Displays an image of a PAN card with indicators for the PAN number position
  /// Includes options for users who don't have a PAN card yet
  void showFindPanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow keyboard to push up content
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
            top: 20,
            // Adjust bottom padding to accommodate keyboard
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Help sheet title
              Text("How to find your PAN number?",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 5),

              // Instructional text
              Text("Your PAN number will be your PAN Card's shown below",
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                  textAlign: TextAlign.center),
              SizedBox(height: 15.h),

              // PAN card image with highlighted number location
              Image.asset(
                "assets/images/pan.png",
                width: 380.w,
              ),

              // Indicator for PAN number location on the card
              Padding(
                padding: EdgeInsets.only(
                  left: 190.w,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Your PAN Number",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 15.h),

              // Alternative rich text implementation (commented out)
              // RichText(
              //   textAlign: TextAlign.center,
              //   text: const TextSpan(
              //     text: "Don't have a PAN? ",
              //     style: TextStyle(color: Colors.white54, fontSize: 12),
              //     children: [
              //       TextSpan(
              //         text: "Get ePAN in few minutes",
              //         style: TextStyle(
              //             color: Color(0xFF1DB954),
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),

              /// Option for users without a PAN card to get an electronic PAN
              Row(
                children: [
                  Text(
                    "Don't have a PAN?",
                    style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  // Clickable link to official ePAN website
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

              // Dismissal button for the help sheet
              Center(
                child: SizedBox(
                  width: 100.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1DB954),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text("Got It",
                        style: TextStyle(
                            fontSize: 17.sp, fontWeight: FontWeight.w600)),
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