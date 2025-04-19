import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:sapphire/functions/authFunctions.dart';
import 'package:sapphire/screens/signUp/mobileOtpVerification.dart';
import 'package:sapphire/utils/constWidgets.dart';

import '../../main.dart';

class MobileOtp extends StatefulWidget {
  final String email;
  const MobileOtp({super.key, required this.email});

  @override
  State<MobileOtp> createState() => _MobileOtpState();
}

class _MobileOtpState extends State<MobileOtp> {
  final TextEditingController _phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
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
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/whiteLogo.png",
                    scale: 0.7,
                  ),
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome to\nSapphire",
                    style: TextStyle(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text("Get started in just a few easy steps!")),
                SizedBox(height: 40.h),

                // Form for validation
                Form(
                  key: _formKey,
                  child: constWidgets.textField(
                    "Phone Number",
                    _phoneNumber,
                    isPhoneNumber: true,
                    isDark: isDark,
                  ),
                ),
                SizedBox(height: 20.h), // Extra spacing
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Moves elements to the bottom
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "© 2025 Sapphire Broking. SEBI Registered Stock Broker | Member: NSE, BSE, MCX, NCDEX. Investments are subject to market risks. Read all documents carefully. Disputes subject to Nagpur jurisdiction.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 11.sp, color: Color(0xFF9B9B9B)),
                    ),
                  ),
                  // Prevents UI from sticking to bottom
                ],
              ),

              /// Continue Button

              constWidgets.greenButton("Continue", onTap: () {
                if (_formKey.currentState!.validate()) {
                  // Proceed if valid
                  AuthFunctions()
                      .mobileVerification(
                          _phoneNumber.text.toString(), widget.email)
                      .then(
                        (value) => navi(
                            MobileOtpVerification(
                                isEmail: false,
                                email: widget.email,
                                mobileOrEmail: _phoneNumber.text.toString()),
                            context),
                      );
                } else {
                  // Show error snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Enter a valid phone number!",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }),

              SizedBox(height: 10.h),

              /// Need Help Button
              constWidgets.needHelpButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
