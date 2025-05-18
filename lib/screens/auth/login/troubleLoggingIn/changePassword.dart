import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/auth/login/login.dart';
import 'package:sapphire/utils/constWidgets.dart';
import 'package:sapphire/utils/naviWithoutAnimation.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isButtonDisabled = true;
  String? _errorMessage;

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen to text changes to validate passwords
    newPassword.addListener(_validatePasswords);
    confirmPassword.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    newPassword.removeListener(_validatePasswords);
    confirmPassword.removeListener(_validatePasswords);
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  // Validate passwords
  void _validatePasswords() {
    final newPass = newPassword.text;
    final confirmPass = confirmPassword.text;

    setState(() {
      // Password must be at least 8 characters, with letters, numbers, and symbols
      final passwordRegex = RegExp(
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
      if (newPass.isEmpty || confirmPass.isEmpty) {
        _errorMessage = null;
        _isButtonDisabled = true;
      } else if (!passwordRegex.hasMatch(newPass)) {
        _errorMessage =
            'Password must be at least 8 characters with letters, numbers, and symbols';
        _isButtonDisabled = true;
      } else if (newPass != confirmPass) {
        _errorMessage = 'Passwords do not match';
        _isButtonDisabled = true;
      } else {
        _errorMessage = null;
        _isButtonDisabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Use at least 8 characters with letters, numbers & symbols.",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: isDark ? Colors.white70 : Colors.black54),
                    ),
                    SizedBox(height: 24.h),
                    // New Password Field
                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        controller: newPassword,
                        obscureText: _obscureText1,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            },
                            child: Icon(
                              _obscureText1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isDark
                                  ? Color(0xffC9CACC)
                                  : Color(0xffD1D5DB),
                              size: 22.sp,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white54
                                    : Color(0xffD1D5DB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                                color:
                                    isDark ? Colors.white : Color(0xffD1D5DB),
                                width: 2.w),
                          ),
                          hintText: 'Enter New Password',
                          hintStyle: TextStyle(
                              color: isDark
                                  ? Color(0xFFC9CACC)
                                  : Color(0xff6B7280),
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Confirm Password Field
                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        controller: confirmPassword,
                        obscureText: _obscureText2,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            child: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isDark
                                  ? Color(0xffC9CACC)
                                  : Color(0xffD1D5DB),
                              size: 22.sp,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 12.h),
                          filled: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white54
                                    : Color(0xffD1D5DB)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide(
                                color:
                                    isDark ? Colors.white : Color(0xffD1D5DB),
                                width: 2.w),
                          ),
                          hintText: 'Confirm New Password',
                          hintStyle: TextStyle(
                              color: isDark
                                  ? Color(0xFFC9CACC)
                                  : Color(0xff6B7280),
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      SizedBox(height: 8.h),
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                    const Expanded(child: SizedBox()),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        constWidgets.greenButton(
                          "Continue",
                          onTap: _isButtonDisabled
                              ? null
                              : () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.black,
                                    builder: (context) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Color(0xff121413)
                                              : Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(16)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(height: 35.h),
                                            SvgPicture.asset(
                                              "assets/svgs/doneMark.svg",
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              "Password changed successfully",
                                              style: TextStyle(
                                                fontSize: 21.sp,
                                                color: Color(0xFFEBEEF5),
                                              ),
                                            ),
                                            SizedBox(height: 24.h),
                                            Text(
                                              "Your password has been updated. Please use the new password to log in.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                            // Bottom sheet title
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    naviWithoutAnimation(
                                        context, LoginScreen());
                                  });
                                },
                          isDisabled: _isButtonDisabled,
                        ),
                        SizedBox(height: 10.h),
                        Center(child: constWidgets.needHelpButton(context)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
