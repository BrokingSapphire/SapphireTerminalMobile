import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapphire/main.dart';
import '../../utils/constWidgets.dart';
import 'NomineeScreen.dart';

class SignConfirmationScreen extends StatelessWidget {
  final Uint8List signatureBytes;

  const SignConfirmationScreen({required this.signatureBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            SizedBox(height: 24.h),
            Text(
              "Signature",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.h),

            // Display the Signature Image
            Container(
              width: double.infinity,
              height: 350.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.white24),
              ),
              child: signatureBytes.isNotEmpty
                  ? Image.memory(signatureBytes, fit: BoxFit.contain)
                  : Center(
                      child: Text("No Signature Found",
                          style: TextStyle(color: Colors.black))),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // Rounded corners
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  // Your action here
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Fit content size
                  children: [
                    Text(
                      "Redo",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 8), // Space between text and icon
                    SvgPicture.asset('assets/images/Redo.svg'),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Continue Button
            constWidgets.greenButton("Continue", onTap: () {
              navi(nomineeScreen(), context);
            }),
            SizedBox(
              height: 10.h,
            ),

            Center(
              child: constWidgets.needHelpButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
