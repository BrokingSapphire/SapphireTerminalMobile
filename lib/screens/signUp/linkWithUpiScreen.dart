import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapphire/main.dart';
import 'package:sapphire/screens/signUp/manualLinkingScreen.dart';

import '../../utils/constWidgets.dart';

class linkWithUpiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            constWidgets.topProgressBar(1, 5, context),
            SizedBox(
              height: 30.h,
            ),
            Text(
              "Link your bank account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Text(
              "By making a transaction of 1 INR",
              style: TextStyle(color: Colors.white70, fontSize: 15.sp),
            ),
            SizedBox(height: 20.h),

            Text(
                "• We'll automatically fetch your account name and number, so you don’t have to enter them manually saving you time and effort!",
                style: TextStyle(color: Colors.white70, fontSize: 15.sp)),
            SizedBox(height: 10.h),

            Text(
                "• Kindly make the payment from the bank account you’d like to link to your Sapphire account.",
                style: TextStyle(color: Colors.white70, fontSize: 15.sp)),
            SizedBox(height: 30.h),
            // UPI Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUPIButton("assets/images/phonepay.svg", "PhonePe"),
                _buildUPIButton("assets/images/gpay.svg", "GPay"),
                _buildUPIButton("assets/images/paytm.svg", "PayTM"),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  "  OR  ",
                  style: TextStyle(color: Color(0xFFC9CACC)),
                ),
                Expanded(child: Divider())
              ],
            ),
            SizedBox(height: 20.h),
            // Manual Linking Option
            Center(
              child: TextButton(
                onPressed: () {
                  navi(ManualLinkingScreen(), context);
                  // Navigate to manual linking screen
                },
                child: Text(
                  "Link bank account manually",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
            // Help Button
            Center(
              child: Center(child: constWidgets.needHelpButton(context)),
            ),
          ],
        ),
      ),
    );
  }

  // UPI Payment Option Widget
  Widget _buildUPIButton(String assetPath, String label) {
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child: SvgPicture.asset(
            assetPath,
          )), // UPI Logo
        ),
        SizedBox(height: 5.h),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 13.sp)),
      ],
    );
  }
}
