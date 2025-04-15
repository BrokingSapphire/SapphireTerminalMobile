import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/screens/signUp/eSignScreen.dart';
import 'package:sapphire/screens/signUp/nomineeDetailsScreen.dart';

import '../../main.dart';
import '../../utils/constWidgets.dart';
import 'SignCanvaScreen.dart';

class nomineeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              constWidgets.topProgressBar(1, 8, context),
              SizedBox(
                height: 24.h,
              ),
              Text("Add Nominees for your investment",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Image.asset("assets/images/nomineescreen.png", height: 250.h),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xff2f2f2f)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Secure Your Investments: Add a Nominee Today!",
                        style: TextStyle(
                            color: Color(0xffEBEEF5), fontSize: 12.sp)),
                    SizedBox(height: 8.h),
                    Text("✓  Easy asset transfer.",
                        style: TextStyle(
                            color: Color(0xffC9CACC), fontSize: 12.sp)),
                    Text("✓  Avoids legal hassles.",
                        style: TextStyle(
                            color: Color(0xffC9CACC), fontSize: 12.sp)),
                    Text("✓  Quick claim settlement.",
                        style: TextStyle(
                            color: Color(0xffC9CACC), fontSize: 12.sp)),
                  ],
                ),
              ),
              Spacer(),
              constWidgets.greenButton("Add Nominee", onTap: () {
                navi(NomineeDetailsScreen(), context);
              }),
              SizedBox(height: 10.h),
              Center(
                  child: TextButton(
                      onPressed: () {
                        navi(eSignScreen(), context);
                      },
                      child: Text("I don't want to add nominees",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600)))),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
