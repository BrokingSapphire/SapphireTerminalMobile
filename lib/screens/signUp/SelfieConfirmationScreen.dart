import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/signatureVerificationScreen.dart';

class SelfieConfirmationScreen extends StatelessWidget {
  final String imagePath;

  SelfieConfirmationScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Selfie Verification",
              style: TextStyle(color: Colors.white, fontSize: 20.sp)),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                // Instruction Text
                Text(
                  "Click Continue to Confirm",
                  style: TextStyle(color: Colors.white, fontSize: 24.sp),
                ),

                SizedBox(height: 20.h),

                // Display Captured Image
                Center(
                  child: Container(
                    width: 320.w,
                    height: 320.h, // Square shape
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 3.w), // White border
                      borderRadius:
                          BorderRadius.circular(8.r), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(File(imagePath), fit: BoxFit.cover),
                    ),
                  ),
                ),

                const Spacer(),
                // Retake & Continue Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6.r)),
                          height: 46.h,
                          child: const Center(
                            child: Text('Retake'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          navi(signVerificationScreen(), context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6.r)),
                          height: 46.h,
                          child: const Center(
                            child: Text('Continue'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
