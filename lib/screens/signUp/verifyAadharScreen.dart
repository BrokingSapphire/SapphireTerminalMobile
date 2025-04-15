import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/segmentSelectionScreen.dart';

import '../../utils/constWidgets.dart';

class VerifyAadharScreen extends StatefulWidget {
  const VerifyAadharScreen({super.key});

  @override
  State<VerifyAadharScreen> createState() => _VerifyAadharScreenState();
}

class _VerifyAadharScreenState extends State<VerifyAadharScreen> {
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
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            constWidgets.topProgressBar(1, 2, context),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Verify your Aadhar",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.h,
            ),
            Image.asset('assets/images/aadharcard.png'),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(6.r),
              ),
              height: 45.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/Info.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text("Your details are 100% safe with us")
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            constWidgets.greenButton("Proceed for KYC", onTap: () {
              navi(SegmentSelectionScreen(), context);
            }),
            SizedBox(height: 10.h),
            Center(child: constWidgets.needHelpButton(context)),
          ],
        ),
      ),
    );
  }
}
