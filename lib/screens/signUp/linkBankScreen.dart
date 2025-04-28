import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/manualLinkingScreen.dart';
import 'package:sapphire/screens/signUp/linkWithUpiScreen.dart';
import '../../utils/constWidgets.dart';

class linkBankScreen extends StatelessWidget {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<void> initiateValidation(String type, BuildContext context) async {
    // final token = await secureStorage.read(key: 'auth_token');

    // final url = Uri.parse(
    //     "https://api.backend.sapphirebroking.com:8443/api/v1/auth/signup/checkpoint");

    // final body = {
    //   "step": "bank_validation_start",
    //   "validation_type": type, // "upi" or "bank"
    // };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: CircularProgressIndicator(color: Color(0xFF1DB954)),
      ),
    );

    try {
      // final response = await http.post(
      //   url,
      //   headers: {
      //     "accept": "application/json",
      //     "Content-Type": "application/json",
      //     "Authorization": "Bearer $token",
      //   },
      //   body: jsonEncode(body),
      // );

      Future.delayed(Duration(seconds: 2));

      Navigator.of(context).pop(); // Close loader

      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   constWidgets.snackbar("Validation started", Colors.green, context);
      //   if (type == "upi") {
      navi(linkWithUpiScreen(), context);
      //   } else {
      //     navi(ManualLinkingScreen(), context);
      //   }
      // } else {
      //   final msg = jsonDecode(response.body)['error']?['message'] ??
      //       'Validation failed';
      //   constWidgets.snackbar(msg, Colors.red, context);
      // }
    } catch (e) {
      Navigator.of(context).pop();
      constWidgets.snackbar("Error: $e", Colors.red, context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            constWidgets.topProgressBar(1, 5, context),
            SizedBox(height: 24.h),
            Text("Link your bank account",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            Text(
              "To finish opening your account,  you'll need to link your bank account, which will be used for your investments. Once linked, we'll verify it to ensure it belongs to you.",
              style: TextStyle(fontSize: 15.sp, color: Color(0xffEBEEF5)),
            ),
            SizedBox(height: 16.h),
            _buildBankOption(
              title2: "(recommended)",
              svgAssetPath: "assets/images/upi.svg",
              title: "Link via UPI ",
              onTap: () => initiateValidation("upi", context),
            ),
            SizedBox(height: 12.h),
            _buildBankOption(
              title2: "",
              svgAssetPath: "assets/images/bank.svg",
              title: "Enter Bank details manually",
              onTap: () => initiateValidation("bank", context),
            ),
            Spacer(),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption({
    required String svgAssetPath,
    required String title,
    required String title2,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF121413),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: title2,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (subtitle != null)
                    Text(subtitle,
                        style: TextStyle(fontSize: 14.sp, color: Colors.green)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
