import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constWidgets.dart';

class changeNewPinScreen extends StatefulWidget {
  @override
  _changeNewPinScreenState createState() => _changeNewPinScreenState();
}

class _changeNewPinScreenState extends State<changeNewPinScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  TextEditingController newmpin = TextEditingController();
  TextEditingController confirmedmpin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor:
              isDark ? Colors.black : Colors.white, // or your desired color
          elevation: 0,
          scrolledUnderElevation: 0, // prevent shadow when scrolling
          surfaceTintColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.only(left: 0, top: 15.w),
            child: Text(
              "Change PIN",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: isDark ? Colors.white : Colors.black),
            ),
          ),
          leadingWidth: 32.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 0, top: 15.w),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDark ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    // Enter New MPIN Field
                    Text(
                      'Enter New MPIN',
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        controller: newmpin,
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
                          hintText: 'Enter MPIN',
                          hintStyle: TextStyle(
                              color: isDark
                                  ? Color(0xFFC9CACC)
                                  : Color(0xff6B7280),
                              fontSize: 15.sp),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Confirm New MPIN Field
                    Text(
                      'Confirm New MPIN',
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 54.h,
                      child: TextField(
                        controller: confirmedmpin,
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
                          hintText: 'Confirm MPIN',
                          hintStyle: TextStyle(
                              color: isDark
                                  ? Color(0xFFC9CACC)
                                  : Color(0xff6B7280),
                              fontSize: 15.sp),
                        ),
                      ),
                    ),
                    Spacer(),
                    constWidgets.greenButton("Continue"),
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
