import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/manual2FA.dart';
import 'package:sapphire/screens/accountSection/otp2FA.dart';

class twoFAScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isDark ? Colors.black : Colors.white, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
        leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Two Factor Authentication",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: isDark ? Colors.white : Colors.black),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              )),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28.h),
                Center(
                  child: Image.asset(
                    'assets/images/Vector.png', // Replace with your actual image path
                    width: 70, // Adjust size as needed
                    height: 80,
                    fit: BoxFit.contain,
                    color: isDark ? Color(0xffC9CACC) : Color(0xff6B7280),
                  ),
                ),
                SizedBox(height: 28.h),
                Center(
                  child: Text("Protect your account",
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400)),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text(
                    "In order to protect your account you’ll need a\nsecondary authenticator to continue with this action.",
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 13.sp),
                    textAlign: TextAlign.center, // Aligns text to center
                  ),
                ),
                SizedBox(height: 28.h),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black : Colors.white,
                    border: Border.all(
                        color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Advantages of Two-Factor Authentication",
                          style: TextStyle(
                              color: isDark ? Color(0xFFEBEEF5) : Colors.black,
                              fontSize: 13.sp)),
                      SizedBox(height: 10.h),
                      Row(children: [
                        Icon(
                          Icons.lock,
                          color: Colors.green,
                          size: 14,
                        ),
                        SizedBox(width: 5.w),
                        Text("Enhanced Security",
                            style: TextStyle(
                                color: isDark
                                    ? Color(0xFFC9CACC)
                                    : Color(0xff6B7280),
                                fontSize: 13.sp))
                      ]),
                      Row(children: [
                        Icon(
                          Icons.shield,
                          color: Colors.green,
                          size: 14,
                        ),
                        SizedBox(width: 5.w),
                        Text("Reduces Fraud & Identity Theft",
                            style: TextStyle(
                                color: isDark
                                    ? Color(0xFFC9CACC)
                                    : Color(0xff6B7280),
                                fontSize: 13.sp))
                      ]),
                      Row(children: [
                        Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text("Prevents Unauthorized Access",
                            style: TextStyle(
                                color: isDark
                                    ? Color(0xFFC9CACC)
                                    : Color(0xff6B7280),
                                fontSize: 13.sp))
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Divider(
                  color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB),
                ),
                SizedBox(height: 24.h),
                Text("Pick Your Verification Method",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500)),
                SizedBox(height: 15.h),
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xff121413) : Color(0xffF4F4F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // First Option (Text)
                      InkWell(
                        onTap: () {
                          navi(otp2faScreen(), context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 14.h, bottom: 7.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Text",
                                      style: TextStyle(
                                          color: isDark
                                              ? Color(0xFFEBEEF5)
                                              : Colors.black,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                        height: 4
                                            .h), // Small spacing between title and subtitle
                                    Text(
                                      "A code will be sent to your phone",
                                      style: TextStyle(
                                          color: isDark
                                              ? Color(0xFFC9CACC)
                                              : Color(0xff6B7280),
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.verified_sharp,
                                color: Colors.green,
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color:
                                      isDark ? Colors.white : Color(0xff6B7280),
                                  size: 17),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                          color:
                              isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
                      // Second Option (Authentication App)
                      InkWell(
                        onTap: () {
                          navi(manual2faScreen(), context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 6.h, bottom: 12.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Authentication App",
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16.sp),
                                    ),
                                    SizedBox(
                                        height: 4
                                            .h), // Small spacing between title and subtitle
                                    Text(
                                      "Generate a code using an authentication app",
                                      style: TextStyle(
                                          color: isDark
                                              ? Color(0xFFC9CACC)
                                              : Color(0xff6B7280),
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: isDark ? Colors.white : Colors.black,
                                  size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
