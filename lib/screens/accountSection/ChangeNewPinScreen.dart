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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Change PIN",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
            ),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Color(0xff2F2F2F)),
              SizedBox(height: 20.h),

              // Enter New MPIN Field
              Text(
                'Enter New MPIN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 54.h,
                child: TextField(
                  controller: newmpin,
                  obscureText: _obscureText1,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xffC9CACC),
                        size: 18.sp,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: Colors.white, width: 2.w),
                    ),
                    hintText: 'Enter MPIN',
                    hintStyle:
                        TextStyle(color: Color(0xFFC9CACC), fontSize: 15.sp),
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              // Confirm New MPIN Field
              Text(
                'Confirm New MPIN',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 54.h,
                child: TextField(
                  controller: confirmedmpin,
                  obscureText: _obscureText2,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                      child: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xffC9CACC),
                        size: 18.sp,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(color: Colors.white, width: 2.w),
                    ),
                    hintText: 'Confirm MPIN',
                    hintStyle:
                        TextStyle(color: Color(0xFFC9CACC), fontSize: 15.sp),
                  ),
                ),
              ),
              Spacer(),
              constWidgets.greenButton("Continue"),
            ],
          ),
        ),
      ),
    );
  }
}
