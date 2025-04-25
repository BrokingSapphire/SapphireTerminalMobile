import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/accountSection/ChangeNewPinScreen.dart';

import '../../utils/constWidgets.dart';

class changePinScreen extends StatefulWidget {
  @override
  _changePinScreenState createState() => _changePinScreenState();
}

class _changePinScreenState extends State<changePinScreen> {
  bool _obscureText = true;
  TextEditingController oldmpin = TextEditingController();

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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              Divider(color: isDark ? Color(0xff2F2F2F) : Color(0xffD1D5DB)),
              Expanded(
                // ✅ Fix: Make column scrollable/flexible
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        'Enter Old MPIN',
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 54.h,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: oldmpin,
                          obscureText: _obscureText,
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
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
                      SizedBox(height: 10.h),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            navi(changeNewPinScreen(), context);
                          },
                          child: Text('Forget MPIN?',
                              style: TextStyle(
                                  color:
                                      isDark ? Color(0xFFEBEEF5) : Colors.black,
                                  fontSize: 15.sp,
                                  decoration: TextDecoration.underline)),
                        ),
                      ),
                      const Spacer(), // ✅ Now it's safe here inside Expanded
                      constWidgets.greenButton("Continue", onTap: () {
                        navi(changeNewPinScreen(), context);
                      }),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
