import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive UI scaling
import 'package:flutter/services.dart'; // For input formatting
import 'package:sapphire/functions/authFunctions.dart'; // Authentication utilities
import 'package:sapphire/screens/signUp/mobileOtpVerification.dart'; // Next screen in registration flow
import 'package:sapphire/utils/constWidgets.dart'; // Reusable UI components

import '../../../main.dart'; // App-wide utilities

/// MobileOtp - Screen for collecting user's mobile number
/// Follows email verification in the registration flow
/// Sends the mobile number for verification and proceeds to OTP verification
class MobileOtp extends StatefulWidget {
  final String email; // Email passed from previous screen (already verified)

  const MobileOtp({super.key, required this.email});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

/// State class for the MobileOtp widget
/// Manages mobile number input and validation
class _MobileOtpState extends State<MobileOtp> {
  final TextEditingController _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneNumber.addListener(() {
      setState(
          () {}); // Rebuild UI when phone number changes (for button state)
    });
  }

  @override
  void dispose() {
    _phoneNumber.dispose(); // Clean up controller
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
            icon: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.pop(context); // Navigate back to previous screen
            },
          ),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Mobile Verification",
                          style: TextStyle(
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Form(
                        key: _formKey,
                        child: constWidgets.textField(
                          "Phone Number",
                          _phoneNumber,
                          isPhoneNumber: true,
                          isDark: isDark,
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isDark ? Color(0xFF9B9B9B) : Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 52.h,
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: (_phoneNumber.text.isNotEmpty &&
                //         _formKey.currentState != null &&
                //         _formKey.currentState!.validate())
                //     ? () {
                //         AuthFunctions()
                //             .mobileVerification(
                //                 _phoneNumber.text.toString(), widget.email)
                //             .then((value) => navi(
                //                 MobileOtpVerification(
                //                     isEmail: false,
                //                     email: widget.email,
                //                     mobileOrEmail:
                //                         _phoneNumber.text.toString()),
                //                 context));
                //       }
                //     : () {
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             content: Text(
                //               "Enter a valid phone number!",
                //               style: TextStyle(color: Colors.white),
                //             ),
                //             backgroundColor: Colors.red,
                //           ),
                //         );
                //       },
                onPressed: () {
                  navi(
                      MobileOtpVerification(
                          isEmail: false,
                          email: widget.email,
                          mobileOrEmail: _phoneNumber.text.toString()),
                      context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: (_phoneNumber.text.isNotEmpty &&
                          _formKey.currentState != null &&
                          _formKey.currentState!.validate())
                      ? Color(0xFF1DB954)
                      : isDark
                          ? Color(0xff2f2f2f)
                          : Colors.grey[300],
                  foregroundColor: isDark ? Colors.white : Colors.black,
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: (_phoneNumber.text.isNotEmpty &&
                            _formKey.currentState != null &&
                            _formKey.currentState!.validate())
                        ? Colors.white
                        : isDark
                            ? Color(0xffc9cacc)
                            : Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            constWidgets.needHelpButton(context),
          ],
        ),
      ),
    );
  }
}
