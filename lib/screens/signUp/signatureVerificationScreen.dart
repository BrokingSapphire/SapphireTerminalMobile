import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/signCanvaScreen.dart';

import '../../utils/constWidgets.dart';

class signVerificationScreen extends StatelessWidget {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            constWidgets.topProgressBar(1, 7, context),
            SizedBox(
              height: 24.h,
            ),
            Text("Signature",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            Center(
                child: Image.asset(
                    "assets/images/signatureverificationpage.png",
                    height: 250.h)),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Color(0xff2f2f2f)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Seal the Deal with a Secure Digital Sign!",
                      style:
                          TextStyle(color: Color(0xffEBEEF5), fontSize: 12.sp)),
                  SizedBox(height: 8.h),
                  Text("✓  Legally Compliant & Secure.",
                      style:
                          TextStyle(color: Color(0xffC9CACC), fontSize: 12.sp)),
                  Text("✓  Fast & Convenient.",
                      style:
                          TextStyle(color: Color(0xffC9CACC), fontSize: 12.sp)),
                  Text("✓  Binding & Recognized.",
                      style:
                          TextStyle(color: Color(0xffC9CACC), fontSize: 12.sp)),
                ],
              ),
            ),
            Spacer(),
            constWidgets.greenButton("Continue", onTap: () {
              navi(SignCanvasScreen(), context);
            }),
            SizedBox(height: 10.h),
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }
}
