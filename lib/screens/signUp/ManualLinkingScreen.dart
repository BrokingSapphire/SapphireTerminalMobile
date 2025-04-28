import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/screens/signUp/confirmBankDetails.dart';
import 'package:sapphire/screens/signUp/linkWithUpiScreen.dart';
import '../../main.dart';
import '../../utils/constWidgets.dart';

class ManualLinkingScreen extends StatefulWidget {
  @override
  _ManualLinkingScreenState createState() => _ManualLinkingScreenState();
}

class _ManualLinkingScreenState extends State<ManualLinkingScreen> {
  TextEditingController ifscController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  String? selectedAccountType;
  bool _isButtonDisabled = true;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    ifscController.addListener(_checkFields);
    accountNumberController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _isButtonDisabled = ifscController.text.trim().isEmpty ||
          accountNumberController.text.trim().isEmpty ||
          selectedAccountType == null;
    });
  }

  void _selectAccountType(String value) {
    setState(() {
      selectedAccountType = value;
      _checkFields();
    });
  }

  Future<void> submitBankDetails() async {
    print("[INFO] Submit button pressed");
    final token = await secureStorage.read(key: 'auth_token');
    print("[INFO] Retrieved token: $token");

    final url = Uri.parse(
        "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    final body = {
      "step": "bank_validation",
      "validation_type": "bank",
      "bank": {
        "account_number": accountNumberController.text.trim(),
        "ifsc_code": ifscController.text.trim(),
      },
    };

    print("[INFO] Request body: ${jsonEncode(body)}");

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

      Navigator.of(context).pop(); // Close loader

      print("[INFO] Response status: ${response.statusCode}");
      print("[INFO] Response body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        constWidgets.snackbar(
            "Bank linked successfully!", Colors.green, context);
        navi(confirmBankDetails(), context);
      } else {
        final msg = jsonDecode(response.body)['error']?['message'] ??
            'Something went wrong.';
        print("[ERROR] API Error Message: $msg");
        constWidgets.snackbar(msg, Colors.red, context);
      }
    } catch (e) {
      Navigator.of(context).pop();
      print("[EXCEPTION] $e");
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  void dispose() {
    ifscController.removeListener(_checkFields);
    accountNumberController.removeListener(_checkFields);
    ifscController.dispose();
    accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 46,
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              constWidgets.topProgressBar(1, 5, context),
              SizedBox(height: 24.h),
              Text(
                "Link your bank account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              Text(
                "Make sure that you are linking a bank account that is in your name.",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              constWidgets.textField("IFSC Code", ifscController,
                  isDark: isDark),
              SizedBox(height: 12.h),
              constWidgets.textField('Account Number', accountNumberController,
                  isDark: isDark),
              SizedBox(height: 18.h),
              Text(
                "Account Type",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildSelectableChip("Savings", isDark),
                  SizedBox(width: 20.w),
                  _buildSelectableChip("Current", isDark),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(
                    "  OR  ",
                    style: TextStyle(color: Color(0xFFC9CACC)),
                  ),
                  Expanded(child: Divider())
                ],
              ),
              SizedBox(height: 6.h),
              Center(
                child: TextButton(
                  onPressed: () {
                    navi(linkWithUpiScreen(), context);
                  },
                  child: Text(
                    "Link bank account using UPI",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(),
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
                onPressed: _isButtonDisabled ? null : submitBankDetails,
                child: Text(
                  "Continue",
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isButtonDisabled ? Color(0xff2f2f2f) : Color(0xFF1DB954),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Color(0xff2f2f2f),
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

  Widget _buildSelectableChip(String value, bool isDark) {
    bool isSelected = selectedAccountType == value;
    return InkWell(
      onTap: () => _selectAccountType(value),
      child: constWidgets.choiceChip(value, isSelected, context, 100.w, isDark),
    );
  }
}
