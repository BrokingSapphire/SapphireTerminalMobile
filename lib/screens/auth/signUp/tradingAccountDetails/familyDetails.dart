import 'dart:convert'; // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure token storage
import 'package:http/http.dart' as http; // For API requests
import 'package:sapphire/screens/auth/signUp/tradingAccountDetails/personalDetails.dart'; // Next screen in registration flow
import 'package:sapphire/main.dart'; // App-wide navigation utilities
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

/// FamilyDetailsScreen - Screen for collecting family information
/// Gathers parent names and marital status for KYC compliance
class FamilyDetailsScreen extends StatefulWidget {
  const FamilyDetailsScreen({super.key});

  @override
  State<FamilyDetailsScreen> createState() => _FamilyDetailsScreenState();
}

/// State class for the FamilyDetailsScreen widget
/// Manages form inputs, validation, API submission, and UI rendering
class _FamilyDetailsScreenState extends State<FamilyDetailsScreen> {
  TextEditingController fathersName = TextEditingController();
  TextEditingController mothersName = TextEditingController();
  bool _isGray = true; // Controls button enabled/disabled state
  double width = 0; // Width for choice chips, set during build
  String? selectedMaritalStatus = "Single"; // Default selection
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  bool get isFormComplete =>
      fathersName.text.trim().isNotEmpty &&
      mothersName.text.trim().isNotEmpty &&
      selectedMaritalStatus != null;

  @override
  void initState() {
    super.initState();
    fathersName.addListener(_checkFields);
    mothersName.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _isGray =
          fathersName.text.trim().isEmpty || mothersName.text.trim().isEmpty;
    });
  }

  Future<void> submitFamilyDetails() async {
    final token = await secureStorage.read(key: 'auth_token');
    final uri = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    final body = {
      "step": "user_detail",
      "marital_status": selectedMaritalStatus,
      "father_name": fathersName.text.trim(),
      "mother_name": mothersName.text.trim(),
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          Center(child: CircularProgressIndicator(color: Color(0xFF1DB954))),
    );

    try {
      final response = await http.post(
        uri,
        headers: {
          "accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(body),
      );

      Navigator.of(context).pop();

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar("Family details saved", Colors.green, context);
        navi(PersonalDetails(), context);
      } else {
        final msg = jsonDecode(response.body)?["error"]?["message"] ??
            "Something went wrong!";
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      constWidgets.snackbar("Error submitting data: $e", Colors.red, context);
    }
  }

  @override
  void dispose() {
    fathersName.removeListener(_checkFields);
    mothersName.removeListener(_checkFields);
    fathersName.dispose();
    mothersName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    width = MediaQuery.of(context).size.width / 3 - 20;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
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
              constWidgets.topProgressBar(1, 4, context),
              SizedBox(height: 24.h),
              Text(
                "Enter your parent's name",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16.h),
              constWidgets.textField("Father's Name", fathersName,
                  isDark: isDark),
              SizedBox(height: 16.h),
              constWidgets.textField("Mother's Name", mothersName,
                  isDark: isDark),
              SizedBox(height: 20.h),
              // Uncommented and made theme-compatible
              // Text(
              //   "Marital Status",
              //   style: TextStyle(
              //     fontSize: 18.sp,
              //     fontWeight: FontWeight.w500,
              //     color: isDark ? Colors.white : Colors.black,
              //   ),
              // ),
              // SizedBox(height: 12.h),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     _buildSelectableChip("Single", isDark),
              //     _buildSelectableChip("Married", isDark),
              //     _buildSelectableChip("Divorced", isDark),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: _isGray ? null : () => submitFamilyDetails(),
                onPressed: () => navi(PersonalDetails(), context),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      (_isGray) ? Colors.grey[400] : Color(0xFF1DB954),
                  foregroundColor: Colors.white,
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
}
