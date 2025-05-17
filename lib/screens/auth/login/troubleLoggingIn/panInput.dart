import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/auth/login/troubleLoggingIn/otpVerificatin.dart';
import 'package:sapphire/utils/constWidgets.dart';

class panInput extends StatefulWidget {
  const panInput({super.key});

  @override
  State<panInput> createState() => _panInputState();
}

class _panInputState extends State<panInput> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    TextEditingController panNumber = TextEditingController();
    return Scaffold(
      // App bar with back button
      appBar: AppBar(
        leadingWidth: 46.w,
        leading: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
                size: 28.sp, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
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
              // SizedBox(height: 12.h),
              // Progress indicator (completion step 1 of 1)

              // Screen title
              Text(
                "Trouble Logging In?",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black),
              ),
              SizedBox(height: 16.h),
              // Explanatory text about regulatory requirement
              Text(
                "To complete the verification process, we need your PAN to confirm your identity.",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black54),
              ),
              SizedBox(height: 24.h),
              // PAN input field (auto-capitalized)
              constWidgets.textField("PAN Number", panNumber,
                  isCapital: true, isDark: isDark),

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
            constWidgets.greenButton("Continue", onTap: () {
              navi(otpVerification(), context);
            }),
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
            bottom: MediaQuery.of(context).viewInsets.bottom +
                20, // Adjust for keyboard
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
