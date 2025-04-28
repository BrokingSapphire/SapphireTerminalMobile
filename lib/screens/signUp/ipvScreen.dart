import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/screens/signUp/selfieCameraScreen.dart';
import 'package:sapphire/screens/signUp/segmentSelectionScreen.dart';

import '../../main.dart';
import '../../utils/constWidgets.dart';

class ipvScreen extends StatelessWidget {
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
            constWidgets.topProgressBar(1, 6, context),
            SizedBox(
              height: 24.h,
            ),
            Text("In-Person Verification (IPV)",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 12.h),
            Center(
                child:
                    Image.asset("assets/images/ipvscreen.png", height: 200.h)),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Info.svg",
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Flexible(
                      child: Text(
                        "Please take a photo where your face is clearly visible",
                        textAlign: TextAlign.left,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            constWidgets.greenButton("Continue", onTap: () {
              navi(SelfieVerificationScreen(), context);
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
