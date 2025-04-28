import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../../utils/constWidgets.dart';
import 'congratulationsScreen.dart';

class eSignScreen extends StatefulWidget {
  @override
  _eSignScreenState createState() => _eSignScreenState();
}

class _eSignScreenState extends State<eSignScreen> {
  bool isChecked = true; // Checkbox state

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
            constWidgets.topProgressBar(1, 9, context),
            SizedBox(
              height: 24.h,
            ),
            Text(
              "Finish account set-up using Aadhar E-sign",
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 12.h),

            // Aadhar E-sign Image
            Image.asset("assets/images/esignscreen.png", height: 200.h),
            Spacer(),

            // Checkbox with text
            Row(
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (val) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    }),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Text(
                      "I would like to receive ECN and other communications via email.",
                      style: TextStyle(color: Colors.white, fontSize: 11.sp),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 12.h,
            ),
            // Proceed Button
            constWidgets.greenButton("Proceed to Aadhar E-sign", onTap: () {
              navi(CongratulationsScreen(), context);
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
