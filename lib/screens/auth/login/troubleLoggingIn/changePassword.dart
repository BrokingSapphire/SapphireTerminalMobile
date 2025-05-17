import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/utils/constWidgets.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
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
          onTap: () {
            FocusScope.of(context)
                .unfocus(); // Dismiss keyboard when tapping outside
          },
          behavior: HitTestBehavior.opaque,
          child: Column(children: [
            // Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
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
                    // Dynamic instruction text with partially masked contact info
                    Text(
                      "Use at least 8 characters with letters, numbers & symbols.", // Masked phone number
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: isDark ? Colors.white70 : Colors.black54),
                    ),
                    SizedBox(height: 24.h),
                    // Enter New MPIN Field

                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        controller: newPassword,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
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

                    // Confirm New MPIN Field

                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        controller: confirmPassword,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
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
                    const Expanded(child: SizedBox()), // Pushes content to top
                  ],
                ),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              constWidgets.greenButton("Continue", onTap: () {}),
              SizedBox(height: 10.h),
              // Help button for user assistance
              Center(child: constWidgets.needHelpButton(context)),
            ],
          ),
        ));
  }
}
