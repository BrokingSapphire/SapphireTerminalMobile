import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../utils/constWidgets.dart';

class manual2faScreen extends StatefulWidget {
  const manual2faScreen({super.key});

  @override
  State<manual2faScreen> createState() => _manual2faScreenState();
}

class _manual2faScreenState extends State<manual2faScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black, // or your desired color
        elevation: 0,
        scrolledUnderElevation: 0, // prevent shadow when scrolling
        surfaceTintColor: Colors.transparent,
                leadingWidth: 32.w,

        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Two Factor Authentication",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
      ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                color: Color(0xff2F2F2F),
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color:
                      Color(0xff121413), // Background color for the container
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment
                          .centerLeft, // Aligns text to the start (left)
                      child: Text(
                        "Scan this QR in your authentication app to continue",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.asset("assets/images/QR.png", height: 150.h),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          color: Color(0xff2F2F2F),
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text('OR',
                              style: TextStyle(
                                  color: Color(0xffc9cacc), fontSize: 15.sp)),
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.grey.shade800,
                        )),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Align(
                      alignment: Alignment
                          .centerLeft, // Aligns text to the start (left)
                      child: Text(
                        "Type this code in your authenticator app",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Align(
                      alignment: Alignment
                          .centerLeft, // Aligns text to the start (left)
                      child: Text(
                        "GGH-678-HJI-OP3-458-FRD",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              Align(
                alignment:
                    Alignment.centerLeft, // Aligns text to the start (left)
                child: Text(
                  "Enter code here",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Center(
                child: Pinput(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Color(0xff2F2F2F)),
                    ),
                  ),
                  preFilledWidget: Container(
                    width: 10.w,
                    height: 2.h,
                    color: Colors.grey, // Small grey line inside box
                  ),
                  showCursor: false, // Hide blinking cursor
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
