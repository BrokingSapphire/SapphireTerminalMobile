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
  TextEditingController panNumber = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  bool isLoading = false;

  @override
  void dispose() {
    panNumber.dispose(); // Clean up controller
    super.dispose();
  }

  bool _isValidPAN(String pan) {
    RegExp panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    return panRegex.hasMatch(pan);
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1DB954),
        ),
      ),
    );
  }

  void hideLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> verifyPanNumber(String pan) async {
    String? token = await secureStorage.read(key: 'auth_token');
    final cleanedPan = pan.trim().toUpperCase();
    setState(() => isLoading = true);
    showLoadingDialog();
    final isVerified = await verifyPanStep(cleanedPan, token);
    if (isVerified) {
      await fetchPanInfo(token);
    } else {
      hideLoadingDialog();
    }
    setState(() => isLoading = false);
  }

  Future<bool> verifyPanStep(String pan, String? token) async {
    final verifyUrl = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    try {
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

  Future<void> fetchPanInfo(String? token) async {
    final infoUrl = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint/pan");

    try {
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

  void showNameConfirmationBottomSheet(
      BuildContext context, String name, String dob) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
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
              Text(
                "Is this your Name?",
                style: TextStyle(
                  color: isDark ? Color(0xffEBEEF5) : Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              Center(
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  color: Color(0xFF1DB954),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              constWidgets.topProgressBar(1, 1, context),
              SizedBox(height: 24.h),
              Text(
                "PAN Details",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 16.h),
              Text(
                "We need your PAN as per SEBI regulations",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 16.h),
              constWidgets.textField("PAN Number", panNumber,
                  isCapital: true, isDark: isDark),
              SizedBox(height: 18.h),
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
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
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
                onPressed: () {
                  showNameConfirmationBottomSheet(
                      context, "John Doe", "1990-01-01");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: panNumber.text.length == 10
                      ? Color(0xFF1DB954)
                      : isDark
                          ? Color(0xff2f2f2f)
                          : Colors.grey[300],
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
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  void showFindPanBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.h,
            right: 16.h,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How to find your PAN number?",
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "Your PAN number will be on your PAN Card as shown below",
                style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                    fontSize: 13),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
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
              Row(
                children: [
                  Text(
                    "Don't have a PAN?",
                    style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.black54,
                        fontSize: 12.sp),
                  ),
                  SizedBox(width: 5.w),
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
